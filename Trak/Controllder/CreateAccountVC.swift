//
//  CreateAccountVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
	
	let logo = LogoImageView()
	let stackView = CreateAccountStackView()
	let signUpTextButton = LabelAndButtonStackView(labelText: "Already Have an Account?", buttonTitle: "Sign In")

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		addViews()
    }

	fileprivate func addViews() {
		view.addSubview(logo)
		view.addSubview(signUpTextButton)
		logo.translatesAutoresizingMaskIntoConstraints = false
		signUpTextButton.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
		logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signUpTextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
		signUpTextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
		addStackView()
	}
	
	fileprivate func addStackView() {
		view.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false 
		stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
	}

}
