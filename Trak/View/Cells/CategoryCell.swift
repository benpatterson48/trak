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
		pill.backgroundColor = UIColor.secondarySystemBackground
		pill.layer.cornerRadius = 16
		pill.translatesAutoresizingMaskIntoConstraints = false
		return pill
	}()
	
	let categoryTitle: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = UIColor.secondaryLabel
		title.font = UIFont.mainSemiBoldFont(ofSize: 18)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		translatesAutoresizingMaskIntoConstraints = false 
		heightAnchor.constraint(equalToConstant: 84).isActive = true
		backgroundColor = UIColor.secondarySystemBackground
	}
	
	override var isSelected: Bool {
		didSet {
			if self.isSelected == true {
				self.pillBG.backgroundColor = UIColor.systemBlue
				self.categoryTitle.textColor = UIColor.white
			} else {
				self.categoryTitle.textColor = UIColor.secondaryLabel
				self.pillBG.backgroundColor = UIColor.secondarySystemBackground
			}
		}
	}
	
	private func setupViews() {
		addSubview(pillBG)
		addSubview(categoryTitle)
		pillBG.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
		pillBG.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
		pillBG.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		pillBG.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		pillBG.heightAnchor.constraint(equalToConstant: 36).isActive = true
		
		categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
		categoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true 
		categoryTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
