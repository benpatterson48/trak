//
//  Button.swift
//  Trak
//
//  Created by Ben Patterson on 6/15/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

let activitySpinner: UIActivityIndicatorView = {
	let ac = UIActivityIndicatorView()
	ac.style = UIActivityIndicatorView.Style.large
	ac.translatesAutoresizingMaskIntoConstraints = false
	return ac
}()

extension UIButton {
	
	func loading() {
		addSubview(activitySpinner)
		setTitle("", for: .normal)
		activitySpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		activitySpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		activitySpinner.startAnimating()
	}
	
	func stopLoading(title: String) {
		activitySpinner.stopAnimating()
		setTitle("\(title)", for: .normal)
	}
}
