//
//  SearchRequestKey.swift
//  test_42race
//
//  Created by Thien Huynh on 18/03/2022.
//

import Foundation

struct SearchRequestKey: Encodable {
    let term: String?
    let latitude: Double?
    let longitude: Double?
    let categories: String?
    let location: String?
    let sortBy: SortMethod?
    
    enum CodingKeys: String, CodingKey {
        case term
        case latitude
        case longitude
        case categories
        case location
        case sortBy = "sort_by"
    }
}
