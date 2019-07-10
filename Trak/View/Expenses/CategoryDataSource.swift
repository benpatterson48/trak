//
//  CategoryDataSource.swift
//  Trak
//
//  Created by Ben Patterson on 7/10/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

class CategoryDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
	
	override init() {
		super.init()
		DataService.instance.getUserCategories { (returned) in
			categoriesArray.append(contentsOf: returned)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print("This is the number of items in section: \(categoriesArray.count)")
		return categoriesArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		print("cell for item at")
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
		collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
		cell.categoryTitle.text = categoriesArray[indexPath.row]
		return cell
	}
	
}
