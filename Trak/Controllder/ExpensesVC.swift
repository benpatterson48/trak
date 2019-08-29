//
//  ExpensesVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

var categoriesArray = ["All Categories"]

class ExpensesVC: UIViewController, UITextFieldDelegate {
	
	var categorySelected = String()
	var user: User?
	var category = String()
	var dataSource = DataSource()
	var specificCategory: Bool = false
	var unpaidExpenses = [Expense]()
	var paidExpenses = [Expense]()
	var specificCategoryUnpaidExpenses = [Expense]()
	var specificCategoryPaidExpenses = [Expense]()
	
	let date = Date()
	let cell = CategoryCell()
	let emptyState = EmptyState()
	let keyStack = TotalKeyView()
	let db = Firestore.firestore()
	let totalStack = TotalStackView()
	let monthInfo = MonthSwipeStack()
	let sectionNames: Array = ["", "UNPAID", "PAID"]
	
	let tableSectionHeader = ExpensesSectionHeader(reuseIdentifier: "header")
	let expenseHeader = ExpensesTableHeaderView(reuseIdentifier: "tableHeader")
	let header = HeaderWithLogo(leftIcon: UIImage(named: "menu")!, rightIcon: UIImage(named: "add")!)
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		checkForMonthExisting()
		grabExpenses()
		expenseHeader.categoryCollectionView.reloadData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addButtonTargets()
		view.backgroundColor = .white
		user = Auth.auth().currentUser
			
		expensesTableView.delegate = self
		expensesTableView.dataSource = self
				
		NotificationCenter.default.addObserver(self, selector: #selector(refreshList(notification:)), name:NSNotification.Name(rawValue: "refreshTable"), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(monthUpdatedReloadTable(notification:)), name:NSNotification.Name(rawValue: "monthUpdated"), object: nil)
	}
	
	@objc func monthUpdatedReloadTable(notification: NSNotification) {
		checkingExpensesForNewMonth()
		grabExpenses()
	}
	
	@objc func refreshList(notification: NSNotification){
		self.specificCategory = true
		self.specificCategoryUnpaidExpenses.removeAll()
		self.specificCategoryPaidExpenses.removeAll()
		if let dict = notification.userInfo as NSDictionary? {
			if let title = dict["name"] as? String {
				self.categorySelected = title
				if title == "All Categories" {
					self.specificCategoryUnpaidExpenses = self.unpaidExpenses
					self.specificCategoryPaidExpenses = self.paidExpenses
				} else {
					for expense in self.unpaidExpenses {
						if expense.category == title {
							self.specificCategoryUnpaidExpenses.append(expense)
						}
					}
					for expense in self.paidExpenses {
						if expense.category == title {
							self.specificCategoryPaidExpenses.append(expense)
						}
					}
				}
				DispatchQueue.main.async {
					self.expensesTableView.reloadData()
				}
			}
		}
	}
	
	func grabExpenses() {
		DataService.instance.grabbingExpenses(month: selectedMonth, year: selectedYear) { (unpaid, paid) in
			self.unpaidExpenses = unpaid
			self.paidExpenses = paid
			DispatchQueue.main.async {
				self.expensesTableView.reloadData()
			}
		}
	}

