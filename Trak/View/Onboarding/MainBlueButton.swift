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
		backgroundColor = UIColor.systemBlue
		layer.cornerRadius = 26
		layer.borderWidth = 4
		layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8705882353, blue: 1, alpha: 1)
		setTitleColor(UIColor.white, for: .normal)
		titleLabel?.font = UIFont.systemFont(ofSize: 18)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
