//
//  AddExpenseVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/17/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import UserNotifications

var setReminder: Bool = false 

class AddExpenseVC: UIViewController, UITextFieldDelegate {
	
	var db = Firestore.firestore()
	var paymentDate: Date?
	var paymentMonth: String?
	var paymentYear: String?
	var timeStamp: Timestamp?
	var reminderDateString: String?
	var categoriesArray: [String] = [""]
	
	let fields = AddExpenseStackView()
	let addPaymentButton = MainBlueButton()
	let expenseDatePicker = ExpenseDatePicker()
	let categoryPicker = UIPickerView()
	let addCategoryButton = ImageAndTextButton(labelText: "Create New Category", iconImage: "circle-add")
	let header = HeaderWithTextTitle(leftIcon: UIImage(named: "back")!, rightIcon: UIImage(named: "space")!, title: "Add New Payment")
	let alert = UIAlertController(title: "Form Not Complete", message: "Please complete every field to submit", preferredStyle: .alert)
	
	let topLine: UIView = {
		let line = UIView()
		line.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7725490196, blue: 0.8235294118, alpha: 1)
		line.heightAnchor.constraint(equalToConstant: 1).isActive = true
		line.translatesAutoresizingMaskIntoConstraints = false
		return line
	}()
	
	let reminderTable: UITableView = {
		let table  = UITableView()
		table.bounces = false
		table.separatorStyle = .none
		table.backgroundColor = .white
		table.isUserInteractionEnabled = true
		table.showsVerticalScrollIndicator = false
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(ReminderCell.self, forCellReuseIdentifier: "reminder")
		table.register(SetDateReminderCell.self, forCellReuseIdentifier: "date")
		return table
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		getCategories()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setReminder = false 
		
		addViews()
		setupHeader()
		setupFields()
		setDoneOnKeyboard()
		setupButtonTargets()
		setupCategoryPicker()
		setupAddPaymentButton()
		
		view.backgroundColor = .white
		
		reminderTable.delegate = self
		reminderTable.dataSource = self
		reminderTable.tableFooterView = UIView()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(viewTappedToCloseOut))
		let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backButtonWasPressed))
		swipeRight.direction = UISwipeGestureRecognizer.Direction.right
		
		view.addGestureRecognizer(tap)
		view.addGestureRecognizer(swipeRight)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(true)
		setReminder = false
	}
	
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
		dismissFromLeft()
	}
	
	func setDoneOnKeyboard() {
		let name = fields.nameField.textField
		let date = fields.dateField.textField
		let amount = fields.totalField.textField
		let category = fields.categoryField.textField
		
		let keyboardToolbar = UIToolbar()
		keyboardToolbar.sizeToFit()
		let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
		keyboardToolbar.items = [flexBarButton, doneBarButton]
		name.inputAccessoryView = keyboardToolbar
		date.inputAccessoryView = keyboardToolbar
		amount.inputAccessoryView = keyboardToolbar
		category.inputAccessoryView = keyboardToolbar
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@objc func dateChanged(datePicker: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MMMM dd, yyyy"
		paymentDate = datePicker.date
		paymentMonth = paymentDate?.month
		paymentYear = paymentDate?.year
		self.timeStamp = Timestamp(date: paymentDate ?? Date())
		fields.dateField.textField.text = dateFormatter.string(from: datePicker.date)
	}
	
	@objc func addPaymentButtonWasPressed() {
		guard let paymentName = fields.nameField.textField.text, fields.nameField.textField.text != nil else { print("name");showIncompleteFormAlert(); return }
		guard let paymentAmount = fields.totalField.textField.text?.removeCurrency else { print("payamount");showIncompleteFormAlert(); return }
		guard let paymentAmountDouble = Double(paymentAmount) else { print("aqmtdoubt");showIncompleteFormAlert(); return }
		guard let paymentDueDate = self.timeStamp else { print("duedate");showIncompleteFormAlert(); return }
		guard let paymentCategory = fields.categoryField.textField.text, fields.categoryField.textField.text != "", fields.categoryField.textField.text != nil else {  print("category");showIncompleteFormAlert(); return }
		addPaymentToDatabase(name: paymentName, amount: paymentAmountDouble, timestamp: paymentDueDate, date: paymentDueDate, category: paymentCategory)
		if setReminder == true {
			let date = returnSelectedDateAsDate()
			let intMonth = grabMonthIndex(month: date.month)
			self.schedulePushNotificationReminder(month: intMonth, day: Int(date.day) ?? 1, year: Int(date.year) ?? 2019, hour: Int(date.militaryHour) ?? 10, minute: Int(date.minute) ?? 00, expenseName: paymentName, expenseAmount: paymentAmount)
		}
		dismiss(animated: true, completion: nil)
	}
	
	func grabMonthIndex(month: String) -> Int {
		let index = monthArray.firstIndex(of: month)! + 1
		return index
	}
	
	@objc func returnSelectedDateAsDate() -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "E, d MMM yyyy hh:mm a"
		let inputCell = reminderTable.cellForRow(at: IndexPath(row: 1, section: 0)) as? SetDateReminderCell
		guard let dateSelected = inputCell?.reminderResultLabel.text else { return Date() }
		guard let selectedDate = dateFormatter.date(from: dateSelected) else { return Date() }
		return selectedDate
	}

	//UI Funcs
	fileprivate func addViews() {
		view.addSubview(header)
		view.addSubview(fields)
		view.addSubview(topLine)
		view.addSubview(addCategoryButton)
		view.addSubview(addPaymentButton)
		view.addSubview(reminderTable)
		header.translatesAutoresizingMaskIntoConstraints = false
		fields.translatesAutoresizingMaskIntoConstraints = false
		topLine.translatesAutoresizingMaskIntoConstraints = false
		addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
		addPaymentButton.translatesAutoresizingMaskIntoConstraints = false
		reminderTable.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
			fields.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16).isActive = true
			addPaymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
		} else {
			fields.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50).isActive = true
			addPaymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
		}
		fields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		fields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
		
		addCategoryButton.topAnchor.constraint(equalTo: fields.bottomAnchor, constant: 24).isActive = true
		addCategoryButton.leadingAnchor.constraint(equalTo: fields.leadingAnchor).isActive = true
		addCategoryButton.trailingAnchor.constraint(equalTo: fields.trailingAnchor).isActive = true
		addCategoryButton.bottomAnchor.constraint(equalTo: topLine.topAnchor, constant: -32).isActive = true
		
		topLine.topAnchor.constraint(equalTo: addCategoryButton.bottomAnchor, constant: 32).isActive = true
		topLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topLine.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		topLine.bottomAnchor.constraint(equalTo: reminderTable.topAnchor, constant: -8).isActive = true
		
		reminderTable.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 8).isActive = true
		reminderTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		reminderTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		reminderTable.heightAnchor.constraint(equalToConstant: 100).isActive = true

		addPaymentButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
		addPaymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		addPaymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
	}
	
	//Adding data to Firestore
	fileprivate func addPaymentToDatabase(name: String, amount: Double, timestamp: Timestamp, date: Timestamp, category: String) {
		guard let user = Auth.auth().currentUser else {return}
		guard let month = paymentMonth else {return}
		guard let year = paymentYear else {return}
		let expense = [
			name : ["name": name, "amount": amount, "timestamp": timestamp, "date": date, "category": category, "isPaid": false, "reminderDate": reminderDateString ?? ""]
		]
		db.collection("users").document(user.uid).collection(year).document(month).setData(expense, merge: true) { err in
			if let err = err {
				print("❌❌❌ Error writing document: \(err)")
			} else {
				print("✅✅✅ Document successfully written!")
			}
		}
	}
	
	//Helper Funcs
	fileprivate func getCategories() {
		self.categoriesArray.removeAll()
		DataService.instance.getUserCategories { (categoriesReturned) in
			self.categoriesArray.append(contentsOf: categoriesReturned)
		}
	}
	
	fileprivate func setupAddPaymentButton() {
		addPaymentButton.setTitle("Add Payment", for: .normal)
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
		expenseDatePicker.addTarget(self, action: #selector(AddExpenseVC.dateChanged(datePicker:)), for: .valueChanged)
		addCategoryButton.label.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		addCategoryButton.icon.addTarget(self, action: #selector(addNewCategoryButtonWasPressed), for: .touchUpInside)
		alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
		fields.totalField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
		reminderDatePicker.addTarget(self, action: #selector(reminderDateChanged(datePicker:)), for: .valueChanged)
	}
	
	fileprivate func setupFields() {
		fields.totalField.textField.keyboardType = .decimalPad
		fields.dateField.textField.inputView = expenseDatePicker
		fields.categoryField.textField.inputView = categoryPicker
		fields.totalField.textField.clearsOnBeginEditing = true
	}
	
	fileprivate func showIncompleteFormAlert() {
		present(alert, animated: true, completion: nil)
	}
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
		if categoriesArray.count > 0 {
			fields.categoryField.textField.text = categoriesArray[row]
		} else {
			return
		}
	}
}

extension AddExpenseVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if setReminder == true {
			return 2
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "reminder", for: indexPath) as? ReminderCell else {return UITableViewCell()}
		guard let dateCell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath) as? SetDateReminderCell else {return UITableViewCell()}
		if setReminder == true {
			if indexPath.row == 0 {
				cell.cellSwitch.addTarget(self, action: #selector(setReminderToggle), for: .touchUpInside)
				return cell
			} else {
				return dateCell
			}
		} else {
			cell.cellSwitch.addTarget(self, action: #selector(setReminderToggle), for: .touchUpInside)
			return cell
		}
	}
	
	@objc func reminderDateChanged(datePicker: UIDatePicker) {
		let dateFormatter = DateFormatter()
		let cell = reminderTable.cellForRow(at: IndexPath(row: 1, section: 0)) as? SetDateReminderCell
		dateFormatter.dateFormat = "E, d MMM yyyy hh:mm a"
		cell?.reminderResultLabel.text = dateFormatter.string(from: datePicker.date)
		self.reminderDateString = dateFormatter.string(from: datePicker.date)
	}

	@objc func setReminderToggle() {
		let cell = ReminderCell()
		if cell.cellSwitch.isOn == true || setReminder == true {
			setReminder = false
			reminderTable.separatorStyle = .none
			reminderTable.reloadData()
		} else {
			setReminder = true
			reminderTable.separatorStyle = .singleLine
			reminderTable.separatorColor = #colorLiteral(red: 0.7490196078, green: 0.7725490196, blue: 0.8235294118, alpha: 1)
			reminderTable.reloadData()
		}
	}
	
	func schedulePushNotificationReminder(month: Int, day: Int, year: Int, hour: Int, minute: Int, expenseName: String, expenseAmount: String) {
		let center = UNUserNotificationCenter.current()
		
		let content = UNMutableNotificationContent()
		content.title = "\(expenseName) is Due Soon!"
		content.body = "Don't forget to pay \(expenseAmount) for \(expenseName) coming up soon."
		content.categoryIdentifier = "alarm"
		content.userInfo = ["customData": "fizzbuzz"]
		content.sound = UNNotificationSound.default
		content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
		
		var dateComponents = DateComponents()
		dateComponents.month = month
		dateComponents.day = day
		dateComponents.year = year
		dateComponents.hour = hour
		dateComponents.minute = minute
		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
		
		//Test triggger
//		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		
		let request = UNNotificationRequest(identifier: "\(expenseName)", content: content, trigger: trigger)
		print("were about to schedule notification with identifier: \(instanceIDTokenMessage)")
		
		center.add(request)
	}

}

