//
//  UnderlineTextField.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class UnderlineTextField: UIView {
	
	let textField: UITextField = {
		let tf = UITextField()
		tf.borderStyle = .none
		tf.textColor = UIColor.label
		tf.font  = UIFont.mainFont(ofSize: 18)
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	let underlineView: UIView = {
		let uv = UIView()
		uv.backgroundColor = UIColor.separator
		uv.heightAnchor.constraint(equalToConstant: 2).isActive = true
		uv.translatesAutoresizingMaskIntoConstraints = false
		return uv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
	}
	
	public convenience init(placeholder: String) {
		self.init(frame: .zero)
		textField.placeholder = placeholder
	}
	
	fileprivate func createStackView() {
		let stackView = UIStackView(arrangedSubviews: [textField, underlineView])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 12
		addSubview(stackView)
		
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class UnderlineTextFieldWithIcon: UIView {
	let icon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
		icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
		return icon
	}()
	
	let textField: UITextField = {
		let tf = UITextField()
		tf.borderStyle = .none
		tf.textColor = UIColor.label
		tf.font  = UIFont.mainFont(ofSize: 18)
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	let underlineView: UIView = {
		let uv = UIView()
		uv.backgroundColor = UIColor.separator
		uv.heightAnchor.constraint(equalToConstant: 2).isActive = true
		uv.translatesAutoresizingMaskIntoConstraints = false
		return uv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
	}
	
	public convenience init(placeholder: String, iconImage: String) {
		self.init(frame: .zero)
		textField.placeholder = placeholder
		icon.image = UIImage(named: iconImage)
	}
	
	fileprivate func createStackView() {
		let stackView = UIStackView(arrangedSubviews: [textField, icon])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let stacked = UIStackView(arrangedSubviews: [stackView, underlineView])
		stacked.translatesAutoresizingMaskIntoConstraints = false
		stacked.axis = .vertical
		stacked.distribution = .fillProportionally
		stacked.spacing = 12
		stacked.alignment = .leading
		addSubview(stacked)
		
		underlineView.leadingAnchor.constraint(equalTo: stacked.leadingAnchor).isActive = true
		underlineView.trailingAnchor.constraint(equalTo: stacked.trailingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: stacked.trailingAnchor, constant: -24).isActive = true
		stacked.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stacked.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stacked.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stacked.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
