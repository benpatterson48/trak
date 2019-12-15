//
//  SettingsCell.swift
//  Trak
//
//  Created by Ben Patterson on 8/26/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
	
	let cellConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 16, weight: .light), scale: .small)
	
	var setting: SettingsCellModel? {
		didSet {
			guard let iconImageString = setting?.icon else {return}
			self.cellIcon.image = UIImage(systemName: iconImageString)?.withTintColor(.white).withRenderingMode(.alwaysOriginal).withConfiguration(cellConfiguration)
			
			guard let titleString = setting?.title else {return}
			self.cellTitle.text = titleString
			
			guard let backgroundColor = setting?.backgroundColor else {return}
			self.cellIconBackground.backgroundColor = backgroundColor
		}
	}
	
	let cellIconBackground: UIView = {
		let bg = UIView()
		bg.layer.cornerRadius = 6
		bg.translatesAutoresizingMaskIntoConstraints = false
		
		bg.heightAnchor.constraint(equalToConstant: 27).isActive = true
		return bg
	}()
	
	let cellIcon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let cellTitle: UILabel = {
		let title = UILabel()
		title.textColor = UIColor.label
		title.textAlignment = .left
		title.font = UIFont.systemFont(ofSize: 16, weight: .light)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let cellArrow: UIImageView = {
		let arrow = UIImageView()
		arrow.contentMode = .scaleAspectFit
		arrow.translatesAutoresizingMaskIntoConstraints = false
		return arrow
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		selectionStyle = .none
		backgroundColor = UIColor.tertiarySystemBackground
		
		cellArrow.image = UIImage(systemName: "chevron.right")?.withTintColor(.secondaryLabel).withRenderingMode(.alwaysOriginal).withConfiguration(cellConfiguration)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupConstraints() {
		addSubview(cellTitle)
		addSubview(cellIconBackground)
		addSubview(cellArrow)
		cellIconBackground.addSubview(cellIcon)
		cellArrow.translatesAutoresizingMaskIntoConstraints = false
		cellIcon.translatesAutoresizingMaskIntoConstraints = false
		cellTitle.translatesAutoresizingMaskIntoConstraints = false
		cellIconBackground.translatesAutoresizingMaskIntoConstraints = false
		
		cellIconBackground.widthAnchor.constraint(equalToConstant: 27).isActive = true
		cellIconBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		cellIconBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
		
		cellIcon.centerYAnchor.constraint(equalTo: cellIconBackground.centerYAnchor).isActive = true
		cellIcon.centerXAnchor.constraint(equalTo: cellIconBackground.centerXAnchor).isActive = true
		
		cellTitle.leadingAnchor.constraint(equalTo: cellIconBackground.trailingAnchor, constant: 12).isActive = true
		cellTitle.trailingAnchor.constraint(equalTo: cellArrow.leadingAnchor, constant: -8).isActive = true 
		cellTitle.centerYAnchor.constraint(equalTo: cellIconBackground.centerYAnchor).isActive = true
		
		cellArrow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
		cellArrow.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor).isActive = true
	}
	
}

class SettingsCellWithUISwitch: UITableViewCell {
	
	let cellConfiguration = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 16, weight: .light), scale: .small)
	
	var setting: SettingsCellModel? {
		didSet {
			guard let iconImageString = setting?.icon else {return}
			self.cellIcon.image = UIImage(systemName: iconImageString)?.withTintColor(.white).withRenderingMode(.alwaysOriginal).withConfiguration(cellConfiguration)
			
			guard let titleString = setting?.title else {return}
			self.cellTitle.text = titleString
			
			guard let backgroundColor = setting?.backgroundColor else {return}
			self.cellIconBackground.backgroundColor = backgroundColor
		}
	}
	
	let cellIconBackground: UIView = {
		let bg = UIView()
		bg.layer.cornerRadius = 6
		bg.translatesAutoresizingMaskIntoConstraints = false
		
		bg.heightAnchor.constraint(equalToConstant: 27).isActive = true
		return bg
	}()
	
	let cellIcon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let cellTitle: UILabel = {
		let title = UILabel()
		title.textColor = UIColor.label
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
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
		backgroundColor = UIColor.tertiarySystemBackground
		cellSwitch.isOn = UserDefaults.standard.bool(forKey: "enabledFaceID")
	}
	
	func setupConstraints() {
		addSubview(cellTitle)
		addSubview(cellIconBackground)
		addSubview(cellSwitch)
		cellIconBackground.addSubview(cellIcon)
		cellSwitch.translatesAutoresizingMaskIntoConstraints = false
		cellIcon.translatesAutoresizingMaskIntoConstraints = false
		cellTitle.translatesAutoresizingMaskIntoConstraints = false
		cellIconBackground.translatesAutoresizingMaskIntoConstraints = false
		
		cellIconBackground.widthAnchor.constraint(equalToConstant: 27).isActive = true
		cellIconBackground.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		cellIconBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
		
		cellIcon.centerYAnchor.constraint(equalTo: cellIconBackground.centerYAnchor).isActive = true
		cellIcon.centerXAnchor.constraint(equalTo: cellIconBackground.centerXAnchor).isActive = true
		
		cellTitle.leadingAnchor.constraint(equalTo: cellIconBackground.trailingAnchor, constant: 12).isActive = true
		cellTitle.trailingAnchor.constraint(equalTo: cellSwitch.leadingAnchor, constant: -8).isActive = true
		cellTitle.centerYAnchor.constraint(equalTo: cellIconBackground.centerYAnchor).isActive = true
		
		cellSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
		cellSwitch.centerYAnchor.constraint(equalTo: cellTitle.centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
		
}
