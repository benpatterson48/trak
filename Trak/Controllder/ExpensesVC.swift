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
protocol ChangedCategory {
	func categoryChanged(category: String) -> String
}

class ExpensesVC: UIViewController {
	
	var category = String()
	var dataSource = DataSource()
	var specificCategory: Bool = false
	var unpaidExpenses = [Expense]()
	var paidExpenses = [Expense]()
	var specificCategoryUnpaidExpenses = [Expense]()
	var specificCategoryPaidExpenses = [Expense]()
	
	let cell = CategoryCell()
	let emptyState = EmptyState()
	let keyStack = TotalKeyView()
	let db = Firestore.firestore()
	let totalStack = TotalStackView()
	let sectionNames: Array = ["", "UNPAID", "PAID"]
	let tableSectionHeader = ExpensesSectionHeader(reuseIdentifier: "header")
	let expenseHeader = ExpensesTableHeaderView(reuseIdentifier: "tableHeader")
	let header = HeaderWithLogo(leftIcon: UIImage(named: "menu")!, rightIcon: UIImage(named: "add")!)

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		checkExpensesArray()
		grabExpenses()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		addButtonTargets()
		view.backgroundColor = .white
		expensesTableView.delegate = self
		expensesTableView.dataSource = self
		NotificationCenter.default.addObserver(self, selector: #selector(refreshList(notification:)), name:NSNotification.Name(rawValue: "refreshTable"), object: nil)
	}
	
	@objc func refreshList(notification: NSNotification){
		self.specificCategory = true
		self.specificCategoryUnpaidExpenses.removeAll()
		self.specificCategoryPaidExpenses.removeAll()
		if let dict = notification.userInfo as NSDictionary? {
			if let title = dict["name"] as? String {
				self.unpaidExpenses = dataSource.unpaidExpenses
				self.paidExpenses = dataSource.paidExpenses
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
//					self.expenseHeader.calculate(unpaid: self.specificCategoryUnpaidExpenses, paid: self.specificCategoryPaidExpenses)
					self.expensesTableView.reloadData()
				}
			}
		}
	}


	func grabExpenses() {
		DataService.instance.grabbingExpenses { (unpaid, paid) in
			self.unpaidExpenses = unpaid
			self.paidExpenses = paid
			self.expensesTableView.reloadData()
		}
	}

	fileprivate func addButtonTargets() {
		emptyState.button.addTarget(self, action: #selector(addNewPaymentButtonWasPressed), for: .touchUpInside)
		header.rightBarButtonItem.addTarget(self, action: #selector(addNewExpenseButtonWasPressed), for: .touchUpInside)
	}
	
	@objc func addNewExpenseButtonWasPressed() {
		let newExpense = AddExpenseVC()
		present(newExpense, animated: true, completion: nil)
	}
	
	@objc func addNewPaymentButtonWasPressed() {
		let add = AddExpenseVC()
		present(add, animated: true, completion: nil)
	}
	
	fileprivate func checkExpensesArray() {
		let current = Date()
		let year = current.year
		guard let user = Auth.auth().currentUser else { return }
		db.collection("users").document(user.uid).collection(year).getDocuments { (documents, error) in
			if let documents = documents, documents.isEmpty == false {
				self.addViews()
			} else {
				self.addEmptyStateViews()
			}
		}
	}
	
	fileprivate func addViews() {
		view.addSubview(header)
		view.addSubview(expensesTableView)
		header.translatesAutoresizingMaskIntoConstraints = false
		expensesTableView.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		header.bottomAnchor.constraint(equalTo: expensesTableView.topAnchor, constant: 0).isActive = true

		expensesTableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
		expensesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		expensesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		expensesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}
	
	fileprivate func addEmptyStateViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(emptyState)
		emptyState.translatesAutoresizingMaskIntoConstraints = false
		addEmptyStateConstraints()
	}
	
	fileprivate func addEmptyStateConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -32).isActive = true
	}
	
	let expensesTableView: UITableView = {
		let tv = UITableView(frame: .zero, style: .plain)
		tv.separatorColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		tv.backgroundColor = .white
		tv.alwaysBounceVertical = true
		tv.isUserInteractionEnabled = true
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
				if self.specificCategoryUnpaidExpenses.count == 0 {
					return 1
				} else {
					return self.specificCategoryUnpaidExpenses.count
				}
			} else {
				if self.specificCategoryPaidExpenses.count == 0 {
					return 1
				} else {
					return self.specificCategoryPaidExpenses.count
				}
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
				if self.specificCategoryUnpaidExpenses.count == 0 {
					guard let empty = tableView.dequeueReusableCell(withIdentifier: "empty") as? EmptyExpenseCell else {return UITableViewCell()}
					return empty
				} else {
					cell.icon.image = UIImage(named: "unpaid-icon")
					cell.expense = specificCategoryUnpaidExpenses[indexPath.item]
				}
			} else if indexPath.section == 2 {
				if self.specificCategoryPaidExpenses.count == 0 {
					guard let empty = tableView.dequeueReusableCell(withIdentifier: "empty") as? EmptyExpenseCell else {return UITableViewCell()}
					return empty
				} else {
					cell.icon.image = UIImage(named: "paid-icon")
					cell.expense = specificCategoryPaidExpenses[indexPath.item]
				}
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
		let action = UIContextualAction(style: .normal, title: "Mark as Paid") { (action, view, handler) in
			handler(true)
			// Paid/ Unpaid -- mark as paid/ unpaid depending on what it is now
		}
		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3529411765, blue: 1, alpha: 1)
		let configuration = UISwipeActionsConfiguration(actions: [action])
		return configuration
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
			handler(true)
			// Edit -- bring up the addexpense VC to edit the action
		}
		let action2 = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			handler(true)
			// Delete -- delete from the DB and reload the table
		}
		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 1)
		action2.backgroundColor = .red
		let configuration = UISwipeActionsConfiguration(actions: [action2, action])
		return configuration
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
}
