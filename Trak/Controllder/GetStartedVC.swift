//
//  GetStartedVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class GetStartedVC: UIViewController {
	
	let logo = LogoImageView()
	let stackView = GetStartedStackView()
	let signUpTextButton = LabelAndButtonStackView(labelText: "Already Have an Account?", buttonTitle: "Sign In")

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white 
		addViews()
		stackView.button.addTarget(self, action: #selector(getStartedButtonWasPressed), for: .touchUpInside)
		signUpTextButton.button.addTarget(self, action: #selector(signinButtonWasPressed), for: .touchUpInside)
    }
	
	fileprivate func addViews() {
		view.addSubview(logo)
		view.addSubview(stackView)
		view.addSubview(signUpTextButton)
		logo.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		signUpTextButton.translatesAutoresizingMaskIntoConstraints = false
		setupConstraints()
	}
	
	fileprivate func setupConstraints() {
		logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
		logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signUpTextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
		signUpTextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
		
		stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true 
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
	}
	
	@objc func getStartedButtonWasPressed() {
		let signup = CreateAccountVC()
		present(signup, animated: true, completion: nil)
	}
	
	@objc func signinButtonWasPressed() {
		let login = LoginVC()
		present(login, animated: true, completion: nil)
	}

}
