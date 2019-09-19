//
//  ExpensesHeader.swift
//  Trak
//
//  Created by Ben Patterson on 7/2/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpensesSectionHeader: UITableViewHeaderFooterView {
	
	static let myReuseIdentifier = "header"
	
	let label: UILabel = {
		let label = UILabel()
		label.textColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 0.8)
		label.numberOfLines = 0
		label.textAlignment = .left
		label.font = UIFont.mainBoldFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(label)
		addLabelConstraints()
	}
	
	private func addLabelConstraints() {
		label.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
		label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true 
		label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class ExpensesSectionFooter: UITableViewHeaderFooterView {
	
	static let myReuseIdentifier = "footer"
	
	let label: UILabel = {
		let label = UILabel()
		label.textColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 0.8)
		label.numberOfLines = 0
		label.textAlignment = .left
		label.font = UIFont.mainFont(ofSize: 15)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(label)
		addLabelConstraints()
	}
	
	private func addLabelConstraints() {
		label.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
		label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
		label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
