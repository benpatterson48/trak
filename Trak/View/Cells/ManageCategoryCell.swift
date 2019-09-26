//
//  ManageCategoryCell.swift
//  Trak
//
//  Created by Ben Patterson on 9/4/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ManageCategoryCell: UITableViewCell {
	
	let categoryNameLabel: UILabel = {
		let name = UILabel()
		name.textColor = UIColor.trakLabel
		name.textAlignment = .left
		name.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addConstraints()
		
		selectionStyle = .none
		backgroundColor = UIColor.trakWhiteBackground
	}
	
	func addConstraints() {
		addSubview(categoryNameLabel)
		
		categoryNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
		categoryNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
		categoryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
		categoryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
