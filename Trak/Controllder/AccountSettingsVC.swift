//
//  AccountSettingsVC.swift
//  Trak
//
//  Created by Ben Patterson on 8/26/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import StoreKit
import FirebaseAuth

class AccountSettingsVC: UIViewController {

	var settingsArray: [SettingsCellModel] = [
		SettingsCellModel(icon: "envelope", title: "Update your Email", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "lock", title: "Change your Password", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "faceid", title: "Face/ Touch ID", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "calendar", title: "Change the Year", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "tag", title: "Manage Categories", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "star", title: "Leave a Review", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "ant", title: "Report a Bug", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "doc.plaintext", title: "Check out our Website", color: UIColor.systemBlue.withAlphaComponent(0.8)),
		SettingsCellModel(icon: "arrowshape.turn.up.left", title: "Logout", color: UIColor.systemBlue.withAlphaComponent(0.8))
	]
	
	var sectionTitle: [String] = [
		"",
		"",
		"",
		"",
		"",
		""
	]
	
	var forwardArrow: UIButton = {
		let arrow = UIButton()
		arrow.setTitle("Done", for: .normal)
		arrow.setTitleColor(UIColor.systemBlue, for: .normal)
		arrow.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		return arrow
	}()
	
	let tableView: UITableView = {
		var table = UITableView(frame: .zero, style: .insetGrouped)
		table.bounces = true
		table.separatorColor = UIColor.separator
		table.clipsToBounds = true
		table.backgroundColor = UIColor.secondarySystemBackground
		table.showsVerticalScrollIndicator = false
		table.translatesAutoresizingMaskIntoConstraints = false
		table.register(SettingsCell.self, forCellReuseIdentifier: "settings")
		table.register(SettingsCellWithUISwitch.self, forCellReuseIdentifier: "settingsSwitch")
		table.register(SettingsTableSectionHeader.self, forHeaderFooterViewReuseIdentifier: "sectionTitle")
		return table
	}()
		
	override func viewDidLoad() {
		super.viewDidLoad()
		addViews()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		
		setupNavigationControllerTitle()
		
		view.backgroundColor = UIColor.secondarySystemBackground
		
		let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(dismissView))
		swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
		view.addGestureRecognizer(swipeLeft)
	}
	
	func setupNavigationControllerTitle() {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.topItem?.title = "Settings"
		navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
	}
	
	@objc func dismissView() {
		if #available(iOS 13, *) {
			NotificationCenter.default.post(name: .init("refreshCategories"), object: nil)
			dismiss(animated: true, completion: nil)
		} else {
			NotificationCenter.default.post(name: .init("refreshCategories"), object: nil)
			dismissFromRight()
		}
	}
	
	fileprivate func addViews() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
	}
}

extension AccountSettingsVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionTitle") as? SettingsTableSectionHeader else {return nil}
		header.contentView.backgroundColor = UIColor.secondarySystemBackground
		header.label.text = sectionTitle[section]
		return header
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionTitle") as? SettingsTableSectionHeader else {return nil}
		footer.contentView.backgroundColor = UIColor.secondarySystemBackground
		footer.label.numberOfLines = 0
		footer.label.text = "Seriously, if you found something not working right, please let us know."
		if section == 3 {
			return footer
		} else {
			return nil
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 3
		} else if section == 4 || section == 1 {
			return 2
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as? SettingsCell else {return UITableViewCell()}
		guard let switchCell = tableView.dequeueReusableCell(withIdentifier: "settingsSwitch", for: indexPath) as? SettingsCellWithUISwitch else {return UITableViewCell()}
		if indexPath.section == 0 {
			if indexPath.row == 2 {
				switchCell.setting = settingsArray[2]
				switchCell.cellSwitch.addTarget(self, action: #selector(toggledFaceIDSwitch), for: .touchUpInside)
				return switchCell
			} else {
				cell.setting = settingsArray[indexPath.row]
				return cell
			}
		} else if indexPath.section == 1 {
			cell.setting = settingsArray[indexPath.row + 3]
			return cell
		} else if indexPath.section == 2 {
			cell.setting = settingsArray[5]
			return cell
		} else if indexPath.section == 3 {
			cell.setting = settingsArray[6]
			return cell
		} else {
			cell.setting = settingsArray[indexPath.row + 7]
			return cell
		}
	}
	
	func showCorrectTransition(for controller: UIViewController) {
		present(controller, animated: true, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			if indexPath.row == 0 {
				let edit = SettingsChangeVC(withPlaceholder: "Enter email", usingTitle: "Email")
				showCorrectTransition(for: edit)
			} else if indexPath.row == 1  {
				let edit = SettingsChangeVC(withPlaceholder: "Enter password", usingTitle: "Password")
				showCorrectTransition(for: edit)
			}
		} else if indexPath.section == 1 {
			if indexPath.row == 0 {
				let edit = SettingsChangeVC(withPlaceholder: "Enter Desired Year", usingTitle: "Year")
				showCorrectTransition(for: edit)
			} else {
				let manage = ManageCategoriesVC()
				showCorrectTransition(for: manage)
			}
		} else if indexPath.section == 2 {
			self.reviewButtonWasPressed()
		} else if indexPath.section == 3 {
			let edit = SettingsChangeVC(withPlaceholder: "Please explain the issue", usingTitle: "Bug Report")
			showCorrectTransition(for: edit)
		} else if indexPath.section == 4 {
			if indexPath.row == 0 {
				self.moreResourcesBlogButtonWasPressed()
			} else {
				self.logoutWasSelected()
			}
		}
	}
	
	func reviewButtonWasPressed() {
		SKStoreReviewController.requestReview()
	}
	
	func moreResourcesBlogButtonWasPressed() {
		if let url = URL(string: "https://gettrakapp.com") {
			UIApplication.shared.open(url, options: [:])
		} else {
			// show error
		}
	}
	
	func logoutWasSelected() {
		do {
			try Auth.auth().signOut()
			let login = LoginVC()
			present(login, animated: true, completion: nil)
		} catch {
			print("didn't work")
		}
	}
	
	@objc func toggledFaceIDSwitch() {
		let cell = SettingsCellWithUISwitch()
		if cell.cellSwitch.isOn == true {
			UserDefaults.standard.set(false, forKey: "enabledFaceID")
		} else {
			UserDefaults.standard.set(true, forKey: "enabledFaceID")
		}
	}
	
}

