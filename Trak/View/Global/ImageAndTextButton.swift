//
//  ImageAndTextButton.swift
//  Trak
//
//  Created by Ben Patterson on 6/18/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ImageAndTextButton: UIView {
	let label: UIButton = {
		let label = UIButton()
		label.setTitleColor(#colorLiteral(red: 0.231372549, green: 0.3921568627, blue: 1, alpha: 1), for: .normal)
		label.titleLabel?.font = UIFont.systemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let icon: UIButton = {
		let icon = UIButton()
		icon.translatesAutoresizingMaskIntoConstraints = false
		icon.heightAnchor.constraint(equalToConstant: 20).isActive = true
		icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
		return icon
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupConstraints()
	}
	
	public convenience init(labelText: String, iconImage: String) {
		self.init(frame: .zero)
		label.setTitle(labelText, for: .normal)
		icon.setBackgroundImage(UIImage(named: iconImage), for: .normal)
	}
	
	fileprivate func setupConstraints() {
		let stackView = UIStackView(arrangedSubviews: [icon, label])
		stackView.spacing = 8
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(stackView)
		stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
