//
//  CategoryDataSource.swift
//  Trak
//
//  Created by Ben Patterson on 7/10/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class DataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

	var category = String()
	var specificCategory: Bool = false
	var unpaidExpenses = [Expense]()
	var paidExpenses = [Expense]()
	var specificCategoryUnpaidExpenses = [Expense]()
	var specificCategoryPaidExpenses = [Expense]()
	
	let sectionNames: Array = ["", "UNPAID", "PAID"]

	override init() {
		super.init()
		DataService.instance.getUserCategories { (returned) in
			categoriesArray.append(contentsOf: returned)
		}
		grabExpenses()
	}
	
	func grabExpenses() {
		DataService.instance.grabbingExpenses { (unpaid, paid) in
			self.unpaidExpenses = unpaid
			self.paidExpenses = paid
		}
	}
	
//	func reloadForSpecificCategory(category: String) {
//		self.specificCategoryPaidExpenses.removeAll()
//		self.specificCategoryUnpaidExpenses.removeAll()
//		for expense in self.unpaidExpenses {
//			if expense.category == category {
//				self.specificCategoryUnpaidExpenses.append(expense)
//			}
//		}
//		for expense in self.paidExpenses {
//			if expense.category == category {
//				self.specificCategoryPaidExpenses.append(expense)
//			}
//		}
//		let expense = ExpensesVC()
//		expense.initData(unpaid: self.specificCategoryUnpaidExpenses, paid: self.specificCategoryPaidExpenses)
//	}
	
	//CollectionView
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let categoryName:[String: String] = ["name": categoriesArray[indexPath.item]]
//		self.category = categoriesArray[indexPath.item]
		NotificationCenter.default.post(name: .init("refreshTable"), object: nil, userInfo: categoryName)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
		collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
		cell.categoryTitle.text = categoriesArray[indexPath.row]
		return cell
	}

}
	
	
	//TableView
//	func numberOfSections(in tableView: UITableView) -> Int {
//		return 3
//	}
//	
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if specificCategory {
//			if section == 0 {
//				return 0
//			} else if section == 1 {
//				return self.specificCategoryUnpaidExpenses.count
//			} else {
//				return self.specificCategoryPaidExpenses.count
//			}
//		} else {
//			if section == 0 {
//				return 0
//			} else if section == 1 {
//				return self.unpaidExpenses.count
//			} else {
//				return self.paidExpenses.count
//			}
//		}
//	}
//	
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: "expense", for: indexPath) as? ExpenseCell else { return UITableViewCell() }
//		if specificCategory {
//			if indexPath.section == 1 {
//				cell.icon.image = UIImage(named: "unpaid-icon")
//				cell.expense = specificCategoryUnpaidExpenses[indexPath.item]
//			} else if indexPath.section == 2 {
//				cell.icon.image = UIImage(named: "paid-icon")
//				cell.expense = specificCategoryPaidExpenses[indexPath.item]
//			}
//		} else {
//			if indexPath.section == 1 {
//				cell.icon.image = UIImage(named: "unpaid-icon")
//				cell.expense = unpaidExpenses[indexPath.item]
//			} else if indexPath.section == 2 {
//				cell.icon.image = UIImage(named: "paid-icon")
//				cell.expense = paidExpenses[indexPath.item]
//			}
//		}
//		return cell
//	}
//	
//	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		if section == 0 {
//			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "tableHeader") as? ExpensesTableHeaderView else { return nil }
//			return header
//		} else {
//			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ExpensesSectionHeader else { return nil }
//			header.label.attributedText = sectionNames[section].increaseLetterSpacing()
//			header.contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
//			return header
//		}
//	}
//	
//	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		if section == 0 {
//			return 450
//		} else {
//			return 50
//		}
//	}
//	
//	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		let action = UIContextualAction(style: .normal, title: "Mark as Paid") { (action, view, handler) in
//			handler(true)
//			// Paid/ Unpaid -- mark as paid/ unpaid depending on what it is now
//		}
//		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3529411765, blue: 1, alpha: 1)
//		let configuration = UISwipeActionsConfiguration(actions: [action])
//		return configuration
//	}
//	
//	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//		let action = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
//			handler(true)
//			// Edit -- bring up the addexpense VC to edit the action
//		}
//		let action2 = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
//			handler(true)
//			// Delete -- delete from the DB and reload the table
//		}
//		action.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 1)
//		action2.backgroundColor = .red
//		let configuration = UISwipeActionsConfiguration(actions: [action2, action])
//		return configuration
//	}
//	
//	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//		return true
//	}
//	
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		reloadForSpecificCategory(category: "Monthly")
//	}
//	
//}
