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
		tf.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		tf.font  = UIFont.mainFont(ofSize: 16)
		tf.translatesAutoresizingMaskIntoConstraints = false
		return tf
	}()
	
	let underlineView: UIView = {
		let uv = UIView()
		uv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
		uv.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
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
		stackView.spacing = 10
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
