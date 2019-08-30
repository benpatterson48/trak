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
		
	var settingsArray: [GenericCellInput] = [
		GenericCellInput(icon: "email", title: 		"Update your Email    "),
		GenericCellInput(icon: "password", title: 	"Change your Password "),
		GenericCellInput(icon: "faceid", title: 	"Face/ Touch ID          "),
		GenericCellInput(icon: "year", title: 		"Change the Year      "),
		GenericCellInput(icon: "review", title: 	"Leave a Review       "),
		GenericCellInput(icon: "bug", title: 		"Report a Bug         "),
		GenericCellInput(icon: "blog", title: 		"Check out our Blog   "),
		GenericCellInput(icon: "logout", title: 	"Logout               ")
	]
	
	var sectionTitle: [String] = [
		"",
		"",
		"",
		"",
		"",
		""
	]
	
	var pageTitle: UILabel = {
		let title = UILabel()
		title.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
		title.textAlignment = .left
		title.text = "Account Settings"
		title.font = UIFont.boldSystemFont(ofSize: 32)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	var forwardArrow: UIButton = {
		let arrow = UIButton()
		arrow.setTitle("Done", for: .normal)
		arrow.setTitleColor(UIColor.main.blue, for: .normal)
		arrow.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
		return arrow
	}()
	
	let tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.bounces = false
		table.separatorColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
		table.clipsToBounds = true
		table.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
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
		
		view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
	}
	
	@objc func dismissView() {
		dismissFromRight()
	}
	
	fileprivate func addViews() {
		view.addSubview(pageTitle)
		pageTitle.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(forwardArrow)
		forwardArrow.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
		pageTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
		pageTitle.trailingAnchor.constraint(equalTo: forwardArrow.leadingAnchor, constant: -16).isActive = true
		
		forwardArrow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
		forwardArrow.bottomAnchor.constraint(equalTo: pageTitle.bottomAnchor).isActive = true
		
		tableView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 24).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
	}
}

extension AccountSettingsVC: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionTitle") as? SettingsTableSectionHeader else {return nil}
		header.contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		header.label.text = sectionTitle[section]
		return header
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionTitle") as? SettingsTableSectionHeader else {return nil}
		footer.contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		footer.label.numberOfLines = 0
		footer.label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
		} else if section == 4 {
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
			cell.setting = settingsArray[3]
			return cell
		} else if indexPath.section == 2 {
			cell.setting = settingsArray[4]
			return cell
		} else if indexPath.section == 3 {
			cell.setting = settingsArray[5]
			return cell
		} else {
			cell.setting = settingsArray[indexPath.row + 6]
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			if indexPath.row == 0 {
				let edit = SettingsChangeVC(withPlaceholder: "Enter email", usingTitle: "Email")
				presentFromRight(edit)
			} else if indexPath.row == 1  {
				let edit = SettingsChangeVC(withPlaceholder: "Enter password", usingTitle: "Password")
				presentFromRight(edit)
			}
		} else if indexPath.section == 1 {
			let edit = SettingsChangeVC(withPlaceholder: "Enter Desired Year", usingTitle: "Year")
			presentFromRight(edit)
		} else if indexPath.section == 2 {
			self.reviewButtonWasPressed()
		} else if indexPath.section == 3 {
			let edit = SettingsChangeVC(withPlaceholder: "Please explain the issue", usingTitle: "Bug Report")
			presentFromRight(edit)
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
		if let url = URL(string: "https://google.com") {
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
		print("FACEID IS ENABLED ON TOUCH: \(UserDefaults.standard.bool(forKey: "enabledFaceID"))")
		if cell.cellSwitch.isOn == true {
			UserDefaults.standard.set(false, forKey: "enabledFaceID")
		} else {
			UserDefaults.standard.set(true, forKey: "enabledFaceID")
		}
	}

}

