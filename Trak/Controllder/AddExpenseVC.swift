//
//  AddExpenseVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/17/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddExpenseVC: UIViewController {
	
	var db = Firestore.firestore()
	var categoriesArray = [String]()
	var paymentDate: Date?
	let fields = AddExpenseStackView()
	let addPaymentButton = MainBlueButton()
	let datePicker = ExpenseDatePicker()
	let categoryPicker = UIPickerView()
	let addCategoryButton = ImageAndTextButton(labelText: "Create New Category", iconImage: "circle-add")
	let header = HeaderWithTextTitle(leftIcon: UIImage(named: "back")!, rightIcon: UIImage(named: "space")!, title: "Add New Payment")

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		getCategories()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addViews()
		setupAddPaymentButton()
		view.backgroundColor = .white
		fields.totalField.textField.keyboardType = .decimalPad
		fields.dateField.textField.inputView = datePicker
		fields.categoryField.textField.inputView = categoryPicker
		datePicker.addTarget(self, action: #selector(AddExpenseVC.dateChanged(datePicker:)), for: .valueChanged)
		header.rightBarButtonItem.isUserInteractionEnabled = false
		header.leftBarButtonItem.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
		addCategoryButton.label.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		addCategoryButton.icon.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		
		categoryPicker.delegate = self
		categoryPicker.dataSource = self
		categoryPicker.backgroundColor = .white
		let tap = UITapGestureRecognizer(target: self, action: #selector(viewTappedToCloseOut))
		view.addGestureRecognizer(tap)
	}
	
	fileprivate func getCategories() {
		DataService.instance.getUsersCategories { (categoriesReturned) in
			self.categoriesArray = categoriesReturned
		}
	}
	
	fileprivate func setupAddPaymentButton() {
		addPaymentButton.setTitle("Add Payment", for: .normal)
		addPaymentButton.alpha = 0.5
	}
	
	@objc func dateChanged(datePicker: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"
		paymentDate = datePicker.date
		fields.dateField.textField.text = dateFormatter.string(from: datePicker.date)
	}
	
	@objc func viewTappedToCloseOut() {
		view.endEditing(true)
	}
	
	@objc func addNewCategoryButtonWasPressed() {
		let category = AddNewCategoryVC()
		present(category, animated: true, completion: nil)
	}
	
	@objc func backButtonWasPressed() {
		dismiss(animated: true, completion: nil)
	}

	fileprivate func addViews() {
		view.addSubview(header)
		view.addSubview(fields)
		view.addSubview(addCategoryButton)
		view.addSubview(addPaymentButton)
		header.translatesAutoresizingMaskIntoConstraints = false
		fields.translatesAutoresizingMaskIntoConstraints = false
		addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
		addPaymentButton.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		fields.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50).isActive = true
		fields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		fields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		
		addCategoryButton.topAnchor.constraint(equalTo: fields.bottomAnchor, constant: 24).isActive = true
		addCategoryButton.leadingAnchor.constraint(equalTo: fields.leadingAnchor).isActive = true
		addCategoryButton.trailingAnchor.constraint(equalTo: fields.trailingAnchor).isActive = true
		
		addPaymentButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
		addPaymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		addPaymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		addPaymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
	}
	
//	fileprivate func addUserToDatabase(name: String, amount: Double, date: Date, category: String) {
//		guard let user = Auth.auth().currentUser else { return }
//		db.collection("users").document(user.uid).setData([
//
//		], merge: true) { err in
//			if let err = err {
//				print("❌❌❌ Error writing document: \(err)")
//			} else {
//				print("✅✅✅ Document successfully written!")
//			}
//		}
//	}


}

extension AddExpenseVC: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return categoriesArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return categoriesArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		fields.categoryField.textField.text = categoriesArray[row]
	}
}
