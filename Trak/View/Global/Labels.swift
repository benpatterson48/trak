//
//  Labels.swift
//  Trak
//
//  Created by Ben Patterson on 6/18/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class MainLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		textColor = UIColor.trakLabel
		textAlignment = .left
		font = UIFont.mainFont(ofSize: 18)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	public convenience init(title: String) {
		self.init(frame: .zero)
		text = title
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class SubLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		textColor = UIColor.trakSecondaryLabel
		textAlignment = .right
		font = UIFont.mainFont(ofSize: 18)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
