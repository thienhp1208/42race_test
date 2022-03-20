//
//  SearchViewModel.swift
//  test_42race
//
//  Created by Thien Huynh on 17/03/2022.
//

import Foundation
import RxSwift
import CoreLocation

enum SortMethod: String, CaseIterable, Encodable {
    case distance = "distance"
    case rating = "rating"
    
    var title: String {
        switch self {
        case .distance:
            return "Distance"
        case .rating:
            return "Rating"
        }
    }
}

enum SearchMethod: String, CaseIterable, Encodable {
    case name = "term"
    case location = "address"
    case categories = "categories"
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .location:
            return "Address/City/Postal Code"
        case .categories:
            return "Categories"
        }
    }
}

struct FilterItem {
    var title: String
    var isSelected: Bool = false
}

class SearchViewModel: BaseViewModel {
    // MARK: - Properties
    private lazy var apiManager = BusinessAPIManager(session: self.session)
    
    var businesses: [Business] = []
    var locationManager = CLLocationManager()
    private var selectedSortMethod: SortMethod?
    private var selectedSearchMethod: SearchMethod = .name
    
    var listBusinesses: PublishSubject<[Business]> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var showError: PublishSubject<APIError> = PublishSubject()
    var sortByList: PublishSubject<[FilterItem]> = PublishSubject()
    var searchByList: PublishSubject<[FilterItem]> = PublishSubject()
    var selectedBusiness: PublishSubject<BusinessDetail> = PublishSubject()
}

// MARK: - Helper Method
extension SearchViewModel {
    func initViewModel() {
        let sortByMethods = SortMethod.allCases.map({ FilterItem(title: $0.title, isSelected: false) })
        sortByList.onNext(sortByMethods)
        
        let searchMethods = SearchMethod.allCases.map({ FilterItem(title: $0.title, isSelected: $0 == self.selectedSearchMethod) })
        searchByList.onNext(searchMethods)
    }
    
    func updateSortMethod(at index: Int) {
        self.selectedSortMethod = SortMethod.allCases[index]
        let sortByMethods = SortMethod.allCases.map({ FilterItem(title: $0.title, isSelected: $0 == self.selectedSortMethod) })
        sortByList.onNext(sortByMethods)
    }
    
    func updateSearchMethod(at index: Int) {
        self.selectedSearchMethod = SearchMethod.allCases[index]
        let searchMethods = SearchMethod.allCases.map({ FilterItem(title: $0.title, isSelected: $0 == self.selectedSearchMethod) })
        searchByList.onNext(searchMethods)
    }
    
    func search(with text: String) {
        if #available(iOS 14.0, *) {
            if locationManager.authorizationStatus != .authorizedAlways &&
                locationManager.authorizationStatus != .authorizedWhenInUse &&
                locationManager.authorizationStatus != .authorized {
                showError.onNext(.locationAuthorized)
                return
            }
        } else {
            if CLLocationManager.authorizationStatus() != .authorizedAlways &&
                CLLocationManager.authorizationStatus() != .authorizedWhenInUse &&
                CLLocationManager.authorizationStatus() != .authorized {
                showError.onNext(.locationAuthorized)
                return
            }
        }
        
        guard let currentLocation = locationManager.location?.coordinate else {
            showError.onNext(.unableGetLocation)
            return
        }
        
        if text.isEmpty {
            self.showError.onNext(.emptySearchField)
            return
        }
        
        var term: String?
        var address: String?
        var category: String?
        var lat: Double?
        var lon: Double?
        
        switch selectedSearchMethod {
        case .name:
            term = text
            lat = currentLocation.latitude
            lon = currentLocation.longitude
        case .location:
            address = text
        case .categories:
            category = text
            lat = currentLocation.latitude
            lon = currentLocation.longitude
        }
        
        isLoading.onNext(true)
        let requestKey = SearchRequestKey(term: term, latitude: lat, longitude: lon, categories: category, location: address, sortBy: selectedSortMethod)
        apiManager.search(requestKey: requestKey) { [unowned self] result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let searchResult):
                guard let businesses = searchResult.businesses else {
                    self.showError.onNext(.nilValue)
                    return
                }
                self.businesses = businesses
                self.listBusinesses.onNext(businesses)
            case .failure(let error):
                self.showError.onNext(error)
            }
        }
    }
    
    func getBusiness(with id: String) {
        self.isLoading.onNext(true)
        apiManager.getBusiness(by: id) { [unowned self] result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let detail):
                self.selectedBusiness.onNext(detail)
            case .failure(let error):
                self.showError.onNext(error)
            }
        }
    }
}
