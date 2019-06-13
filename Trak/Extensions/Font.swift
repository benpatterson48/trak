//
//  Font.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension UIFont {
	static func customFont(name: String, size: CGFloat) -> UIFont {
		let font = UIFont(name: name, size: size)
		assert(font != nil, "Can't load font: \(name)")
		return font ?? UIFont.systemFont(ofSize: size)
	}
	
	static func mainFont(ofSize size: CGFloat) -> UIFont {
		return customFont(name: "SFProText-Regular", size: size)
	}
	
	static func mainLightFont(ofSize size: CGFloat) -> UIFont {
		return customFont(name: "SFProText-Light", size: size)
	}
	
	static func mainThinFont(ofSize size: CGFloat) -> UIFont {
		return customFont(name: "SFProText-Thin", size: size)
	}
	
	static func mainSemiBoldFont(ofSize size: CGFloat) -> UIFont {
		return customFont(name: "SFProText-Semibold", size: size)
	}
	
	static func mainBoldFont(ofSize size: CGFloat) -> UIFont {
		return customFont(name: "SFProText-Bold", size: size)
	}
}
