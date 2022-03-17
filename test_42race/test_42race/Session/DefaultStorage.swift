//
//  DefaultStorage.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import SwiftKeychainWrapper
import UIKit

class DefaultStorage {
	private enum Keys {
		
	}

	private let keychain = KeychainManager.sharedKeychainWrapper

	func set<T: Codable>(_ object: T?, forKey key: String) {
		if let object = object {
			let encoder = JSONEncoder()
			if let data = try? encoder.encode(object) {
				keychain.set(data, forKey: key)
			}
		} else {
			keychain.removeObject(forKey: key)
		}
	}

	func object<T: Codable>(ofType type: T.Type, forKey key: String) -> T? {
		guard let data = keychain.data(forKey: key) else {
			return nil
		}
		let decoder = JSONDecoder()
		guard let object = try? decoder.decode(type.self, from: data) else {
			return nil
		}
		return object
	}
}

/// Provides shared standard KeychainWrapper instance.
/// Computed property sharedKeychainWrapper checks whether it is first access after app installation
/// and removes all keys stored in keychain from previous installation if needed.
struct KeychainManager {
	private enum Keys {
		static let AppInstalled = "keychain_app_installed"
	}

	/// Shared KeychainWrapper instance to use throughout the app
	static let sharedKeychainWrapper: KeychainWrapper = {
		let userDefaults = UserDefaults.standard
		let isAppInstalled = userDefaults.bool(forKey: Keys.AppInstalled)
		if !isAppInstalled {
			KeychainWrapper.standard.removeAllKeys()
			userDefaults.set(true, forKey: Keys.AppInstalled)
			userDefaults.synchronize()
		}
		return KeychainWrapper.standard
	}()

	private init() {}
}
