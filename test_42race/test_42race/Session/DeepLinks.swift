//
//  DeepLinks.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

/// A struct describing the deep link structure
public struct DeepLink: Equatable {
    // MARK: - Enumerators

    /// Represents the deep link targets
    enum Target: Equatable {
		case activeAccount(id: Int, hash: String)
        case sampleTarget(value: Int)
		case remoteNotification
    }

    // MARK: - Properties

    /// An original url of a deep link.
    let url: URL?
    /// A target of a deep link.
    let target: Target

    // MARK: - Initialization

    init?(url: URL) {
        guard let components = URLComponents(url: url.absoluteURL, resolvingAgainstBaseURL: true) else { return nil }

		// Check host in-case of scheme string
		let host = components.host ?? ""
		let queryItems = components.queryItems ?? []
		switch host {
		case "activate":
			guard let idString = queryItems.first(where: { $0.name == "id" })?.value,
				  let id = Int(idString),
				  let hash = queryItems.first(where: { $0.name == "hash" })?.value else {
				return nil
			}

			self.target = .activeAccount(id: id, hash: hash)
		case "sampleTarget":
			self.target = .sampleTarget(value: 0)
		default:
			return nil
		}

		self.url = url
    }

	init(target: Target) {
		self.url = nil
		self.target = target
	}
}
