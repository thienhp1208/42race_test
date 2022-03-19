//
//  SearchViewModel.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import Foundation
import RxSwift

enum SearchSortBy: String, CaseIterable, Encodable {
    case distance = "distance"
    case rating = "rating"
}

class SearchViewModel: BaseViewModel {
    private lazy var apiManager = BusinessAPIManager(session: self.session)
    
    var listBusinesses: PublishSubject<[Business]> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var showError: PublishSubject<APIError> = PublishSubject()
}

// MARK: - Helper Method
extension SearchViewModel {
    func search(with text: String = "", isSearchByAddress: Bool = false, isSearchByCategory: Bool = false, sortBy: SearchSortBy? = nil) {
        var term: String?
        var address: String?
        var category: String?
        var lat: Double?
        var lon: Double?
        
        if isSearchByAddress {
            address = text
        } else if isSearchByCategory {
            category = text
            lat = 37.786882
            lon = -122.399972
        } else {
            term = text
            lat = 37.786882
            lon = -122.399972
        }
        isLoading.onNext(true)
        let requestKey = SearchRequestKey(term: term, latitude: lat, longitude: lon, categories: category, location: address, sortBy: sortBy)
        apiManager.search(requestKey: requestKey) { [unowned self] result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let searchResult):
                self.listBusinesses.onNext(searchResult.businesses)
            case .failure(let error):
                self.showError.onNext(error)
                print("For Test: \(error.localizedDescription)")
            }
        }
    }
}
