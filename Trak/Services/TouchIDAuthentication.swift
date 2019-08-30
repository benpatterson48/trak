//
//  TouchIDAuthentication.swift
//  Trak
//
//  Created by Ben Patterson on 8/29/19.
//  Copyright © 2019 Ben Patterson. All rights reserved.
//

import Foundation
import LocalAuthentication

enum BiometricType {
	case none
	case touchID
	case faceID
}

class BiometricIDAuth {
	let context = LAContext()
	var loginReason = "Place Your Thumb to Log In"
	
	func canEvaluatePolicy() -> Bool {
		return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
	}
	
	func biometricType() -> BiometricType {
		let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
		switch context.biometryType {
		case .none:
			return .none
		case .touchID:
			return .touchID
		case .faceID:
			return .faceID
		@unknown default:
			fatalError("Sorry, we couldn't access this right now.")
		}
	}
	
	func authenticateUser(completion: @escaping (String?) -> Void) {
		guard canEvaluatePolicy() else {
			completion("Touch ID not available")
			return
		}
		
		context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
							   localizedReason: loginReason) { (success, evaluateError) in
								if success {
									DispatchQueue.main.async {
										print("we had success authenticating our user")
										completion(nil)
									}
								} else {
									let message: String
									switch evaluateError {
									case LAError.authenticationFailed?:
										message = "There was a problem verifying your identity."
									case LAError.userCancel?:
										message = "You pressed cancel."
									case LAError.userFallback?:
										message = "You pressed password."
									case LAError.biometryNotAvailable?:
										message = "Face ID/Touch ID is not available."
									case LAError.biometryNotEnrolled?:
										message = "Face ID/Touch ID is not set up."
									case LAError.biometryLockout?:
										message = "Face ID/Touch ID is locked."
									default:
										message = "Face ID/Touch ID may not be configured"
									}
									completion(message)
								}
		}
	}
}
