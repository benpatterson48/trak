//
//  CategoryCell.swift
//  Trak
//
//  Created by Ben Patterson on 6/27/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
	
	let pillBG: UIView = {
		let pill = UIView()
		pill.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
		pill.layer.cornerRadius = 16
		pill.translatesAutoresizingMaskIntoConstraints = false
		return pill
	}()
	
	let categoryTitle: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 0.8)
		title.font = UIFont.mainSemiBoldFont(ofSize: 18)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		setupViews()
		translatesAutoresizingMaskIntoConstraints = false 
		heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	override var isSelected: Bool {
		didSet {
			self.pillBG.backgroundColor = self.isSelected ? UIColor.main.lightBlueBackground : .clear
			self.categoryTitle.textColor = self.isSelected ? UIColor.main.darkText : #colorLiteral(red: 0.1843137255, green: 0.2196078431, blue: 0.3019607843, alpha: 0.8)
		}
	}
	
	private func setupViews() {
		addSubview(pillBG)
		addSubview(categoryTitle)
		pillBG.topAnchor.constraint(equalTo: topAnchor, constant: 9).isActive = true
		pillBG.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9).isActive = true
		pillBG.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		pillBG.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		pillBG.heightAnchor.constraint(equalToConstant: 32).isActive = true
		
		categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
		categoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true 
		categoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
