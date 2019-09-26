//
//  ReminderCell.swift
//  Trak
//
//  Created by Ben Patterson on 9/3/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

var reminderDatePicker = UIDatePicker()

class ReminderCell: UITableViewCell {

	let cellTitle: UILabel = {
		let title = UILabel()
		title.textColor = UIColor.trakLabel
		title.text = "Remind me on a day"
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let cellSwitch: UISwitch = {
		let cellSwitch = UISwitch()
		cellSwitch.translatesAutoresizingMaskIntoConstraints = false
		return cellSwitch
	}()
		
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		backgroundColor = UIColor.trakWhiteBackground
	}
	
	func setupConstraints() {
		addSubview(cellTitle)
		addSubview(cellSwitch)
		cellTitle.translatesAutoresizingMaskIntoConstraints = false
		cellTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
		cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
		cellTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
		
		cellSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
		cellSwitch.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class SetDateReminderCell: UITableViewCell {
	
	let reminderTitleLabel: UILabel = {
		let title = UILabel()
		title.textColor = UIColor.trakLabel
		title.text = "Set Reminder"
		title.textAlignment = .left
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let reminderResultLabel: UITextField = {
		let result = UITextField()
		result.textColor = UIColor.trakSecondaryLabel
		result.textAlignment = .right
		result.inputView = reminderDatePicker
		result.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		result.translatesAutoresizingMaskIntoConstraints = false
		return result
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		backgroundColor = UIColor.trakWhiteBackground
		reminderDatePicker.backgroundColor = UIColor.trakWhiteBackground
		reminderDatePicker.minimumDate = grabCurrentDate()
		reminderResultLabel.placeholder = grabCurrentDateString()
		
		if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
			reminderTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
			reminderResultLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
		} else if UIDevice.current.name == "iPhone 6" || UIDevice.current.name == "iPhone 7" || UIDevice.current.name == "iPhone 8" {
			reminderTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
			reminderResultLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		} else {
			reminderTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
			reminderResultLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		}
	}
	
	func grabCurrentDateString() -> String {
		let date = Date()
		let format = DateFormatter()
		format.dateFormat = "E, d MMM yyyy hh:mm a"
		let formattedDate = format.string(from: date)
		return formattedDate
	}
	
	func grabCurrentDate() -> Date {
		let date = Date()
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let formattedDate = format.string(from: date)
		guard let current = format.date(from: formattedDate) else { return Date() }
		return current
	}
	
	func setupConstraints() {
		addSubview(reminderTitleLabel)
		addSubview(reminderResultLabel)
		reminderTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		reminderTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
		reminderTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
		reminderTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
		reminderTitleLabel.trailingAnchor.constraint(equalTo: reminderResultLabel.leadingAnchor, constant: -8).isActive = true
		
		reminderResultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
		reminderResultLabel.centerYAnchor.constraint(equalTo: reminderTitleLabel.centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


