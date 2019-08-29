//
//  MonthPickerView.swift
//  Trak
//
//  Created by Ben Patterson on 8/21/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

let barAccessory = UIToolbar()
var monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
class MonthPickerView: UIPickerView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
		backgroundColor = .white
		
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changeMonth))
		let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
		
		barAccessory.sizeToFit()
		barAccessory.barStyle = .default
		barAccessory.isTranslucent = false
		barAccessory.isUserInteractionEnabled = true
		barAccessory.items = [cancelButton, spaceButton, doneButton]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func changeMonth() {
		print("Change Month Pressed")
		self.resignFirstResponder()
	}
	
}

extension MonthPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return monthArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return monthArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let month = MonthSwipeStack()
		let monthTitle = month.monthTextField
		monthTitle.text = "New Month"
		selectedMonth = monthArray[row]
	}
}
