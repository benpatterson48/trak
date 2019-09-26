//
//  TopProgressView.swift
//  Trak
//
//  Created by Ben Patterson on 6/25/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

let picker = MonthPickerView()

class MonthSwipeStack: UIView {
	
	let monthTextField: UILabel = {
		let title = UILabel()
		title.textAlignment = .center
		title.textColor = UIColor.trakSecondaryLabel
		title.font = UIFont.mainFont(ofSize: 18)
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
		arrow.addTarget(self, action: #selector(leftArrowPressed), for: .touchUpInside)
		return arrow
	}()
	
	@objc func leftArrowPressed() {
		if let index = monthArray.firstIndex(of: selectedMonth) {
			if index == 0 {
				selectedMonth = monthArray[index]
			} else {
				selectedMonth = monthArray[index - 1]
				let month:[String: String] = ["newMonth": selectedMonth]
				NotificationCenter.default.post(name: .init("monthUpdated"), object: nil, userInfo: month)
			}
		}
	}
	
	let rightArrow: UIButton = {
		let arrow = UIButton()
		arrow.contentMode = .scaleAspectFit
		arrow.translatesAutoresizingMaskIntoConstraints = false
		arrow.widthAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.heightAnchor.constraint(equalToConstant: 40).isActive = true
		arrow.setBackgroundImage(UIImage(named: "right-arrow"), for: .normal)
		arrow.addTarget(self, action: #selector(rightArrowPressed), for: .touchUpInside)
		return arrow
	}()
	
	@objc func rightArrowPressed() {
		if let index = monthArray.firstIndex(of: selectedMonth) {
			if index == 11 {
				selectedMonth = monthArray[index]
			} else {
				selectedMonth = monthArray[index + 1]
				let month:[String: String] = ["newMonth": selectedMonth]
				NotificationCenter.default.post(name: .init("monthUpdated"), object: nil, userInfo: month)
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.trakTertiaryWhiteBackground
		addViews()
		heightAnchor.constraint(equalToConstant: 48).isActive = true
		monthTextField.text = selectedMonth.uppercased()
	}
	
	func addViews() {
		let monthTitleStack = UIStackView(arrangedSubviews: [leftArrow, monthTextField, rightArrow])
		monthTitleStack.translatesAutoresizingMaskIntoConstraints = false
		monthTitleStack.distribution = .fillProportionally
		monthTitleStack.spacing = 32
		
		addSubview(monthTitleStack)
		monthTitleStack.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
		monthTitleStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
		
		if UIDevice.current.name == "iPhone SE" || UIDevice.current.name == "iPhone 5" || UIDevice.current.name == "iPhone 5s" {
			monthTitleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
			monthTitleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
		} else {
			monthTitleStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
			monthTitleStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
		}
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
		trackLayer.strokeColor = UIColor.trakYellow.cgColor
		trackLayer.fillColor = UIColor.clear.cgColor
		trackLayer.lineWidth = 22
		trackLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
		
		shapeLayer.strokeColor = UIColor.trakTeal.cgColor
		shapeLayer.lineCap = CAShapeLayerLineCap.round
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineWidth = 22
		shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
		
	}
	
	func animateCircle() {
		let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
		
		basicAnimation.duration = 1
		basicAnimation.fillMode = CAMediaTimingFillMode.forwards
		basicAnimation.fromValue = 0
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
		total.adjustsFontSizeToFitWidth = true
		total.textColor = UIColor.trakSecondaryLabel
		total.font = UIFont.mainFont(ofSize: 18)
		total.translatesAutoresizingMaskIntoConstraints = false
		return total
	}()
	
	let currentTotalAmountLabel: UILabel = {
		let current = UILabel()
		current.textColor = UIColor.trakLabel
		current.textAlignment = .center
		current.adjustsFontSizeToFitWidth = true
		current.font = UIFont.systemFont(ofSize: 34, weight: .medium)
		current.translatesAutoresizingMaskIntoConstraints = false
		return current
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		backgroundColor = UIColor.trakTertiaryWhiteBackground
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
		title.textColor = UIColor.trakSecondaryLabel
		title.textAlignment = .left
		title.font = UIFont.mainSemiBoldFont(ofSize: 14)
		title.translatesAutoresizingMaskIntoConstraints = false
		return title
	}()
	
	let dotAmount: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = UIColor.trakLabel
		label.font = UIFont.mainFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		createStackView()
		backgroundColor = UIColor.trakTertiaryWhiteBackground
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
		backgroundColor = UIColor.trakTertiaryWhiteBackground
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
