//
//  ExpenseCell.swift
//  Trak
//
//  Created by Ben Patterson on 7/1/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {
	
	let icon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let expenseTitle: UILabel = {
		let title = UILabel()
		title.textAlignment = .left
		title.textColor = UIColor.main.darkText
		title.font = UIFont.mainFont(ofSize: 16)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let dueDateLabel: UILabel = {
		let due = UILabel()
		due.textAlignment = .left
		due.textColor = UIColor.main.lightText
		due.font = UIFont.mainFont(ofSize: 16)
		due.translatesAutoresizingMaskIntoConstraints = false
		return due
	}()
	
	let dueAmountLabel: UILabel = {
		let title = UILabel()
		title.textAlignment = .right
		title.textColor = UIColor.main.darkText
		title.font = UIFont.mainFont(ofSize: 16)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let categoryLabel: UILabel = {
		let due = UILabel()
		due.textAlignment = .right
		due.textColor = UIColor.main.lightText
		due.font = UIFont.mainFont(ofSize: 16)
		due.translatesAutoresizingMaskIntoConstraints = false
		return due
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: "expense")
		addViews()
		selectionStyle = .none
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addViews() {
		let leftStack = UIStackView(arrangedSubviews: [expenseTitle, dueDateLabel])
		leftStack.translatesAutoresizingMaskIntoConstraints = false
		leftStack.axis = .vertical
		leftStack.distribution = .fillEqually
		leftStack.alignment = .leading
		leftStack.spacing = 5
		
		let rightStack = UIStackView(arrangedSubviews: [dueAmountLabel, categoryLabel])
		rightStack.translatesAutoresizingMaskIntoConstraints = false
		rightStack.axis = .vertical
		rightStack.distribution = .fillEqually
		rightStack.alignment = .trailing
		rightStack.spacing = 5
		
		addSubview(icon)
		addSubview(leftStack)
		addSubview(rightStack)

		icon.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
		icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
		icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true

		leftStack.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16).isActive = true
		leftStack.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
		leftStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
		
		rightStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
		rightStack.topAnchor.constraint(equalTo: topAnchor, constant: 18).isActive = true
		rightStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18).isActive = true
	}
}
