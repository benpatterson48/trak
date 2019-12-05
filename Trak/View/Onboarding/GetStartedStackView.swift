//
//  GetStartedStackView.swift
//  Trak
//
//  Created by Ben Patterson on 6/12/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class GetStartedStackView: UIView {
	
	let underline = Underline()
	let button = MainBlueButton()
	
	let mainTitle: UILabel = {
		let main = UILabel()
		main.text = "Ready to stay on track?"
		main.textColor = UIColor.label
		main.textAlignment = .left
		main.font = UIFont.mainSemiBoldFont(ofSize: 26)
		main.translatesAutoresizingMaskIntoConstraints = false
		return main
	}()
	
	let subTitle: UILabel = {
		let sub = UILabel()
		sub.text = "Welcome to your personalized payment tracker."
		sub.numberOfLines = 0
		sub.textColor = UIColor.secondaryLabel
		sub.textAlignment = .left
		sub.font = UIFont.mainFont(ofSize: 16)
		sub.translatesAutoresizingMaskIntoConstraints = false
		return sub
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createViews()
		button.setTitle("Join Trak", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
	}
	
	fileprivate func createViews() {
		let titleStackView = UIStackView(arrangedSubviews: [mainTitle, underline, subTitle])
		titleStackView.translatesAutoresizingMaskIntoConstraints = false
		titleStackView.axis = .vertical
		titleStackView.distribution = .fillProportionally
		titleStackView.spacing = 10
		addSubview(titleStackView)
		addSubview(button)
		
		titleStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		titleStackView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -50).isActive = true
		underline.widthAnchor.constraint(equalTo: titleStackView.widthAnchor, multiplier: 1/4).isActive = true
		
		button.heightAnchor.constraint(equalToConstant: 58).isActive = true
		button.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 50).isActive = true
		button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
