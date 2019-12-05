//
//  ManageCategoriesVC.swift
//  Trak
//
//  Created by Ben Patterson on 9/5/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ManageCategoriesVC: UIViewController {
	
	var editEnabled: Bool = false
	let db = Firestore.firestore()
	var categoriesArray: [String] = []
	
	var topView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.secondarySystemBackground
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var topViewTitleLabel: UILabel = {
		let title = UILabel()
		title.text = "Manage Categories"
		title.textAlignment = .center
		title.textColor = UIColor.label
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
	
	let tableView: UITableView = {
		if #available(iOS 13, *) {
			let table = UITableView(frame: .zero, style: .insetGrouped)
			table.bounces = true
			table.clipsToBounds = true
			table.showsVerticalScrollIndicator = false
			table.separatorColor = UIColor.separator
			table.backgroundColor = UIColor.secondarySystemBackground
			table.translatesAutoresizingMaskIntoConstraints = false
			table.register(ManageCategoryCell.self, forCellReuseIdentifier: "manage")
			table.register(ManageSectionHeader.self, forHeaderFooterViewReuseIdentifier: "header")
			return table
		} else {
			let table = UITableView(frame: .zero, style: .plain)
			table.bounces = true
			table.clipsToBounds = true
			table.showsVerticalScrollIndicator = false
			table.separatorColor = UIColor.separator
			table.backgroundColor = UIColor.secondarySystemBackground
			table.translatesAutoresizingMaskIntoConstraints = false
			table.register(ManageCategoryCell.self, forCellReuseIdentifier: "manage")
			table.register(ManageSectionHeader.self, forHeaderFooterViewReuseIdentifier: "header")
			return table
		}
	}()
	
	@objc func dismissView() {
		dismissFromLeft()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		DataService.instance.getUserCategories { (returnedCategories) in
			self.categoriesArray = returnedCategories
			self.tableView.reloadData()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.secondarySystemBackground
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		
		addViews()
    }
	
	func addViews() {
		view.addSubview(topView)
		view.addSubview(tableView)
		view.addSubview(topViewTitleLabel)
		view.addSubview(topViewBackButton)
		
		topView.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		topViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
		topViewBackButton.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	func addConstraints() {
		if #available(iOS 13, *) {
			topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		} else {
			topView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		}
		topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		topViewTitleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
		topViewTitleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
		
		topViewBackButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
		topViewBackButton.centerYAnchor.constraint(equalTo: topViewTitleLabel.centerYAnchor).isActive = true
		
		tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
	}

}

extension ManageCategoriesVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "manage", for: indexPath) as? ManageCategoryCell else {return UITableViewCell()}
		cell.categoryNameLabel.text = categoriesArray[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? ExpensesSectionHeader else {return nil}
		header.contentView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9529411765, alpha: 1)
		header.label.textColor = UIColor.label
		header.label.font = UIFont.systemFont(ofSize: 13)
		header.label.text = """
		Deleting a category does NOT delete the expenses within that category.
		
		It only deletes the ability to filter by the category or add new recipes to the category.
		"""
		return header 
	}
	
	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		guard let user = Auth.auth().currentUser else {return nil}
		let category = categoriesArray[indexPath.row]
		let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
			handler(true)
			self.db.collection("users").document(user.uid).updateData([
				"categories" : FieldValue.arrayRemove(["\(category)"])
				], completion: { (error) in
					if let error = error {
						// handle error
						print("error deleting \(error)")
					} else {
						self.categoriesArray.remove(at: indexPath.row)
						tableView.reloadData()
					}
			})
		}
		action.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.4392156863, blue: 0.3568627451, alpha: 1)
		let configuration = UISwipeActionsConfiguration(actions: [action])
		return configuration
	}
	
}
