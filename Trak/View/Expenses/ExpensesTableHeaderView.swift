//
//  ExpensesTableHeaderView.swift
//  Trak
//
//  Created by Ben Patterson on 7/8/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class ExpensesTableHeaderView: UITableViewHeaderFooterView {
	
	let circleViewBG = UIView()

	let keyView = totalKeyView()
	let topView = MonthSwipeStack()
	let totalStack = TotalStackView()
	let circularView = CircleProgressView()
	
	let categoryCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.estimatedItemSize = CGSize(width: 150, height: 40)
		let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = .blue
		cv.showsHorizontalScrollIndicator = false
		return cv
	}()
	
	static let reuseIdentifier = "tableHeader"
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addViews()
		circleViewBG.backgroundColor = .white
	}
	
	override func layoutSubviews() {
		setCirclePath()
	}
	
	fileprivate func setCirclePath() {
		let point = CGPoint(x: circleViewBG.bounds.midX, y: circleViewBG.bounds.midY)
		let circularPath = UIBezierPath(arcCenter: .zero, radius: 94, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
		
		circularView.trackLayer.position = point
		circularView.shapeLayer.position = point
		circularView.trackLayer.path = circularPath.cgPath
		circularView.shapeLayer.path = circularPath.cgPath
		circularView.shapeLayer.strokeEnd = -CGFloat.pi / 2
		
		circleViewBG.layer.addSublayer(circularView.trackLayer)
		circleViewBG.layer.addSublayer(circularView.shapeLayer)
	}
	
	fileprivate func addViews() {
		addSubview(keyView)
		addSubview(topView)
		addSubview(circleViewBG)
		addSubview(categoryCollectionView)
		circleViewBG.addSubview(totalStack)
		
		keyView.translatesAutoresizingMaskIntoConstraints = false
		topView.translatesAutoresizingMaskIntoConstraints = false
		totalStack.translatesAutoresizingMaskIntoConstraints = false
		circleViewBG.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		topView.bottomAnchor.constraint(equalTo: circleViewBG.topAnchor, constant: -16).isActive = true
		
		circleViewBG.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).isActive = true
		circleViewBG.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		circleViewBG.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		circleViewBG.bottomAnchor.constraint(equalTo: keyView.topAnchor, constant: -32).isActive = true
		
		totalStack.centerXAnchor.constraint(equalTo: circleViewBG.centerXAnchor).isActive = true
		totalStack.centerYAnchor.constraint(equalTo: circleViewBG.centerYAnchor).isActive = true
		
		keyView.topAnchor.constraint(equalTo: circleViewBG.bottomAnchor, constant: 32).isActive = true
		keyView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		keyView.heightAnchor.constraint(equalToConstant: 40).isActive = true
		keyView.bottomAnchor.constraint(equalTo: categoryCollectionView.topAnchor, constant: -32).isActive = true
		
		categoryCollectionView.topAnchor.constraint(equalTo: keyView.bottomAnchor, constant: 32).isActive = true
		categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		categoryCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		categoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
