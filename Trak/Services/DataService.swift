//
//  DataService.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DataService {
	var db = Firestore.firestore()
	static let instance = DataService()
	
	func getUserCategories(handler: @escaping (_ categoriesArray: [String]) -> ()) {
		var categoriesArray = [String]()
		guard let user = Auth.auth().currentUser else { return }
		let docRef = db.collection("users").document(user.uid)
		docRef.getDocument() { (document, error) in
			if let document = document {
				let property = document.get("categories")
				categoriesArray = property as? [String] ?? []
				handler(categoriesArray)
			} else {
				print("Document does not exist in cache")
			}
		}
	}
	
	func grabbingExpenses(completion: @escaping (_ unpaid: [Expense], _ paid: [Expense]) -> ()) {
		var unpaidExpenses = [Expense]()
		var paidExpenses = [Expense]()
		guard let user = Auth.auth().currentUser else {return}
		let docRef = db.collection("users").document(user.uid).collection("2019")
		docRef.getDocuments { (querySnapshot, err) in
			if let err = err {
				print("error: \(err)")
			} else if let querySnapshot = querySnapshot {
				for document in querySnapshot.documents {
					let results = document.data()
					for key in results.keys {
						if let name = results[key] as? [String:Any] {
							let title = name["name"] as? String ?? ""
							let category = name["category"] as? String ?? ""
							let amount = name["amount"] as? Double ?? 0
							let date = name["date"] as? Date ?? Date()
							let isPaid = name["isPaid"] as? Bool ?? false
							let expense = Expense(amount: amount, category: category, date: date, isPaid: isPaid, name: title)
							if expense.isPaid == false {
								unpaidExpenses.append(expense)
							} else if expense.isPaid == true {
								paidExpenses.append(expense)
							}
						}
					}
				}
				completion(unpaidExpenses, paidExpenses)
			}
		}
	}
	
	func calculatingExpenses(forExpensesArrayOf: [Expense]) -> Double {
		var expenseTotal = Double()
		for expense in forExpensesArrayOf {
			let total = expense.amount
			expenseTotal = expenseTotal + total
		}
		return expenseTotal
	}
	
	func calculatingTotalExpenses(withUnpaidTotal: Double, paidTotal: Double) -> Double {
		return withUnpaidTotal + paidTotal
	}

}
