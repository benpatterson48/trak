//
//  EmptyExpenseCell.swift
//  Trak
//
//  Created by Ben Patterson on 7/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class EmptyExpenseCell: UITableViewCell {
	
	let emptyIcon: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "unpaid-icon")
		image.contentMode = .scaleAspectFit
		image.heightAnchor.constraint(equalToConstant: 32).isActive = true
		image.widthAnchor.constraint(equalToConstant: 32).isActive = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let emptyLbl: UILabel = {
		let lbl = UILabel()
		lbl.textAlignment = .center
		lbl.textColor = UIColor.label
		lbl.font = UIFont.mainFont(ofSize: 16)
		lbl.text = "You currently don't have any expenses"
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: "empty")
		addViews()
		selectionStyle = .none
	}
	
	func addViews() {
		let stack = UIStackView(arrangedSubviews: [emptyIcon, emptyLbl])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillProportionally
		stack.alignment = .center
		stack.spacing = 10
		
		addSubview(stack)
		stack.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
		stack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
