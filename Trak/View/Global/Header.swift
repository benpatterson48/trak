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
		logo.image = UIImage(named: "trak")
		logo.contentMode = .scaleAspectFit
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
		view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9176470588, blue: 0.9450980392, alpha: 1)
		view.heightAnchor.constraint(equalToConstant: 2).isActive = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		heightAnchor.constraint(equalToConstant: 116).isActive = true
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
		title.font = UIFont.mainFont(ofSize: 18)
		title.textColor = UIColor.main.darkText
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
		view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9176470588, blue: 0.9450980392, alpha: 1)
		view.heightAnchor.constraint(equalToConstant: 2).isActive = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addViews()
		backgroundColor = .white
		heightAnchor.constraint(equalToConstant: 100).isActive = true
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
		bottomView.topAnchor.constraint(equalTo: row.bottomAnchor, constant: 16).isActive = true
		bottomView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		bottomView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		
		titleLbl.centerXAnchor.constraint(equalTo: row.centerXAnchor).isActive = true
		row.heightAnchor.constraint(equalToConstant: 20).isActive = true
		row.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
		row.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
		row.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
