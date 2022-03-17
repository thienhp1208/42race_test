//
//  Codable+Extension.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import Foundation

extension Decodable {
    init(from jsonObject: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        try self.init(from: data)
    }

    init(from jsonData: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

extension Encodable {
    func asDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }

        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }

        return dictionary
    }
}
