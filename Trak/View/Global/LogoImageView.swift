//
//  LogoImageView.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class LogoImageView: UIView {
	let logo: UIImageView = {
		let logo = UIImageView()
		logo.contentMode = .scaleAspectFit
		logo.image = UIImage(named: "trak")
		logo.widthAnchor.constraint(equalToConstant: 110).isActive = true 
		logo.translatesAutoresizingMaskIntoConstraints = false
		return logo
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraints()
	}
	
	fileprivate func setupConstraints() {
		addSubview(logo)
		logo.topAnchor.constraint(equalTo: topAnchor).isActive = true
		logo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		logo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		logo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
