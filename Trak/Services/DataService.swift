//
//  DataService.swift
//  Trak
//
//  Created by Ben Patterson on 6/19/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit
import Firebase

class DataService {
	var db = Firestore.firestore()
	static let instance = DataService()
	
	func getUsersCategories(handler: @escaping (_ categoriesArray: [String]) -> ()) {
		var categoriesArray = [String]()
		guard let user = Auth.auth().currentUser else { return }
		let docRef = db.collection("users").document(user.uid)
		docRef.getDocument(source: .cache) { (document, error) in
			if let document = document {
				categoriesArray = document.get("categories") as! [String]
				handler(categoriesArray)
			} else {
				print("Document does not exist in cache")
			}
		}
	}
	
}
