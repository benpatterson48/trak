//
//  AddExpenseVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/17/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class AddExpenseVC: UIViewController {
	
	let header = HeaderWithTextTitle(leftIcon: UIImage(named: "back")!, rightIcon: UIImage(named: "space")!, title: "Add New Payment")
	let fields = AddExpenseStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
		addViews()
		header.rightBarButtonItem.isUserInteractionEnabled = false 
		view.backgroundColor = .white
	}

	fileprivate func addViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(fields)
		fields.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		fields.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50).isActive = true
		fields.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		fields.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true 
	}

}
