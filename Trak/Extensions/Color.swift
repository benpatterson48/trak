//
//  Color.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension UIColor {
	
	static var trakBlue: UIColor {
		if #available(iOS 13, *) {
			return systemIndigo
		} else {
			return UIColor(red: 88, green: 86, blue: 214, alpha: 1)
		}
	}
	
	static var trakTeal: UIColor {
		if #available(iOS 13, *) {
			return systemTeal
		} else {
			return UIColor(red: 90, green: 200, blue: 250, alpha: 1)
		}
	}
	
	static var trakYellow: UIColor {
		if #available(iOS 13, *) {
			return systemYellow
		} else {
			return UIColor(red: 255, green: 204, blue: 0, alpha: 1)
		}
	}
	
	static var trakBackground: UIColor {
		if #available(iOS 13, *) {
			return secondarySystemBackground
		} else {
			return UIColor(red: 242, green: 242, blue: 247, alpha: 1)
		}
	}
	
	static var trakLabel: UIColor {
		if #available(iOS 13, *) {
			return label
		} else {
			return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
		}
	}
	
	static var trakSecondaryLabel: UIColor {
		if #available(iOS 13, *) {
			return secondaryLabel
		} else {
			return UIColor(red: 60, green: 60, blue: 67, alpha: 0.6)
		}
	}
	
	static var trakPlaceholderText: UIColor {
		if #available(iOS 13, *) {
			return placeholderText
		} else {
			return UIColor(red: 60, green: 60, blue: 67, alpha: 0.3)
		}
	}
	
	static var trakSeparator: UIColor {
		if #available(iOS 13, *) {
			return separator
		} else {
			return UIColor(red: 60, green: 60, blue: 67, alpha: 0.29)
		}
	}
	
	static var trakOpaqueSeparator: UIColor {
		if #available(iOS 13, *) {
			return opaqueSeparator
		} else {
			return UIColor(red: 198, green: 198, blue: 200, alpha: 1)
		}
	}
	
	static var trakSecondaryBackground: UIColor {
		if #available(iOS 13, *) {
			return secondarySystemBackground
		} else {
			return UIColor(red: 242, green: 242, blue: 247, alpha: 1)
		}
	}
	
	static var trakWhiteBackground: UIColor {
		if #available(iOS 13, *) {
			return systemBackground
		} else {
			return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
		}
	}
	
	static var trakTertiaryWhiteBackground: UIColor {
		if #available(iOS 13, *) {
			return tertiarySystemBackground
		} else {
			return UIColor(red: 255, green: 255, blue: 255, alpha: 1)
		}
	}
	
	static var trakLightText: UIColor {
		if #available(iOS 13, *) {
			return lightText
		} else {
			return UIColor(red: 255, green: 255, blue: 255, alpha: 0.6)
		}
	}
	
	static var trakRed: UIColor {
		if #available(iOS 13, *) {
			return systemRed
		} else {
			return UIColor(red: 255, green: 59, blue: 48, alpha: 0.6)
		}
	}
	
//	struct main {
//		static let blue = #colorLiteral(red: 0.1843137255, green: 0.3529411765, blue: 1, alpha: 1)
//		static let darkText = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 1)
//		static let lightText = #colorLiteral(red: 0.4196078431, green: 0.4509803922, blue: 0.5098039216, alpha: 1)
//		static let yellow = #colorLiteral(red: 0.968627451, green: 0.7568627451, blue: 0.2156862745, alpha: 1)
//		static let teal = #colorLiteral(red: 0.007843137255, green: 0.7568627451, blue: 0.831372549, alpha: 1)
//		static let offWhiteBackground = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		static let lightBlueBackground = #colorLiteral(red: 0.8392156863, green: 0.8745098039, blue: 0.9882352941, alpha: 1)
//	}
}
