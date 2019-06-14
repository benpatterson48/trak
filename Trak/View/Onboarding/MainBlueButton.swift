//
//  MainBlueButton.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class MainBlueButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.main.blue
		layer.cornerRadius = 26
		layer.borderWidth = 4
		layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8705882353, blue: 1, alpha: 1)
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.mainFont(ofSize: 18)
	}
	
	public convenience init(title: String) {
		self.init(frame: .zero)
		setTitle(title, for: .normal)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}