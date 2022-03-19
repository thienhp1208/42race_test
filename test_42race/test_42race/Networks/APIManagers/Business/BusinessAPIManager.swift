//
//  BusinessAPIManager.swift
//  test_42race
//
//  Created by For Test Only on 18/03/2022.
//

import Foundation

class BusinessAPIManager: BaseAPIManager<BusinessTarget> {
    func search(requestKey: SearchRequestKey, completion: @escaping (Result<SearchResult, APIError>) -> Void) {
        request(target: BusinessTarget.searchBusinesses(requestKey.asDictionary()), type: SearchResult.self, dataField: .none) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
