//
//  SearchViewModel.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import Foundation

enum SearchSortBy: String, CaseIterable, Encodable {
    case nearBy = "distance"
    case rating = "rating"
}

class SearchViewModel: BaseViewModel {
    
}

// MARK: - Helper Method
extension SearchViewModel {
    func search(with text: String = "", isSearchByAddress: Bool = false, isSearchByCategory: Bool = false, sortBy: SearchSortBy? = nil) {
        
    }
}
