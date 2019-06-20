//
//  ExpensesVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpensesVC: UIViewController {
	
	let header = HeaderWithLogo(leftIcon: UIImage(named: "menu")!, rightIcon: UIImage(named: "add")!)
	let emptyState = EmptyState()

    override func viewDidLoad() {
        super.viewDidLoad()
		addViews()
		addButtonTargets()
		view.backgroundColor = .white
	}
	
	fileprivate func addButtonTargets() {
		emptyState.button.addTarget(self, action: #selector(addNewPaymentButtonWasPressed), for: .touchUpInside)
	}
	
	@objc func addNewPaymentButtonWasPressed() {
		let add = AddExpenseVC()
		present(add, animated: true, completion: nil)
	}
	
	fileprivate func checkExpensesArray() {
		
	}
	
	fileprivate func addViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(emptyState)
		emptyState.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -32).isActive = true
	}

}