	fileprivate func addButtonTargets() {
		emptyState.button.addTarget(self, action: #selector(addNewPaymentButtonWasPressed), for: .touchUpInside)
		header.rightBarButtonItem.addTarget(self, action: #selector(addNewExpenseButtonWasPressed), for: .touchUpInside)
		header.leftBarButtonItem.addTarget(self, action: #selector(accountSettingsButtonWasPressed), for: .touchUpInside)
	}
	
	@objc func addNewExpenseButtonWasPressed() {
		let add = AddExpenseVC()
		presentFromRight(add)
	}
	
	@objc func addNewPaymentButtonWasPressed() {
		let newExpense = AddExpenseVC()
		present(newExpense, animated: true, completion: nil)
	}
	
	@objc func accountSettingsButtonWasPressed() {
		let setting = AccountSettingsVC()
		presentFromLeft(viewControllerToPresent: setting)
	}
	
	fileprivate func checkForMonthExisting() {
		let date = Date()
		let year = date.year
		db.collection("users").document(user?.uid ?? "").collection(year).getDocuments { (snapshot, error) in
			if let error = error {
				print(error)
			} else if let snapshot = snapshot, snapshot.isEmpty == false {
				self.addViews()
			} else if snapshot?.isEmpty == true {
				self.addEmptyStateViews()
			}
		}
	}
	
	fileprivate func checkExpensesArray() {
		let docRef = db.collection("users").document(user?.uid ?? "").collection(selectedYear).document(selectedMonth)
		docRef.getDocument() { (document, error) in
			if let document = document, document.exists == true {
				self.checkForEmptyArray()
				self.addViews()
				self.grabExpenses()
			} else {
				self.addEmptyStateViews()
			}
		}
	}
	
	func checkingExpensesForNewMonth() {
		let docRef = db.collection("users").document(user?.uid ?? "").collection(selectedYear).document(selectedMonth)
		docRef.getDocument() { (document, error) in
			if let document = document, document.exists == true {
				self.checkForEmptyArray()
				self.addViews()
				self.grabExpenses()
				DispatchQueue.main.async {
					self.monthInfo.monthTextField.text = selectedMonth.uppercased()
				}
			} else {
				self.header.removeFromSuperview()
				self.expensesTableView.removeFromSuperview()
				self.addEmptyStateViews()
				DispatchQueue.main.async {
					self.monthInfo.monthTextField.text = selectedMonth.uppercased()
				}
			}
		}
	}

	
	fileprivate func addViews() {
		view.addSubview(header)
		view.addSubview(monthInfo)
		view.addSubview(expensesTableView)
		header.translatesAutoresizingMaskIntoConstraints = false
		monthInfo.translatesAutoresizingMaskIntoConstraints = false
		expensesTableView.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		header.bottomAnchor.constraint(equalTo: monthInfo.topAnchor, constant: -16).isActive = true
		
		monthInfo.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16).isActive = true
		monthInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		monthInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		monthInfo.bottomAnchor.constraint(equalTo: expensesTableView.topAnchor, constant: 0).isActive = true 
		
		expensesTableView.topAnchor.constraint(equalTo: monthInfo.bottomAnchor, constant: 0).isActive = true
		expensesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		expensesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		expensesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	fileprivate func addEmptyStateViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(monthInfo)
		monthInfo.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(emptyState)
		emptyState.translatesAutoresizingMaskIntoConstraints = false
		addEmptyStateConstraints()
	}
	
	fileprivate func addEmptyStateConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		header.bottomAnchor.constraint(equalTo: monthInfo.topAnchor, constant: -16).isActive = true
		
		monthInfo.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16).isActive = true
		monthInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		monthInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -32).isActive = true
	}
	
	let expensesTableView: UITableView = {
		let tv = UITableView(frame: .zero, style: .plain)
		tv.bounces = false
		tv.separatorColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		tv.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		tv.alwaysBounceVertical = true
		tv.isUserInteractionEnabled = true
		tv.showsVerticalScrollIndicator = false
		tv.register(ExpenseCell.self, forCellReuseIdentifier: "expense")
		tv.register(EmptyExpenseCell.self, forCellReuseIdentifier: "empty")
		tv.register(ExpensesSectionHeader.self, forHeaderFooterViewReuseIdentifier: "header")
		tv.register(ExpensesTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "tableHeader")
		tv.translatesAutoresizingMaskIntoConstraints = false
		return tv
	}()

}

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if specificCategory {
			if section == 0 {
				return 0
			} else if section == 1 {
				return self.specificCategoryUnpaidExpenses.count
			} else {
				return self.specificCategoryPaidExpenses.count
			}
		} else {
			if section == 0 {
				return 0
			} else if section == 1 {
				return self.unpaidExpenses.count
			} else {
				return self.paidExpenses.count
			}
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "expense", for: indexPath) as? ExpenseCell else { return UITableViewCell() }
		if specificCategory {
			if indexPath.section == 1 {
				cell.icon.image = UIImage(named: "unpaid-icon")
				cell.expense = specificCategoryUnpaidExpenses[indexPath.item]
			} else if indexPath.section == 2 {
				cell.icon.image = UIImage(named: "paid-icon")
				cell.expense = specificCategoryPaidExpenses[indexPath.item]
			}
		} else {
			if indexPath.section == 1 {
				cell.icon.image = UIImage(named: "unpaid-icon")
				cell.expense = unpaidExpenses[indexPath.item]
			} else if indexPath.section == 2 {
				cell.icon.image = UIImage(named: "paid-icon")
				cell.expense = paidExpenses[indexPath.item]
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if section == 0 {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "tableHeader") as? ExpensesTableHeaderView else {return nil}
			if specificCategory {
				header.calculate(unpaid: self.specificCategoryUnpaidExpenses, paid: self.specificCategoryPaidExpenses)
			} else {
				header.calculate(unpaid: self.unpaidExpenses, paid: self.paidExpenses)
			}
			return header
		} else {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ExpensesSectionHeader else {return nil}
			header.label.attributedText = sectionNames[section].increaseLetterSpacing()
			header.contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
			return header
		}
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == 0 {
			return 450
		} else {
			return 50
		}
	}
	
	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let current = Date()
		let user = Auth.auth().currentUser
		let month = current.month
		let year = current.year
		let cell = tableView.cellForRow(at: indexPath) as? ExpenseCell
		
		let action = UIContextualAction(style: .normal, title: "Mark as Paid") { (action, view, handler) in
			handler(true)
			guard let name = cell?.expense?.name else {return}
			guard var expenseSelected = cell?.expense else {return}
			if self.specificCategory == false {
				self.unpaidExpenses.remove(at: indexPath.row)
				self.paidExpenses.insert(expenseSelected, at: 0)
			} else {
				self.unpaidExpenses.remove(at: indexPath.row)
				self.paidExpenses.insert(expenseSelected, at: 0)
				self.specificCategoryUnpaidExpenses.remove(at: indexPath.row)
				self.specificCategoryPaidExpenses.insert(expenseSelected, at: 0)
			}
			tableView.performBatchUpdates({
				cell?.icon.image = UIImage(named: "paid-icon")
				expenseSelected.isPaid = true
				self.moveUnpaidToPaid(userID: user?.uid ?? "", year: year, month: month, name: name)
				tableView.moveRow(at: .init(row: indexPath.row, section: 1), to: .init(row: 0, section: 2))
			}, completion: { (success) in
				if success {
					DispatchQueue.main.async {
						self.grabExpenses()
					}
				}
				else {
					print("error)")
				}
			})
		}
		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3529411765, blue: 1, alpha: 1)
		if cell?.expense?.isPaid == false {
			let configuration = UISwipeActionsConfiguration(actions: [action])
			return configuration
		} else {
			let configuration = UISwipeActionsConfiguration(actions: [])
			return configuration
		}
	}
	
	func moveUnpaidToPaid(userID: String, year: String, month: String, name: String) {
		self.db.collection("users").document(userID).collection(year).document(month).updateData([
			"\(name).isPaid": true,
		]) { err in
			if let err = err {
				print("Error updating document: \(err)")
			} else {
				print("Document successfully updated")
			}
		}
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let expenseCell = tableView.cellForRow(at: indexPath) as? ExpenseCell
		guard let expense = expenseCell?.expense else { return nil }
		let expenseName = expenseCell?.expenseTitle.text
		let current = Date()
		let year = current.year
		let month = current.month
		
		guard let user = Auth.auth().currentUser else { return nil }
		
		let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
			handler(true)
			let edit = EditExpenseVC()
			edit.initData(expense: expense)
			self.present(edit, animated: true, completion: nil)
		}
		
		let action2 = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			handler(true)
			self.db.collection("users").document(user.uid).collection(year).document(month).updateData([
				expenseName ?? "" : FieldValue.delete(),
			]) { err in
				if let err = err {
					print("Error updating document: \(err)")
				} else {
					if self.specificCategory == false {
						if expense.isPaid == true {
							self.paidExpenses.remove(at: indexPath.row)
							self.checkForEmptyArray()
						} else {
							self.unpaidExpenses.remove(at: indexPath.row)
							self.checkForEmptyArray()
						}
					} else {
						if expense.isPaid == true {
							self.specificCategoryPaidExpenses.remove(at: indexPath.row)
							self.checkForEmptyArray()
						} else {
							self.specificCategoryUnpaidExpenses.remove(at: indexPath.row)
							self.checkForEmptyArray()
						}
					}
					tableView.reloadData()
				}
			}
		}
		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 1)
		action2.backgroundColor = .red
		let configuration = UISwipeActionsConfiguration(actions: [action2, action])
		return configuration
	}
	
	func checkForEmptyArray() {
		if self.specificCategoryPaidExpenses.isEmpty == true && self.specificCategoryUnpaidExpenses.isEmpty == true && self.unpaidExpenses.isEmpty == true && self.paidExpenses.isEmpty == true {
			let date = Date()
			let year = date.year
			let month = date.month
			self.db.collection("users").document(self.user?.uid ?? "").collection(year).document(month).delete()
			self.header.removeFromSuperview()
			self.expensesTableView.removeFromSuperview()
			self.addEmptyStateViews()
		} else {
			return
		}
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
}
