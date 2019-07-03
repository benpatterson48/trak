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

class ExpensesVC: UIViewController, UIScrollViewDelegate {
	
	var categoriesArray = ["All Categories"]
	var ref: DocumentReference? = nil
	
	let bottomBG = UIView()
	let circleViewBG = UIView()
	
	let scrollView = UIScrollView()
	let contentView = UIView()
	
	let sectionNames: Array = ["UNPAID", "PAID"]

	let cell = CategoryCell()
	let emptyState = EmptyState()
	let keyStack = totalKeyView()
	let db = Firestore.firestore()
	let topView = MonthSwipeStack()
	let totalStack = TotalStackView()
	let circularView = CircleProgressView()
	let tableSectionHeader = ExpensesHeader(reuseIdentifier: "header")
	let header = HeaderWithLogo(leftIcon: UIImage(named: "menu")!, rightIcon: UIImage(named: "add")!)

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		checkExpensesArray()
		DataService.instance.getUserCategories { (returnedCategories) in
			self.categoriesArray.append(contentsOf: returnedCategories)
		}
	}
	
//	override func viewDidAppear(_ animated: Bool) {
//		super.viewDidAppear(true)
//		let indexPath = IndexPath(item: 0, section: 0)
//		categoryCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
//	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		addButtonTargets()
		view.backgroundColor = .white
		bottomBG.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		contentView.backgroundColor = .white
		expensesTableView.delegate = self
		expensesTableView.dataSource = self
		categoryCollectionView.delegate = self
		categoryCollectionView.dataSource = self
		
		scrollView.isScrollEnabled = true
//		scrollView.alwaysBounceVertical = true
		scrollView.delegate = self
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
		expensesTableView.frame.size = expensesTableView.contentSize
		let height: CGFloat = contentView.frame.size.height + expensesTableView.frame.size.height
		scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
		scrollView.frame = CGRect(x: 0, y: 116, width: self.view.frame.width, height: self.view.frame.height - 116)
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
		view.addSubview(scrollView)
		scrollView.addSubview(contentView)
		contentView.addSubview(topView)
		contentView.addSubview(keyStack)
		contentView.addSubview(totalStack)
		contentView.addSubview(circleViewBG)
		contentView.addSubview(bottomBG)
		bottomBG.addSubview(categoryCollectionView)
		bottomBG.addSubview(expensesTableView)
		header.translatesAutoresizingMaskIntoConstraints = false
		topView.translatesAutoresizingMaskIntoConstraints = false
		bottomBG.translatesAutoresizingMaskIntoConstraints = false
		keyStack.translatesAutoresizingMaskIntoConstraints = false
		totalStack.translatesAutoresizingMaskIntoConstraints = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		circleViewBG.translatesAutoresizingMaskIntoConstraints = false
		expensesTableView.translatesAutoresizingMaskIntoConstraints = false
		categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
		addConstraints()
	}
	
	fileprivate func addConstraints() {
		header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		header.bottomAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		
		scrollView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
		scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
		contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
		contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		
		topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		topView.bottomAnchor.constraint(equalTo: circleViewBG.topAnchor, constant: -16).isActive = true

		circleViewBG.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16).isActive = true
		circleViewBG.heightAnchor.constraint(equalToConstant: 210).isActive = true
		circleViewBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		circleViewBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		circleViewBG.bottomAnchor.constraint(equalTo: keyStack.topAnchor, constant: -32).isActive = true

		totalStack.centerXAnchor.constraint(equalTo: circleViewBG.centerXAnchor).isActive = true
		totalStack.centerYAnchor.constraint(equalTo: circleViewBG.centerYAnchor).isActive = true

		keyStack.topAnchor.constraint(equalTo: circleViewBG.bottomAnchor, constant: 32).isActive = true
		keyStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		keyStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
		keyStack.bottomAnchor.constraint(equalTo: bottomBG.topAnchor, constant: -40).isActive = true

		bottomBG.topAnchor.constraint(equalTo: keyStack.bottomAnchor, constant: 40).isActive = true
		bottomBG.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		bottomBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		bottomBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

		categoryCollectionView.topAnchor.constraint(equalTo: bottomBG.topAnchor, constant: 16).isActive = true
		categoryCollectionView.leadingAnchor.constraint(equalTo: bottomBG.leadingAnchor, constant: 16).isActive = true
		categoryCollectionView.trailingAnchor.constraint(equalTo: bottomBG.trailingAnchor, constant: -16).isActive = true
		categoryCollectionView.heightAnchor.constraint(equalToConstant: 60).isActive = true

		expensesTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 16).isActive = true
		expensesTableView.leadingAnchor.constraint(equalTo: bottomBG.leadingAnchor).isActive = true
		expensesTableView.trailingAnchor.constraint(equalTo: bottomBG.trailingAnchor).isActive = true
		expensesTableView.bottomAnchor.constraint(equalTo: bottomBG.bottomAnchor, constant: -16).isActive = true
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
	
	let expensesTableView: UITableView = {
		let tv = UITableView(frame: .zero, style: .plain)
		tv.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		tv.separatorColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		tv.isScrollEnabled = false
		tv.register(ExpenseCell.self, forCellReuseIdentifier: "expense")
		tv.register(ExpensesHeader.self, forHeaderFooterViewReuseIdentifier: "header")
		tv.translatesAutoresizingMaskIntoConstraints = false
		return tv
	}()
	
}

extension ExpensesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categoriesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
		cell.categoryTitle.text = categoriesArray[indexPath.row]
		return cell
	}
}

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = expensesTableView.dequeueReusableCell(withIdentifier: "expense", for: indexPath) as? ExpenseCell else { return UITableViewCell() }
		cell.expenseTitle.text = "Car Payment"
		cell.dueDateLabel.text = "Due: 6/28/2019"
		cell.dueAmountLabel.text = "$250.25"
		cell.categoryLabel.text = "Transportation"
		cell.icon.image = UIImage(named: "unpaid-icon")
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let header = expensesTableView.dequeueReusableHeaderFooterView(withIdentifier: tableSectionHeader.reuseIdentifier ?? "header") as? ExpensesHeader else { return nil }
		header.label.text = sectionNames[section]
		header.contentView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
		return header
	}

}
