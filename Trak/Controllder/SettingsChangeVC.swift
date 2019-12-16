//
//  SettingsChangeVC.swift
//  Trak
//
//  Created by Ben Patterson on 8/27/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import FirebaseAuth
import FirebaseFirestore

class SettingsChangeVC: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {
	
	let success = UIAlertController(title: "✅ Success", message: "Information has been successfully udpated.", preferredStyle: .alert)
	let fail = UIAlertController(title: "❌ Error", message: "Sorry, something went wrong, please try again later", preferredStyle: .alert)
	let reauthenticateAlert = UIAlertController(title: "Are You Sure?", message: "Please enter your current password to continue", preferredStyle: .alert)
	
	var passwordInput = String()
	
	var topView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.secondarySystemBackground
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var topViewTitleLabel: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = UIColor.label
		title.font = UIFont.systemFont(ofSize: 34, weight: .bold)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var subTitleLbl: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = UIColor.label
		title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var textFieldBackground: UIView = {
		let background = UIView()
		background.backgroundColor = UIColor.tertiarySystemBackground
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
		if #available(iOS 13, *) {
			dismiss(animated: true, completion: nil)
		}
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
			if inputTextField.text != nil && inputTextField.text != "" && inputTextField.text != " " {
				selectedYear = self.inputTextField.text!
				let expenses = ExpensesVC()
				presentFromRight(expenses)
			} else {
				// show incomplete error
			}
		} else {
			sendMailSuggestion()
		}
	}
	
	func setDoneOnKeyboard() {
		let input = inputTextField
		let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
		keyboardToolbar.sizeToFit()
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(title: "Enter", style: .done, target: self, action: #selector(dismissKeyboard))
		keyboardToolbar.items = [flexBarButton, doneBarButton]
		input.inputAccessoryView = keyboardToolbar
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		addViews()
		setupAlerts()
		setDoneOnKeyboard()
		view.backgroundColor = UIColor.secondarySystemBackground
		self.inputTextField.clearsOnBeginEditing = true
    }
	
	public convenience init(withPlaceholder: String, usingTitle: String, withSubTitle: String) {
		self.init()
		topViewTitleLabel.text = usingTitle
		subTitleLbl.text = withSubTitle
		inputTextField.text = withPlaceholder
	}
	
	func setupAlerts() {
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
	
	func addViews() {
		view.addSubview(topViewTitleLabel)
		view.addSubview(subTitleLbl)
		subTitleLbl.translatesAutoresizingMaskIntoConstraints = false
		topViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(textFieldBackground)
		textFieldBackground.addSubview(inputTextField)
		inputTextField.translatesAutoresizingMaskIntoConstraints = false
		textFieldBackground.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	func addConstraints() {
		topViewTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
		topViewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topViewTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		subTitleLbl.topAnchor.constraint(equalTo: topViewTitleLabel.bottomAnchor, constant: 12).isActive = true
		subTitleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		subTitleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		
		textFieldBackground.topAnchor.constraint(equalTo: subTitleLbl.bottomAnchor, constant: 40).isActive = true
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
	
	func sendMailSuggestion() {
		let user = Auth.auth().currentUser
		if MFMailComposeViewController.canSendMail() {
			if self.inputTextField.text != "" {
				let mail = MFMailComposeViewController()
				mail.mailComposeDelegate = self
				mail.setToRecipients(["ben@outlyrs.com"])
				mail.setMessageBody(self.inputTextField.text!, isHTML: false)
				mail.setSubject("You received an FDL App Suggestion from \(user?.email ?? "Trak User")")
				present(mail, animated: true)
			} else {
				let alert = UIAlertController(title: "❌ No Message", message: "Add a suggestion and try submitting again.", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
				self.present(alert, animated: true)
			}
		} else {
			let alert = UIAlertController(title: "Enable Your Mail", message: "You must enable your phone to send email before using this feature.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
			self.present(alert, animated: true)
		}
	}
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true)
	}
	
}
