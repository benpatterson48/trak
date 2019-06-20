//
//  Double.swift
//  Trak
//
//  Created by Ben Patterson on 6/20/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension String  {
	func convertToDollarFormat() -> Double {
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		currencyFormatter.locale = Locale.current
		
		let number = NSNumber(pointer: self)
		guard let priceString = currencyFormatter.string(from: number) else { return 0 }
		guard let convertedNumber = Double(priceString) else { return 0 }
		return convertedNumber
	}
}
