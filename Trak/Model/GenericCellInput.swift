//
//  GenericCellInput.swift
//  Trak
//
//  Created by Ben Patterson on 8/26/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

struct GenericCellInput {
	let icon: String?
	let title: String?
	
	init(icon: String, title: String) {
		self.icon = icon
		self.title = title
	}
}

struct SettingsCellModel {
	let icon: String?
	let title: String?
	let backgroundColor: UIColor?
	
	init(icon: String, title: String, color: UIColor) {
		self.icon = icon
		self.title = title
		self.backgroundColor = color
	}
}
