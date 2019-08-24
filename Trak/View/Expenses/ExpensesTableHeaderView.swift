//
//  ExpensesTableHeaderView.swift
//  Trak
//
//  Created by Ben Patterson on 7/8/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

let layout = UICollectionViewFlowLayout()

class ExpensesTableHeaderView: UITableViewHeaderFooterView {
	
	var dataSource = DataSource()
	var unpaidExpenses = [Expense]()
	var paidExpenses = [Expense]()
	var unpaidTotal = Double()
	var paidTotal = Double()
	var expenseTotal = Double()
	var percentage = CGFloat()
	var categoriesArray = [String]()
	
	let bg = UIView()
	let circleViewBG = UIView()
	let keyView = TotalKeyView()
	let topView = MonthSwipeStack()
	let totalStack = TotalStackView()
	let circularView = CircleProgressView()
	
	let categoryCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.estimatedItemSize = CGSize(width: 150, height: 40)
		let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		cv.contentInset.left = 16
		cv.showsHorizontalScrollIndicator = false
		cv.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
		return cv
	}()
	
	static let reuseIdentifier = "tableHeader"
	
	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		categoryCollectionView.delegate = dataSource
		categoryCollectionView.dataSource = dataSource
		calculatingExpenses()
		bg.backgroundColor = .white
		circleViewBG.backgroundColor = .white
		addViews()
		
		categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
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
		
		circleViewBG.layer.addSublayer(circularView.trackLayer)
		circleViewBG.layer.addSublayer(circularView.shapeLayer)
	}
	
	func calculatingExpenses() {
		DataService.instance.grabbingExpenses(month: selectedMonth) { (unpaid, paid) in
			self.calculate(unpaid: unpaid, paid: paid)
		}
	}
	
	func calculate(unpaid: [Expense], paid: [Expense]) {
		self.unpaidExpenses = unpaid
		self.paidExpenses = paid
		self.unpaidTotal = DataService.instance.calculatingExpenses(forExpensesArrayOf: self.unpaidExpenses)
		self.paidTotal = DataService.instance.calculatingExpenses(forExpensesArrayOf: self.paidExpenses)
		self.expenseTotal = DataService.instance.calculatingTotalExpenses(withUnpaidTotal: self.unpaidTotal, paidTotal: self.paidTotal)
		self.totalStack.currentTotalAmountLabel.text = "$\(self.expenseTotal)".currency
		self.keyView.paidStack.dotAmount.text = "$\(self.paidTotal)".currency
		self.keyView.unpaidStack.dotAmount.text = "$\(self.unpaidTotal)".currency
		
		self.percentage = CGFloat(self.paidTotal) / CGFloat(self.expenseTotal)
		self.circularView.shapeLayer.strokeEnd = self.percentage
		DispatchQueue.main.async {
			self.circularView.animateCircle()
		}
	}

	fileprivate func addViews() {
		addSubview(bg)
		addSubview(keyView)
		addSubview(topView)
		addSubview(circleViewBG)
		addSubview(categoryCollectionView)
		circleViewBG.addSubview(totalStack)
		
		bg.translatesAutoresizingMaskIntoConstraints = false
		keyView.translatesAutoresizingMaskIntoConstraints = false
		topView.translatesAutoresizingMaskIntoConstraints = false
		totalStack.translatesAutoresizingMaskIntoConstraints = false
		circleViewBG.translatesAutoresizingMaskIntoConstraints = false
		
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		bg.topAnchor.constraint(equalTo: topAnchor).isActive = true
		bg.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		bg.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		bg.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		
		topView.topAnchor.constraint(equalTo: bg.topAnchor, constant: 16).isActive = true
		topView.leadingAnchor.constraint(equalTo: bg.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: bg.trailingAnchor).isActive = true
		topView.bottomAnchor.constraint(equalTo: circleViewBG.topAnchor, constant: -16).isActive = true
		
		circleViewBG.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).isActive = true
		circleViewBG.leadingAnchor.constraint(equalTo: bg.leadingAnchor).isActive = true
		circleViewBG.trailingAnchor.constraint(equalTo: bg.trailingAnchor).isActive = true
		circleViewBG.bottomAnchor.constraint(equalTo: keyView.topAnchor, constant: -32).isActive = true
		
		totalStack.centerXAnchor.constraint(equalTo: circleViewBG.centerXAnchor).isActive = true
		totalStack.centerYAnchor.constraint(equalTo: circleViewBG.centerYAnchor).isActive = true
		
		keyView.topAnchor.constraint(equalTo: circleViewBG.bottomAnchor, constant: 32).isActive = true
		keyView.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
		keyView.heightAnchor.constraint(equalToConstant: 40).isActive = true
		keyView.bottomAnchor.constraint(equalTo: categoryCollectionView.topAnchor, constant: -32).isActive = true

		categoryCollectionView.topAnchor.constraint(equalTo: keyView.bottomAnchor, constant: 32).isActive = true
		categoryCollectionView.leadingAnchor.constraint(equalTo: bg.leadingAnchor).isActive = true
		categoryCollectionView.trailingAnchor.constraint(equalTo: bg.trailingAnchor).isActive = true
		categoryCollectionView.heightAnchor.constraint(equalToConstant: 84).isActive = true
		categoryCollectionView.bottomAnchor.constraint(equalTo: bg.bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
