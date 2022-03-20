//
//  BusinessReviews.swift
//  test_42race
//
//  Created by Thien Huynh on 20/03/2022.
//

import Foundation

// MARK: - BusinessReviews
struct BusinessReviews: Decodable {
    let reviews: [Review]?
    let total: Int?
    let possibleLanguages: [String]?

    enum CodingKeys: String, CodingKey {
        case reviews, total
        case possibleLanguages = "possible_languages"
    }
}

// MARK: - Review
struct Review: Decodable {
    let id: String?
    let url: String?
    let text: String?
    let rating: Double?
    let timeCreated: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, url, text, rating
        case timeCreated = "time_created"
        case user
    }
}

// MARK: - User
struct User: Decodable {
    let id: String?
    let profileURL: String?
    let imageURL: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name
    }
}
