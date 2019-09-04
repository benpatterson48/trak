//
//  SettingsCell.swift
//  Trak
//
//  Created by Ben Patterson on 8/26/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
	
	var setting: GenericCellInput? {
		didSet {
			guard let iconImageString = setting?.icon else {return}
			self.cellIcon.image = UIImage(named: iconImageString)
			
			guard let titleString = setting?.title else {return}
			self.cellTitle.text = titleString
		}
	}
	
	let cellIcon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let cellTitle: UILabel = {
		let title = UILabel()
		title.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let cellArrow: UIImageView = {
		let arrow = UIImageView()
		arrow.contentMode = .scaleAspectFit
		arrow.image = UIImage(named: "arrow")
		arrow.heightAnchor.constraint(equalToConstant: 30).isActive = true
		arrow.widthAnchor.constraint(equalToConstant: 30).isActive = true
		arrow.translatesAutoresizingMaskIntoConstraints = false
		return arrow
	}()
	
	lazy var cellStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [self.cellIcon, self.cellTitle])
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.alignment = .fill
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupConstraints() {
		addSubview(cellStack)
		addSubview(cellArrow)
		cellStack.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
		cellStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		cellStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
		
		cellArrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
		cellArrow.centerYAnchor.constraint(equalTo: cellStack.centerYAnchor).isActive = true
	}
	
}

class SettingsCellWithUISwitch: UITableViewCell {
	
	var setting: GenericCellInput? {
		didSet {
			guard let iconImageString = setting?.icon else {return}
			self.cellIcon.image = UIImage(named: iconImageString)
			
			guard let titleString = setting?.title else {return}
			self.cellTitle.text = titleString
		}
	}
	
	let cellIcon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let cellTitle: UILabel = {
		let title = UILabel()
		title.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let cellSwitch: UISwitch = {
		let cellSwitch = UISwitch()
		cellSwitch.translatesAutoresizingMaskIntoConstraints = false
		return cellSwitch
	}()
	
	lazy var cellStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [self.cellIcon, self.cellTitle])
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.alignment = .fill
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		cellSwitch.isOn = UserDefaults.standard.bool(forKey: "enabledFaceID")
	}
	
	func setupConstraints() {
		addSubview(cellStack)
		addSubview(cellSwitch)
		cellStack.translatesAutoresizingMaskIntoConstraints = false
		cellStack.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
		cellStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		cellStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
		
		cellSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
		cellSwitch.centerYAnchor.constraint(equalTo: cellStack.centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
}
