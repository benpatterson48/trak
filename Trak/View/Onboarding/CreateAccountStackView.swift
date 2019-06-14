//
//  CreateAccountStackView.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class CreateAccountStackView: UIView {
	
	let underline = Underline()
	let button = MainBlueButton(title: "Create Account")
	let email = UnderlineTextField(placeholder: "Email Address")
	let password = UnderlineTextField(placeholder: "Password")
	
	let mainTitle: UILabel = {
		let main = UILabel()
		main.text = "Create your account"
		main.textColor = UIColor.main.darkText
		main.textAlignment = .left
		main.font = UIFont.mainSemiBoldFont(ofSize: 26)
		main.translatesAutoresizingMaskIntoConstraints = false
		return main
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		button.translatesAutoresizingMaskIntoConstraints = false
		underline.translatesAutoresizingMaskIntoConstraints = false
	}
	
	fileprivate func createStackView() {
		
		let titleStackView = UIStackView(arrangedSubviews: [mainTitle, underline])
		titleStackView.translatesAutoresizingMaskIntoConstraints = false
		titleStackView.axis = .vertical
		titleStackView.distribution = .fillProportionally
		titleStackView.spacing = 10
		
		let stackView = UIStackView(arrangedSubviews: [titleStackView, email, password])
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 30
		addSubview(stackView)
		addSubview(button)
		
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -35).isActive = true
		underline.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1/4).isActive = true
		
		button.heightAnchor.constraint(equalToConstant: 56).isActive = true
		button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
		button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
