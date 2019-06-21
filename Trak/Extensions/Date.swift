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
	
	var year: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY"
		return dateFormatter.string(from: self)
	}
}
