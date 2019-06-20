//
//  ExpenseDatePicker.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpenseDatePicker: UIDatePicker {
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
