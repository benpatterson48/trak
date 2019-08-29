//
//  SettingsChangeVC.swift
//  Trak
//
//  Created by Ben Patterson on 8/27/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SettingsChangeVC: UIViewController {
	
	let success = UIAlertController(title: "✅ Success", message: "Information has been successfully udpated.", preferredStyle: .alert)
	let fail = UIAlertController(title: "❌ Error", message: "Sorry, something went wrong, please try again later", preferredStyle: .alert)
	let reauthenticateAlert = UIAlertController(title: "Are You Sure?", message: "Please enter your current password to continue", preferredStyle: .alert)
	
	var passwordInput = String()
	
	var topView: UIView = {
		let view = UIView()
		view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.968627451, alpha: 1)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var topViewTitleLabel: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = UIColor.main.darkText
		title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var topViewBackButton: UIButton = {
		let back = UIButton()
		back.contentMode = .scaleAspectFit
		back.translatesAutoresizingMaskIntoConstraints = false
		back.setBackgroundImage(UIImage(named: "back"), for: .normal)
		back.widthAnchor.constraint(equalToConstant: 20).isActive = true
		back.heightAnchor.constraint(equalToConstant: 20).isActive = true
		back.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		return back
	}()
	
	var textFieldBackground: UIView = {
		let background = UIView()
		background.backgroundColor = .white
		background.translatesAutoresizingMaskIntoConstraints = false
		return background
	}()
	
	var inputTextField: UITextField = {
		let input = UITextField()
		input.borderStyle = .none
		input.translatesAutoresizingMaskIntoConstraints = false
		return input
	}()
	
	@objc func dismissView() {
		dismissFromLeft()
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
		
		if self.topViewTitleLabel.text == "Email" {
			if inputTextField.text != nil && inputTextField.text != "" {
				present(reauthenticateAlert, animated: true, completion: nil)
			} else {
				// show incomplete error
			}
		} else if self.topViewTitleLabel.text == "Password" {
			if inputTextField.text != nil && inputTextField.text != "" {
				present(reauthenticateAlert, animated: true, completion: nil)
			} else {
				// show incomplete error
			}
		} else if self.topViewTitleLabel.text == "Year" {
			if inputTextField.text != nil && inputTextField.text != "" {
				//update year
			} else {
				// show incomplete error
			}
		} else {
			if inputTextField.text != nil && inputTextField.text != "" {
				// send bug to email
			} else {
				// show incomplete error
			}
		}
	}
	
	func setDoneOnKeyboard() {
		let input = inputTextField
		let keyboardToolbar = UIToolbar()
		keyboardToolbar.sizeToFit()
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
		keyboardToolbar.items = [flexBarButton, doneBarButton]
		input.inputAccessoryView = keyboardToolbar
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		addViews()
		setDoneOnKeyboard()
		view.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1)
		
		let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
		let continueAction = UIAlertAction(title: "Continue", style: .default) { (action) in
			let textfield = self.reauthenticateAlert.textFields![0]
			guard let password = textfield.text else {return}
			self.reAuthenticateUser(withPassword: password)
		}
		success.addAction(dismiss)
		fail.addAction(dismiss)
		reauthenticateAlert.addAction(continueAction)
		reauthenticateAlert.addTextField { (password) in
			password.placeholder = "Current Password"
			password.isSecureTextEntry = true
		}
    }
	
	public convenience init(withPlaceholder: String, usingTitle: String) {
		self.init()
		topViewTitleLabel.text = usingTitle
		inputTextField.text = withPlaceholder
	}
	
	func addViews() {
		view.addSubview(topView)
		topView.addSubview(topViewBackButton)
		topViewBackButton.addSubview(topViewTitleLabel)
		topView.translatesAutoresizingMaskIntoConstraints = false
		topViewBackButton.translatesAutoresizingMaskIntoConstraints = false
		topViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(textFieldBackground)
		textFieldBackground.addSubview(inputTextField)
		inputTextField.translatesAutoresizingMaskIntoConstraints = false
		textFieldBackground.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	func addConstraints() {
		topView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		topViewTitleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
		topViewTitleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
		
		topViewBackButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
		topViewBackButton.centerYAnchor.constraint(equalTo: topViewTitleLabel.centerYAnchor).isActive = true
		
		textFieldBackground.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
		textFieldBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		textFieldBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		textFieldBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		inputTextField.centerYAnchor.constraint(equalTo: textFieldBackground.centerYAnchor).isActive = true
		inputTextField.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 32).isActive = true
		inputTextField.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -32).isActive = true
	}

}

extension SettingsChangeVC {
	
	func updateUserEmail(withEmail: String) {
		Auth.auth().currentUser?.updateEmail(to: withEmail) { (error) in
			if error == nil {
				self.present(self.success, animated: true, completion: nil)
			} else {
				self.present(self.fail, animated: true, completion: nil)
			}
		}
	}
	
	func updatePassword(withPassword: String) {
		Auth.auth().currentUser?.updatePassword(to: withPassword) { (error) in
			if error == nil {
				self.present(self.success, animated: true, completion: nil)
			} else {
				self.present(self.fail, animated: true, completion: nil)
			}
		}
	}
	
	func reAuthenticateUser(withPassword: String) {
		guard let newEntry = self.inputTextField.text else {return}
		guard let user = Auth.auth().currentUser else {return}
		guard let email = user.email else {return}
		let credential = EmailAuthProvider.credential(withEmail: email, password: withPassword)
		Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
			if error == nil {
				if self.topViewTitleLabel.text == "Email" {
					self.updateUserEmail(withEmail: newEntry)
				} else {
					self.updatePassword(withPassword: newEntry)
				}
			} else {
				self.present(self.fail, animated: true, completion: nil)
			}
		})
	}
	
}
