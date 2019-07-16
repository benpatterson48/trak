//
//  Expense.swift
//  Trak
//
//  Created by Ben Patterson on 7/15/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import Foundation

struct Expense {
	var amount: Double
	var category: String
	var date: Date
	var isPaid: Bool
	var name: String
	
	init(amount: Double, category: String, date: Date, isPaid: Bool, name: String) {
		self.amount = amount
		self.category = category
		self.date = date
		self.isPaid = isPaid
		self.name = name
	}
}
