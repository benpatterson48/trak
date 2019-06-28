//
//  Double.swift
//  Trak
//
//  Created by Ben Patterson on 6/20/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension String  {
	var currency: String {
		let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
		let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")
		
		let styler = NumberFormatter()
		styler.minimumFractionDigits = 2
		styler.maximumFractionDigits = 2
		styler.currencySymbol = "$"
		styler.numberStyle = .currency
		
		if let result = NumberFormatter().number(from: stringWithoutComma) {
			return styler.string(from: result)!
		}
		
		return self
	}
	
	var removeCurrency: String {
		let stringWithoutSymbol = self.replacingOccurrences(of: "$", with: "")
		let stringWithoutComma = stringWithoutSymbol.replacingOccurrences(of: ",", with: "")
		let styler = NumberFormatter()
		styler.minimumFractionDigits = 2
		styler.maximumFractionDigits = 2
		styler.currencySymbol = .none
		styler.numberStyle = .none
		
		if let result = NumberFormatter().number(from: stringWithoutComma) {
			return styler.string(from: result)!
		}
		return self
	}
}
