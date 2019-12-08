//
//  Header.swift
//  Trak
//
//  Created by Ben Patterson on 6/17/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class HeaderWithLogo: UIView {
	
	let logo: UIImageView = {
		let logo = UIImageView()
		logo.contentMode = .scaleAspectFit
		logo.image = UIImage(named: "trak")
		logo.translatesAutoresizingMaskIntoConstraints = false
		return logo
	}()
	
	let leftBarButtonItem: UIButton = {
		let left = UIButton()
		left.contentMode = .scaleAspectFit
		left.translatesAutoresizingMaskIntoConstraints = false
		left.widthAnchor.constraint(equalToConstant: 20).isActive = true
		left.heightAnchor.constraint(equalToConstant: 20).isActive = true
		return left
	}()
	
	let rightBarButtonItem: UIButton = {
		let right = UIButton()
		right.contentMode = .scaleAspectFit
		right.translatesAutoresizingMaskIntoConstraints = false
		right.widthAnchor.constraint(equalToConstant: 20).isActive = true
		right.heightAnchor.constraint(equalToConstant: 20).isActive = true
		return right
	}()
	
	let bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.tertiarySystemBackground
		view.heightAnchor.constraint(equalToConstant: 1).isActive = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		
		if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
			heightAnchor.constraint(equalToConstant: 70).isActive = true
		} else if UIDevice.current.name == "iPhone 6" || UIDevice.current.name == "iPhone 7" || UIDevice.current.name == "iPhone 8" || UIDevice.current.name == "iPhone 6 Plus" || UIDevice.current.name == "iPhone 7 Plus" || UIDevice.current.name == "iPhone 8 Plus" {
			heightAnchor.constraint(equalToConstant: 80).isActive = true
		} else {
			heightAnchor.constraint(equalToConstant: 100).isActive = true
		}
	}
	
	public convenience init(leftIcon: UIImage, rightIcon: UIImage) {
		self.init()
		leftBarButtonItem.setBackgroundImage(leftIcon, for: .normal)
		rightBarButtonItem.setBackgroundImage(rightIcon, for: .normal)
	}
	
	fileprivate func addViews() {
		let row = UIStackView(arrangedSubviews: [leftBarButtonItem, logo, rightBarButtonItem])
		row.translatesAutoresizingMaskIntoConstraints = false
		addSubview(row)
		
		addSubview(bottomView)
		bottomView.topAnchor.constraint(equalTo: row.bottomAnchor, constant: 16).isActive = true
		bottomView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		bottomView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
		logo.heightAnchor.constraint(equalToConstant: 20).isActive = true
		logo.centerXAnchor.constraint(equalTo: row.centerXAnchor).isActive = true
		row.heightAnchor.constraint(equalToConstant: 20).isActive = true
		row.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -16).isActive = true
		row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class HeaderWithTextTitle: UIView {
	let titleLbl: UILabel = {
		let title = UILabel()
		title.font = UIFont.systemFont(ofSize: 18)
		title.textColor = UIColor.label
		title.textAlignment = .center
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let leftBarButtonItem: UIButton = {
		let left = UIButton()
		left.contentMode = .scaleAspectFit
		left.translatesAutoresizingMaskIntoConstraints = false
		left.widthAnchor.constraint(equalToConstant: 20).isActive = true
		left.heightAnchor.constraint(equalToConstant: 20).isActive = true
		return left
	}()
	
	let rightBarButtonItem: UIButton = {
		let right = UIButton()
		right.contentMode = .scaleAspectFit
		right.translatesAutoresizingMaskIntoConstraints = false
		right.widthAnchor.constraint(equalToConstant: 20).isActive = true
		right.heightAnchor.constraint(equalToConstant: 20).isActive = true
		return right
	}()
	
	let bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.tertiarySystemBackground
		view.heightAnchor.constraint(equalToConstant: 1).isActive = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		backgroundColor = UIColor.systemBackground
		
		if #available(iOS 13, *) {
			heightAnchor.constraint(equalToConstant: 50).isActive = true
		} else {
			if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
				heightAnchor.constraint(equalToConstant: 70).isActive = true
			} else if UIDevice.current.name == "iPhone 6" || UIDevice.current.name == "iPhone 7" || UIDevice.current.name == "iPhone 8" || UIDevice.current.name == "iPhone 6 Plus" || UIDevice.current.name == "iPhone 7 Plus" || UIDevice.current.name == "iPhone 8 Plus" {
				heightAnchor.constraint(equalToConstant: 80).isActive = true
			} else {
				heightAnchor.constraint(equalToConstant: 100).isActive = true
			}
		}
	}
	
	public convenience init(leftIcon: UIImage, rightIcon: UIImage, title: String) {
		self.init()
		titleLbl.text = title
		leftBarButtonItem.setBackgroundImage(leftIcon, for: .normal)
		rightBarButtonItem.setBackgroundImage(rightIcon, for: .normal)
	}
	
	fileprivate func addViews() {
		let row = UIStackView(arrangedSubviews: [leftBarButtonItem, titleLbl, rightBarButtonItem])
		row.translatesAutoresizingMaskIntoConstraints = false
		addSubview(row)
		
		addSubview(bottomView)
		bottomView.topAnchor.constraint(equalTo: row.bottomAnchor, constant: 8).isActive = true
		bottomView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		bottomView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		
		titleLbl.centerXAnchor.constraint(equalTo: row.centerXAnchor).isActive = true
		row.heightAnchor.constraint(equalToConstant: 20).isActive = true
		row.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
		row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
