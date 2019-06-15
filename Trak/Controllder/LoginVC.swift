//
//  LoginVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
	
	let logo = LogoImageView()
	let stackView = OnboardingStackView(mainTitleText: "Log In to Trak", buttonTitleText: "Log In")
	let signUpTextButton = LabelAndButtonStackView(labelText: "Don't Have an Account?", buttonTitle: "Sign Up")
	let alert = UIAlertController(title: "Error Logging In", message: "We could not log you in, please try a different username or password and try again", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		addViews()
		alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
	}
	
	fileprivate func addViews() {
		view.addSubview(logo)
		view.addSubview(stackView)
		view.addSubview(signUpTextButton)
		logo.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
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
	
	@objc func loginButtonWasPressed() {
		stackView.button.loading()
		guard let email = stackView.email.textField.text, stackView.email.textField.text != nil else { return }
		guard let password = stackView.password.textField.text, stackView.password.textField.text != nil else { return }
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			if error == nil {
				let expenses = ExpensesVC()
				self.present(expenses, animated: true, completion: nil)
			} else {
				self.stackView.button.stopLoading(title: "Log In")
				self.present(self.alert, animated: true, completion: nil)
			}
		}
	}

}
