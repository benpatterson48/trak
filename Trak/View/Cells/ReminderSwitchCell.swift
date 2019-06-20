//
//  ReminderSwitchCell.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ReminderSwitchCell: UITableViewCell {
	
	let remindLabel = MainLabel(title: "Remind me on a day")
	let switchControl = UISwitch()

    override func awakeFromNib() {
        super.awakeFromNib()
		createStackView()
	}

	fileprivate func createStackView() {
		let stack = UIStackView(arrangedSubviews: [remindLabel, switchControl])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = .fillProportionally
		addSubview(stack)
		
		stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}

}
