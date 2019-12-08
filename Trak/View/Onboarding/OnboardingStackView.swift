//
//  CreateAccountStackView.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class OnboardingStackView: UIView {
	
	let underline = Underline()
	let button = MainBlueButton()
	let email = UnderlineTextField(placeholder: "Email Address")
	let password = UnderlineTextField(placeholder: "Password")
	
	let mainTitle: UILabel = {
		let main = UILabel()
		main.textColor = UIColor.label
		main.textAlignment = .left
		main.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
		main.translatesAutoresizingMaskIntoConstraints = false
		return main
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		password.textField.isSecureTextEntry = true 
		button.translatesAutoresizingMaskIntoConstraints = false
		underline.translatesAutoresizingMaskIntoConstraints = false
	}
	
	public convenience init(mainTitleText: String, buttonTitleText: String) {
		self.init(frame: .zero)
		mainTitle.text = mainTitleText
		button.setTitle(buttonTitleText, for: .normal)
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
		
		button.heightAnchor.constraint(equalToConstant: 58).isActive = true
		button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
		button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
