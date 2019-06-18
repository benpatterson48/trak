//
//  AddExpenseStackView.swift
//  Trak
//
//  Created by Ben Patterson on 6/17/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class AddExpenseStackView: UIView {
	let nameField = UnderlineTextField(placeholder: "Payment Name")
	let totalField = UnderlineTextField(placeholder: "Payment Total")
	let dateField = UnderlineTextFieldWithIcon(placeholder: "Date", iconImage: "date")
	let categoryField = UnderlineTextFieldWithIcon(placeholder: "Category", iconImage: "down")
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
	}
	
	fileprivate func addViews() {
		let fieldsStackView = UIStackView(arrangedSubviews: [nameField, totalField, dateField, categoryField])
		fieldsStackView.translatesAutoresizingMaskIntoConstraints = false
		fieldsStackView.axis = .vertical
		fieldsStackView.distribution = .fillEqually
		fieldsStackView.spacing = 30
		addSubview(fieldsStackView)
		
		fieldsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		fieldsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		fieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		fieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true 
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
