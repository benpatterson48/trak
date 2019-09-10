//
//  CategoryDataSource.swift
//  Trak
//
//  Created by Ben Patterson on 7/10/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

var selectedMonth = String()
var selectedYear = String()

class DataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

	var date = Date()
	var category = String()
	var specificCategory: Bool = false
	var unpaidExpenses = [Expense]()
	var paidExpenses = [Expense]()
	var specificCategoryUnpaidExpenses = [Expense]()
	var specificCategoryPaidExpenses = [Expense]()
	let sectionNames: Array = ["", "UNPAID", "PAID"]

	override init() {
		super.init()
		DispatchQueue.main.async {
			DataService.instance.getUserCategories { (returned) in
				categoriesArray.removeAll()
				categoriesArray.append("All Categories")
				categoriesArray.append(contentsOf: returned)
			}
		}
		if selectedMonth == "" {
			selectedMonth = date.month
		}
		if selectedYear == "" {
			selectedYear = date.year
		}
		grabExpenses()
	}
	func grabExpenses() {
		DataService.instance.grabbingExpenses(month: selectedMonth, year: selectedYear) { (unpaid, paid) in
			self.unpaidExpenses = unpaid
			self.paidExpenses = paid
		}
	}
	
	//CollectionView
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let indexSelected = IndexPath(item: indexPath.item, section: 0)
		let categoryName:[String: String] = ["name": categoriesArray[indexPath.item]]
		collectionView.selectItem(at: indexSelected, animated: true, scrollPosition: .centeredHorizontally)
		NotificationCenter.default.post(name: .init("refreshTable"), object: nil, userInfo: categoryName)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
		cell.categoryTitle.text = categoriesArray[indexPath.row]
		print("This is the indecx: \(indexPath.item) and it is selected: \(cell.isSelected)")
		return cell
	}

}
