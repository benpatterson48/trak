//
//  Date.swift
//  Trak
//
//  Created by Ben Patterson on 6/21/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension Date {
	var month: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM"
		return dateFormatter.string(from: self)
	}
	
	var day: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "d"
		return dateFormatter.string(from: self)
	}
	
	var year: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY"
		return dateFormatter.string(from: self)
	}
	
	var hour: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "hh"
		return dateFormatter.string(from: self)
	}
	
	var militaryHour: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH"
		return dateFormatter.string(from: self)
	}
	
	var minute: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "mm"
		return dateFormatter.string(from: self)
	}
}
