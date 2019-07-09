//
//  DataService.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DataService {
	var db = Firestore.firestore()
	static let instance = DataService()
	
	func getUserCategories(handler: @escaping (_ categoriesArray: [String]) -> ()) {
		var categoriesArray = [String]()
		guard let user = Auth.auth().currentUser else { return }
		let docRef = db.collection("users").document(user.uid)
		docRef.getDocument() { (document, error) in
			if let document = document {
				let property = document.get("categories")
				categoriesArray = property as? [String] ?? []
				handler(categoriesArray)
			} else {
				print("Document does not exist in cache")
			}
		}
	}
	
}
