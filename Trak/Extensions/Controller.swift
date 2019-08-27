//
//  Controller.swift
//  Trak
//
//  Created by Ben Patterson on 8/26/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import UIKit

extension UIViewController {
	func presentFromRight(_ viewControllerToPresent: UIViewController) {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = CATransitionType.fade
		transition.subtype = CATransitionSubtype.fromRight
		self.view.window?.layer.add(transition, forKey: kCATransition)
		
		present(viewControllerToPresent, animated: false, completion: nil)
	}
	
	func fadeFromRight(_ viewControllerToPresent: UIViewController) {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = CATransitionType.fade
		transition.subtype = CATransitionSubtype.fromRight
		self.view.window?.layer.add(transition, forKey: kCATransition)
		
		present(viewControllerToPresent, animated: false, completion: nil)
	}
	
	func dismissFromLeft() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = CATransitionType.fade
		transition.subtype = CATransitionSubtype.fromLeft
		self.view.window?.layer.add(transition, forKey: kCATransition)
		
		dismiss(animated: false, completion: nil)
	}
	
	func dismissFromRight() {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = CATransitionType.fade
		transition.subtype = CATransitionSubtype.fromRight
		self.view.window?.layer.add(transition, forKey: kCATransition)
		
		dismiss(animated: false, completion: nil)
	}
	
	func presentFromLeft(viewControllerToPresent: UIViewController) {
		let transition = CATransition()
		transition.duration = 0.3
		transition.type = CATransitionType.fade
		transition.subtype = CATransitionSubtype.fromLeft
		self.view.window?.layer.add(transition, forKey: kCATransition)
		
		present(viewControllerToPresent, animated: false, completion: nil)
		
	}
}
