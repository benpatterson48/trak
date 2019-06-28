//
//  ExpensesVC.swift
//  Trak
//
//  Created by Ben Patterson on 6/14/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ExpensesVC: UIViewController {
	
	var categoriesArray = ["All Categories"]
	var ref: DocumentReference? = nil
	
	let bottomBG = UIView()
	let circleViewBG = UIView()

	let cell = CategoryCell()
	let emptyState = EmptyState()
	let keyStack = totalKeyView()
	let db = Firestore.firestore()
	let topView = MonthSwipeStack()
	let totalStack = TotalStackView()
	let circularView = CircleProgressView()
	let header = HeaderWithLogo(leftIcon: UIImage(named: "menu")!, rightIcon: UIImage(named: "add")!)

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		checkExpensesArray()
		DataService.instance.getUserCategories { (returnedCategories) in
			self.categoriesArray.append(contentsOf: returnedCategories)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addButtonTargets()
		view.backgroundColor = .white
		bottomBG.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		categoryCollectionView.delegate = self
		categoryCollectionView.dataSource = self
	}
	
	fileprivate func addButtonTargets() {
		emptyState.button.addTarget(self, action: #selector(addNewPaymentButtonWasPressed), for: .touchUpInside)
	}
	
	@objc func addNewPaymentButtonWasPressed() {
		let add = AddExpenseVC()
		present(add, animated: true, completion: nil)
	}
	
	fileprivate func checkExpensesArray() {
		let current = Date()
		let year = current.year
		guard let user = Auth.auth().currentUser else { return }
		db.collection("users").document(user.uid).collection(year).getDocuments { (documents, error) in
			if let documents = documents, documents.isEmpty == false {
				self.addViews()
			} else {
				self.addEmptyStateViews()
			}
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
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
		view.addSubview(header)
		view.addSubview(topView)
		view.addSubview(bottomBG)
		view.addSubview(keyStack)
		view.addSubview(totalStack)
		view.addSubview(circleViewBG)
		bottomBG.addSubview(categoryCollectionView)
		header.translatesAutoresizingMaskIntoConstraints = false
		topView.translatesAutoresizingMaskIntoConstraints = false
		bottomBG.translatesAutoresizingMaskIntoConstraints = false
		keyStack.translatesAutoresizingMaskIntoConstraints = false
		totalStack.translatesAutoresizingMaskIntoConstraints = false
		circleViewBG.translatesAutoresizingMaskIntoConstraints = false
		categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		topView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		circleViewBG.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).isActive = true
		circleViewBG.heightAnchor.constraint(equalToConstant: 210).isActive = true
		circleViewBG.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		circleViewBG.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		totalStack.centerXAnchor.constraint(equalTo: circleViewBG.centerXAnchor).isActive = true
		totalStack.centerYAnchor.constraint(equalTo: circleViewBG.centerYAnchor).isActive = true
		
		keyStack.topAnchor.constraint(equalTo: circleViewBG.bottomAnchor, constant: 32).isActive = true
		keyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		keyStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		bottomBG.topAnchor.constraint(equalTo: keyStack.bottomAnchor, constant: 40).isActive = true
		bottomBG.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		bottomBG.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		bottomBG.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		categoryCollectionView.topAnchor.constraint(equalTo: bottomBG.topAnchor, constant: 16).isActive = true
		categoryCollectionView.leadingAnchor.constraint(equalTo: bottomBG.leadingAnchor, constant: 16).isActive = true
		categoryCollectionView.trailingAnchor.constraint(equalTo: bottomBG.trailingAnchor, constant: -16).isActive = true
		categoryCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
	
	fileprivate func addEmptyStateViews() {
		view.addSubview(header)
		header.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(emptyState)
		emptyState.translatesAutoresizingMaskIntoConstraints = false
		addEmptyStateConstraints()
	}
	
	fileprivate func addEmptyStateConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		emptyState.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		emptyState.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		emptyState.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
		emptyState.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -32).isActive = true
	}
	
	let categoryCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.estimatedItemSize = CGSize(width: 150, height: 40)
		let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		cv.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
		cv.translatesAutoresizingMaskIntoConstraints = false
		cv.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		cv.showsHorizontalScrollIndicator = false
		return cv
	}()
}

extension ExpensesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return CGSize(width: 125, height: 40)
//	}
//	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
		cell.categoryTitle.text = categoriesArray[indexPath.row]
		return cell
	}
}
