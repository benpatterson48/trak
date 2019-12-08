//
//  LabelAndButtonStackView.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class LabelAndButtonStackView: UIView {
	
	let label: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = UIColor.label
		label.font = UIFont.systemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let button: UIButton = {
		let button = UIButton()
		button.setTitleColor(UIColor.systemBlue, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraints()
	}
	
	public convenience init(labelText: String, buttonTitle: String) {
		self.init(frame: .zero)
		label.text = labelText
		button.setTitle(buttonTitle, for: .normal)
	}
	
	fileprivate func setupConstraints() {
		let stackView = UIStackView(arrangedSubviews: [label, button])
		stackView.distribution = .fillProportionally
		stackView.alignment = .fill
		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(stackView)
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
