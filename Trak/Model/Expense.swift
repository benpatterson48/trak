//
//  Expense.swift
//  Trak
//
//  Created by Ben Patterson on 7/15/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Expense {
	var amount: Double
	var timestamp: Timestamp
	var category: String
	var date: Date
	var isPaid: Bool
	var name: String
	var reminderString: String
	
	init(amount: Double, timestamp: Timestamp, category: String, date: Date, isPaid: Bool, name: String, reminderString: String) {
		self.amount = amount
		self.timestamp = timestamp
		self.category = category
		self.date = date
		self.isPaid = isPaid
		self.name = name
		self.reminderString = reminderString
	}
}
