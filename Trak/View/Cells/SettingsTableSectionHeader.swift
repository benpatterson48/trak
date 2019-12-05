//
//  SectionsTableHeaderView.swift
//  Trak
//
//  Created by Ben Patterson on 8/27/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class SettingsTableSectionHeader: UITableViewHeaderFooterView {
	
	static let myReuseIdentifier = "sectionTitle"
	
	let label: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.label
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		
		addLabelConstraints()
	}
	
	private func addLabelConstraints() {
		label.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
		label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
		label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
