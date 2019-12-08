//
//  AddNewCategoryVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddNewCategoryVC: UIViewController {
	
	let db = Firestore.firestore()
	let header = HeaderWithTextTitle(leftIcon: UIImage(named: "back")!, rightIcon: UIImage(named: "space")!, title: "Create New Category")
	let createCategoryButton = MainBlueButton()
	let newCategoryInputField = UnderlineTextField(placeholder: "New Category")

    override func viewDidLoad() {
        super.viewDidLoad()
		setDoneOnKeyboard()
		header.rightBarButtonItem.isUserInteractionEnabled = false
		view.backgroundColor = UIColor.systemBackground
		createCategoryButton.setTitle("Create Category", for: .normal)
		addViews()
		header.leftBarButtonItem.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
		createCategoryButton.addTarget(self, action: #selector(createCategoryButtonWasPressed), for: .touchUpInside)
		let tap = UITapGestureRecognizer(target: self, action: #selector(viewTappedToCloseOut))
		view.addGestureRecognizer(tap)
	}
	
	@objc func viewTappedToCloseOut() {
		view.endEditing(true)
	}
	
	@objc func backButtonWasPressed() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func createCategoryButtonWasPressed() {
		if newCategoryInputField.textField.text != nil {
			guard let category = newCategoryInputField.textField.text else { return }
			addNewCategoryToCategoryArray(named: category)
			backButtonWasPressed()
			NotificationCenter.default.post(name: .init("refreshCategories"), object: nil)
		} else {
			return
		}
	}
	
	func setDoneOnKeyboard() {
		let newCategoryField = newCategoryInputField.textField
		
		let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
		keyboardToolbar.sizeToFit()
		let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(viewTappedToCloseOut))
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(viewTappedToCloseOut))
		keyboardToolbar.items = [cancelButton, flexBarButton, doneBarButton]
		newCategoryField.inputView = keyboardToolbar
	}
	
	fileprivate func addNewCategoryToCategoryArray(named: String) {
		guard let user = Auth.auth().currentUser else { return }
		db.collection("users").document(user.uid).setData([
			"categories": FieldValue.arrayUnion([named])
		], merge: true) { err in
			if let err = err {
				print("❌❌❌ Error writing document: \(err)")
			} else {
				print("✅✅✅ Document successfully written!")
			}
		}
	}
	
	fileprivate func addViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(createCategoryButton)
		createCategoryButton.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(newCategoryInputField)
		newCategoryInputField.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		if #available(iOS 13, *) {
			header.heightAnchor.constraint(equalToConstant: 50).isActive = true
		}
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		newCategoryInputField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50).isActive = true
		newCategoryInputField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		newCategoryInputField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		
		createCategoryButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
		createCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		createCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		createCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
	}

}
