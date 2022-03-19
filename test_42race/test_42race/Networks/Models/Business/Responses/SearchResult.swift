//
//  BusinessDetail.swift
//  test_42race
//
//  Created by For Test Only on 18/03/2022.
//

import Foundation

// MARK: - Search Result
struct SearchResult: Decodable {
    let businesses: [Business]
    let total: Int
}

// MARK: - Business
struct Business: Decodable {
    let id: String
    let alias: String
    let name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let transactions: [String]
    let price: String?
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case displayPhone = "display_phone"
        case distance
    }
}

// MARK: - Category
struct Category: Decodable {
    let alias: String
    let title: String
}

// MARK: - Location
struct Location: Decodable {
    let address1: String
    let address2: String?
    let address3: String?
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country
        case state
        case displayAddress = "display_address"
    }
}

// MARK: - Center
struct Center: Decodable {
    let latitude: Double
    let longitude: Double
}
