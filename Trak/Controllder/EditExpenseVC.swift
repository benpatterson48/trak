//
//  EditExpenseVC.swift
//  Trak
//
//  Created by Ben Patterson on 7/22/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditExpenseVC: UIViewController, UITextFieldDelegate {
	
	var db = Firestore.firestore()
	var categoriesArray = [String]()
	var paymentDate: Date?
	var paymentMonth: String?
	var paymentYear: String?
	var editExpense: Expense?
	var timestamp: Timestamp?
	
	let fields = AddExpenseStackView()
	let addPaymentButton = MainBlueButton()
	let datePicker = ExpenseDatePicker()
	let categoryPicker = UIPickerView()
	let addCategoryButton = ImageAndTextButton(labelText: "Create New Category", iconImage: "circle-add")
	let header = HeaderWithTextTitle(leftIcon: UIImage(named: "back")!, rightIcon: UIImage(named: "space")!, title: "Edit Expense")
	let alert = UIAlertController(title: "Form Not Complete", message: "Please complete every field to submit", preferredStyle: .alert)
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		getCategories()
	}
	
	func initData(expense: Expense) {
		self.editExpense = expense
		fields.nameField.textField.text = expense.name
		fields.totalField.textField.text = "\(expense.amount)".currency
		fields.categoryField.textField.text = expense.category
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/ dd / yyyy"
		self.timestamp = expense.timestamp
		paymentDate = timestamp?.dateValue()
		paymentMonth = paymentDate?.month
		paymentYear = paymentDate?.year
		fields.dateField.textField.text = dateFormatter.string(from: paymentDate ?? Date())
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		addViews()
		setupHeader()
		setupFields()
		setupButtonTargets()
		setupCategoryPicker()
		setupAddPaymentButton()
		view.backgroundColor = .white
		let tap = UITapGestureRecognizer(target: self, action: #selector(viewTappedToCloseOut))
		view.addGestureRecognizer(tap)
	}
	
	//Button Target Funcs
	@objc func viewTappedToCloseOut() {
		view.endEditing(true)
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		fields.totalField.textField.text = fields.totalField.textField.text?.currency
	}
	
	@objc func addNewCategoryButtonWasPressed() {
		let category = AddNewCategoryVC()
		present(category, animated: true, completion: nil)
	}
	
	@objc func backButtonWasPressed() {
		dismiss(animated: true, completion: nil)
	}
	
	@objc func dateChanged(datePicker: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM dd, yyyy"
		paymentDate = datePicker.date
		paymentMonth = paymentDate?.month
		paymentYear = paymentDate?.year
		self.timestamp = Timestamp(date: paymentDate ?? Date())
		fields.dateField.textField.text = dateFormatter.string(from: datePicker.date)
	}
	
	@objc func addPaymentButtonWasPressed() {
		guard let paymentName = fields.nameField.textField.text, fields.nameField.textField.text != nil else { print("name");showIncompleteFormAlert(); return }
		guard let paymentAmount = fields.totalField.textField.text?.removeCurrency else { print("payamount");showIncompleteFormAlert(); return }
		guard let paymentAmountDouble = Double(paymentAmount) else { print("aqmtdoubt");showIncompleteFormAlert(); return }
		guard let paymentDueDate = self.timestamp else { print("duedate");showIncompleteFormAlert(); return }
		guard let paymentCategory = fields.categoryField.textField.text, fields.categoryField.textField.text != nil else {  print("category");showIncompleteFormAlert(); return }
		editExpenseWithNewInformation(newName: paymentName, timestamp: paymentDueDate, newAmount: paymentAmountDouble, newDate: paymentDueDate, newCategory: paymentCategory)
		let expenseTableVC = ExpensesVC()
		expenseTableVC.expensesTableView.reloadData()
		dismiss(animated: true, completion: nil)
	}
	
	//UI Funcs
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
	
	//Adding data to Firestore
	
	// Change to Edit the Existing Payment
	fileprivate func editExpenseWithNewInformation(newName: String, timestamp: Timestamp, newAmount: Double, newDate: Timestamp, newCategory: String) {
		guard let user = Auth.auth().currentUser else {print("This is the user"); return}
		guard let month = paymentMonth else {print("This is the month"); return}
		guard let year = paymentYear else {print("This is the year"); return}
		guard let name = editExpense?.name else {print("This is the name"); return}
		// Edit Expense
		self.db.collection("users").document(user.uid).collection(year).document(month).updateData([
			"\(name).amount": newAmount,
			"\(name).category": newCategory,
			"\(name).date": newDate,
			"\(name).name": newName,
			"\(name).timestamp": timestamp
		]) { err in
			if let err = err {
				print("Error updating document: \(err)")
			} else {
				print("Document successfully updated")
			}
		}
	}
	
	//Helper Funcs
	fileprivate func getCategories() {
		DataService.instance.getUserCategories { (categoriesReturned) in
			self.categoriesArray = categoriesReturned
		}
	}
	
	fileprivate func setupAddPaymentButton() {
		addPaymentButton.setTitle("Edit Expense", for: .normal)
	}
	
	fileprivate func setupHeader() {
		header.rightBarButtonItem.isUserInteractionEnabled = false
		header.leftBarButtonItem.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
	}
	
	fileprivate func setupCategoryPicker() {
		categoryPicker.delegate = self
		categoryPicker.dataSource = self
		categoryPicker.backgroundColor = .white
	}
	
	fileprivate func setupButtonTargets() {
		addPaymentButton.addTarget(self, action: #selector(addPaymentButtonWasPressed), for: .touchUpInside)
		datePicker.addTarget(self, action: #selector(AddExpenseVC.dateChanged(datePicker:)), for: .valueChanged)
		addCategoryButton.label.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		addCategoryButton.icon.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
		fields.totalField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
	}
	
	fileprivate func setupFields() {
		fields.categoryField.textField.inputView = categoryPicker
		fields.totalField.textField.keyboardType = .decimalPad
		fields.dateField.textField.inputView = datePicker
		fields.categoryField.textField.inputView = categoryPicker
		fields.totalField.textField.clearsOnBeginEditing = true
	}
	
	fileprivate func showIncompleteFormAlert() {
		present(alert, animated: true, completion: nil)
	}
}

extension EditExpenseVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
		if categoriesArray.count > 0 {
			fields.categoryField.textField.text = categoriesArray[row]
		} else {
			return
		}
	}
}
