//
//  EmptyState.swift
//  Trak
//
//  Created by Ben Patterson on 6/15/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class EmptyState: UIView {
	
	let button = MainBlueButton()
	
	let icon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		icon.heightAnchor.constraint(equalToConstant: 100).isActive = true
		icon.widthAnchor.constraint(equalToConstant: 100).isActive = true
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	let mainTitle: UILabel = {
		let main = UILabel()
		main.numberOfLines = 0
		main.text = "You have no payments!"
		main.textColor = UIColor.label
		main.textAlignment = .center
		main.translatesAutoresizingMaskIntoConstraints = false
		return main
	}()
	
	let subTitle: UILabel = {
		let sub = UILabel()
		sub.text = "Welcome to your personalized payment tracker."
		sub.numberOfLines = 0
		sub.textColor = UIColor.secondaryLabel
		sub.textAlignment = .center
		sub.font = UIFont.systemFont(ofSize: 16)
		sub.translatesAutoresizingMaskIntoConstraints = false
		return sub
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		button.setTitle("Add New Payment", for: .normal)
		
		if #available(iOS 13, *) {
			icon.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor.systemBlue, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 100))
		} else {
			icon.image = UIImage(named: "check")
		}

	}
	
	fileprivate func addViews() {
		let labels = UIStackView(arrangedSubviews: [mainTitle, subTitle])
		labels.translatesAutoresizingMaskIntoConstraints = false
		labels.axis = .vertical
		labels.alignment = .center
		labels.distribution = .fillProportionally
		labels.spacing = 8
		addSubview(labels)
		
		if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
			mainTitle.font = UIFont.boldSystemFont(ofSize: 22)
		} else {
			mainTitle.font = UIFont.boldSystemFont(ofSize: 26)
		}
		
		mainTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
		subTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		let mainStackView = UIStackView(arrangedSubviews: [icon, labels, button])
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.axis = .vertical
		mainStackView.alignment = .center
		mainStackView.spacing = 30
		mainStackView.distribution = .fillProportionally
		addSubview(mainStackView)
		
		labels.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor).isActive = true
		labels.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true 
		
		button.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor).isActive = true
		button.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true
		button.heightAnchor.constraint(equalToConstant: 58).isActive = true
		
		mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
