//
//  LoginVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import DAKeychain
import FirebaseAuth

class LoginVC: UIViewController {
	
	var touchMe = BiometricIDAuth()
	
	let logo = LogoImageView()
	let stackView = OnboardingStackView(mainTitleText: "Log In to Trak", buttonTitleText: "Log In")
	let signUpTextButton = LabelAndButtonStackView(labelText: "Don't Have an Account?", buttonTitle: "Sign Up")
	let alert = UIAlertController(title: "Error Logging In", message: "We could not log you in, please try a different username or password and try again", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.systemBackground
		addViews()
		setDoneOnKeyboard()
		alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
		stackView.button.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
		signUpTextButton.button.addTarget(self, action: #selector(signupButtonWasPressed), for: .touchUpInside)
		let tap = UITapGestureRecognizer(target: self, action: #selector(viewTappedToCloseOut))
		view.addGestureRecognizer(tap)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let touchBool = touchMe.canEvaluatePolicy()
		if touchBool {
			if UserDefaults.standard.bool(forKey: "enabledFaceID") == true {
				biometricAuthImageBtnWasPressed()
			}
		}
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
	
	@objc func viewTappedToCloseOut() {
		view.endEditing(true)
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
				DAKeychain.shared["keychainEmail"] = email
				DAKeychain.shared["keychainPassword"] = password
				let expenses = ExpensesVC()
				expenses.modalPresentationStyle = .currentContext
				self.present(expenses, animated: true, completion: nil)
			} else {
				self.stackView.button.stopLoading(title: "Log In")
				self.present(self.alert, animated: true, completion: nil)
				self.stackView.email.textField.text = ""
				self.stackView.password.textField.text = "" 
			}
		}
	}
	
	func biometricAuthImageBtnWasPressed() {
		touchMe.authenticateUser() { [weak self] message in
			if let message = message {
				let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
				let okAction = UIAlertAction(title: "Darn!", style: .default)
				alertView.addAction(okAction)
			} else {
				guard let email = DAKeychain.shared["keychainEmail"] else { return }
				guard let password = DAKeychain.shared["keychainPassword"] else { return }
				self?.stackView.email.textField.text = DAKeychain.shared["keychainEmail"]
				self?.stackView.password.textField.text = DAKeychain.shared["keychainPassword"]
				DispatchQueue.main.async {
					Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
						if error == nil {
							let expenses = ExpensesVC()
							expenses.modalPresentationStyle = .currentContext
							self?.present(expenses, animated: true, completion: nil)
						} else {
							self?.stackView.button.stopLoading(title: "Log In")
							self?.present(self!.alert, animated: true, completion: nil)
						}
					}
				}
			}
		}
	}
	
	@objc func signupButtonWasPressed() {
		let signup = CreateAccountVC()
		signup.modalPresentationStyle = .currentContext
		present(signup, animated: true, completion: nil)
	}
	
	func setDoneOnKeyboard() {
		let email = stackView.email.textField
		let password = stackView.password.textField
		let keyboardToolbar = UIToolbar()
		keyboardToolbar.sizeToFit()
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
		keyboardToolbar.items = [flexBarButton, doneBarButton]
		email.inputAccessoryView = keyboardToolbar
		password.inputAccessoryView = keyboardToolbar
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}

}
