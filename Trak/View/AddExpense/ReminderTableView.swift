//
//  ReminderTableView.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ReminderTableView: UITableView {
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		register(ReminderSwitchCell.self, forCellReuseIdentifier: "RemindSwitch")
		register(SetReminderCell.self, forCellReuseIdentifier: "SetReminder")
		register(RepeatCell.self, forCellReuseIdentifier: "Repeat")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ReminderTableView: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "RemindSwitch")
			return cell
		} else if indexPath.row == 1 {
			let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SetReminder")
			
			return cell
		} else {
			let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Repeat")
			
			return cell
		}
	}
	
}
