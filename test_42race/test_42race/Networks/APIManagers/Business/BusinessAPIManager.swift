//
//  BusinessAPIManager.swift
//  test_42race
//
//  Created by Thien Huynh on 18/03/2022.
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
    
    func getBusiness(by id: String, completion: @escaping (Result<BusinessDetail, APIError>) -> Void) {
        request(target: BusinessTarget.getBusinessById(id), type: BusinessDetail.self, dataField: .none) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBusinessReviews(with alias: String, completion: @escaping (Result<BusinessReviews, APIError>) -> Void) {
        request(target: BusinessTarget.getBusinessReview(alias),
                type: BusinessReviews.self,
                dataField: .none) { result in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
