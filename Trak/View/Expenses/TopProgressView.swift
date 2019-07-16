//
//  TopProgressView.swift
//  Trak
//
//  Created by Ben Patterson on 6/25/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class MonthSwipeStack: UIView {
	
	let monthTitleLabelButton: UIButton = {
		let title = UIButton()
		title.setTitleColor(UIColor.main.lightText, for: .normal)
		title.titleLabel?.font = UIFont.mainFont(ofSize: 18)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let leftArrow: UIButton = {
		let arrow = UIButton()
		arrow.contentMode = .scaleAspectFit
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.widthAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.heightAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.setBackgroundImage(UIImage(named: "left-arrow"), for: .normal)
		return arrow
	}()
	
	let rightArrow: UIButton = {
		let arrow = UIButton()
		arrow.contentMode = .scaleAspectFit
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.widthAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.heightAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.setBackgroundImage(UIImage(named: "right-arrow"), for: .normal)
		return arrow
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		addViews()
		backgroundColor = .white
		heightAnchor.constraint(equalToConstant: 40).isActive = true
		monthTitleLabelButton.setTitle(grabCurrentMonth(), for: .normal)
	}
	
	func addViews() {
		let monthTitleStack = UIStackView(arrangedSubviews: [leftArrow, monthTitleLabelButton, rightArrow])
		monthTitleStack.translatesAutoresizingMaskIntoConstraints = false
		monthTitleStack.distribution = .fillProportionally
		monthTitleStack.spacing = 32
		
		addSubview(monthTitleStack)
		monthTitleStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		monthTitleStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		monthTitleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
		monthTitleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
	}
	
	fileprivate func grabCurrentMonth() -> String {
		let date = Date()
		let month = date.month.uppercased()
		return month
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class CircleProgressView: CALayer {
	
	let shapeLayer = CAShapeLayer()
	let trackLayer = CAShapeLayer()
	
	override init() {
		super.init()
		trackLayer.strokeColor = UIColor.main.yellow.cgColor
		trackLayer.fillColor = UIColor.clear.cgColor
		trackLayer.lineWidth = 20
		trackLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
		
		shapeLayer.strokeColor = UIColor.main.teal.cgColor
		shapeLayer.lineCap = CAShapeLayerLineCap.round
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineWidth = 20
		shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
		
	}
	
	func animateCircle() {
		let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
		
		basicAnimation.duration = 2
		basicAnimation.fillMode = CAMediaTimingFillMode.forwards
		basicAnimation.isRemovedOnCompletion = false
		
		shapeLayer.add(basicAnimation, forKey: "animation")
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class TotalStackView: UIView {
	
	let totalLabel: UILabel = {
		let total = UILabel()
		total.text = "TOTAL"
		total.textAlignment = .center
		total.textColor = UIColor.main.lightText
		total.font = UIFont.mainFont(ofSize: 14)
		total.translatesAutoresizingMaskIntoConstraints = false
		return total
	}()
	
	let currentTotalAmountLabel: UILabel = {
		let current = UILabel()
		current.textAlignment = .center
		current.textColor = UIColor.main.darkText
		current.font = UIFont.mainFont(ofSize: 30)
		current.translatesAutoresizingMaskIntoConstraints = false
		return current
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		backgroundColor = .white
	}
	
	private func createStackView() {
		let totalStack = UIStackView(arrangedSubviews: [totalLabel, currentTotalAmountLabel])
		totalStack.translatesAutoresizingMaskIntoConstraints = false
		totalStack.axis = .vertical
		totalStack.distribution = .fillProportionally
		totalStack.spacing = 5
		addSubview(totalStack)
		
		totalStack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		totalStack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		totalStack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		totalStack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true 
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

class KeyStackView: UIView {
	
	let keyTitle: UILabel = {
		let title = UILabel()
		title.textColor = UIColor.main.lightText
		title.textAlignment = .left
		title.font = UIFont.mainSemiBoldFont(ofSize: 14)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let dotAmount: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = UIColor.main.darkText
		label.font = UIFont.mainFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		backgroundColor = .white
	}
	
	public convenience init(title: String) {
		self.init()
		keyTitle.attributedText = title.increaseLetterSpacing()
	}
	
	private func createStackView() {
		let stack = UIStackView(arrangedSubviews: [keyTitle, dotAmount])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 10
		addSubview(stack)
		
		stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
		stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		stack.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		stack.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class TotalKeyView: UIView {
	
	let paidImage: UIImageView = {
		let dot = UIImageView()
		dot.contentMode = .scaleAspectFit
		dot.image = UIImage(named: "teal-dot")
		dot.translatesAutoresizingMaskIntoConstraints = false
		return dot
	}()
	
	let unpaidImage: UIImageView = {
		let dot = UIImageView()
		dot.contentMode = .scaleAspectFit
		dot.image = UIImage(named: "yellow-dot")
		dot.translatesAutoresizingMaskIntoConstraints = false
		return dot
	}()
	
	let paidStack = KeyStackView(title: "PAID")
	let unpaidStack = KeyStackView(title: "UNPAID")
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackViews()
		backgroundColor = .white
	}
	
	private func createStackViews() {
		let paidStackView = UIStackView(arrangedSubviews: [paidImage, paidStack])
		paidStackView.translatesAutoresizingMaskIntoConstraints = false
		paidStackView.distribution = .fillProportionally
		paidStackView.spacing = 10
		
		let unpaidStackView = UIStackView(arrangedSubviews: [unpaidImage, unpaidStack])
		unpaidStackView.translatesAutoresizingMaskIntoConstraints = false
		unpaidStackView.distribution = .fillProportionally
		unpaidStackView.spacing = 10
		
		let keyStackComplete = UIStackView(arrangedSubviews: [paidStackView, unpaidStackView])
		keyStackComplete.translatesAutoresizingMaskIntoConstraints = false
		keyStackComplete.distribution = .fillProportionally
		keyStackComplete.spacing = 50
		
		addSubview(keyStackComplete)
		keyStackComplete.topAnchor.constraint(equalTo: topAnchor).isActive = true
		keyStackComplete.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		keyStackComplete.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		keyStackComplete.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true 
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
