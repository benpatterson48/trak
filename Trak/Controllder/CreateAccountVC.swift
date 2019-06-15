//
//  CreateAccountVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreateAccountVC: UIViewController {

	var ref: DocumentReference? = nil
	let db = Firestore.firestore()
	let logo = LogoImageView()
	let stackView = OnboardingStackView(mainTitleText: "Create your account", buttonTitleText: "Create Account")
	let signUpTextButton = LabelAndButtonStackView(labelText: "Already Have an Account?", buttonTitle: "Sign In")

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
		addViews()
		stackView.button.addTarget(self, action: #selector(createAccountButtonWasPressed), for: .touchUpInside)
		signUpTextButton.button.addTarget(self, action: #selector(signupButtonWasPressed), for: .touchUpInside)
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
	
	@objc func createAccountButtonWasPressed() {
		stackView.button.loading()
		guard let email = stackView.email.textField.text, stackView.email.textField.text != nil else { return }
		guard let password = stackView.password.textField.text, stackView.password.textField.text != nil else { return }
		Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
			if error == nil {
				print("✅✅✅ Account Created")
				self.addUserToDatabase(userEmail: email, userPassword: password)
				// segue to mainVC
			} else {
				self.stackView.button.stopLoading(title: "Create Account")
				print("❌❌❌ We had an error")
			}
		}
	}
	
	@objc func signupButtonWasPressed() {
		let login = LoginVC()
		present(login, animated: true, completion: nil)
	}
	
	fileprivate func addUserToDatabase(userEmail: String, userPassword: String) {
		guard let user = Auth.auth().currentUser else { return }
		db.collection("users").document(user.uid).setData([
			"email": userEmail,
			"password": userPassword
		]) { err in
			if let err = err {
				print("❌❌❌ Error writing document: \(err)")
			} else {
				print("✅✅✅ Document successfully written!")
			}
		}
	}

}
