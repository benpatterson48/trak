//
//  MonthDatePicker.swift
//  Trak
//
//  Created by Ben Patterson on 7/10/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import TLMonthYearPicker

class MonthDatePicker: UIDatePicker {
	override init(frame: CGRect) {
		super.init(frame: frame)
		timeZone = NSTimeZone.local
		backgroundColor = UIColor.white
		datePickerMode = .date
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
