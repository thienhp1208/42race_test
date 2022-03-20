//
//  BusinessDetail.swift
//  test_42race
//
//  Created by Thien Huynh on 19/03/2022.
//

import Foundation

// MARK: - BusinessDetail
struct BusinessDetail: Decodable {
    let id: String?
    let alias: String?
    let name: String?
    let imageURL: String?
    let isClaimed: Bool?
    let isClosed: Bool?
    let url: String?
    let phone: String?
    let displayPhone: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let location: Location?
    let coordinates: Coordinates?
    let photos: [String]?
    let price: String?
    let hours: [Hour]?
    let transactions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case alias
        case name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories
        case rating
        case location
        case coordinates
        case photos
        case price
        case hours
        case transactions
    }
}

// MARK: - Hour
struct Hour: Decodable {
    let hourOpen: [Open]?
    let hoursType: String?
    let isOpenNow: Bool?
    
    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Decodable {
    let isOvernight: Bool?
    let start: String?
    let end: String?
    let day: Int?
    
    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start
        case end
        case day
    }
}

