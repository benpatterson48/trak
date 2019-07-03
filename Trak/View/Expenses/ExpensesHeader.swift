//
//  ExpensesHeader.swift
//  Trak
//
//  Created by Ben Patterson on 7/2/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpensesHeader: UITableViewHeaderFooterView {
	
	static let myReuseIdentifier = "header"
	let label: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.main.darkText
		label.textAlignment = .left
		label.font = UIFont.mainBoldFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(label)
		addLabelConstraints()
		backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
	}
	
	private func addLabelConstraints() {
		label.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
		label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true 
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
