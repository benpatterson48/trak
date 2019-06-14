//
//  Underline.swift
//  Trak
//
//  Created by Ben Patterson on 6/13/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class Underline: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.3529411765, blue: 1, alpha: 0.3)
		translatesAutoresizingMaskIntoConstraints = false 
		heightAnchor.constraint(equalToConstant: 2).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
