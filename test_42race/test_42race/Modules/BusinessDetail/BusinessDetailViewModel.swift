//
//  BusinessDetailViewModel.swift
//  test_42race
//
//  Created by Thien Huynh on 19/03/2022.
//

import UIKit
import RxSwift

class BusinessDetailViewModel: BaseViewModel {
    
    private lazy var apiManager = BusinessAPIManager(session: self.session)
    var businessDetail: BusinessDetail?
    var businessReviews: [Review] = []
    var isGetReviewDone: PublishSubject<Bool> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var showError: PublishSubject<APIError> = PublishSubject()
    
    init(with session: Session, businessDetail: BusinessDetail) {
        super.init(session: session)
        self.businessDetail = businessDetail
    }
}

// MARK: - Helper Methods
extension BusinessDetailViewModel {
    func getBusinessReview() {
        guard let alias = businessDetail?.alias else {
            showError.onNext(.cantGetReviews)
            return
        }
        isLoading.onNext(true)
        apiManager.getBusinessReviews(with: alias) { [unowned self] result in
            self.isLoading.onNext(false)
            switch result {
            case .success(let businessReviews):
                guard let reviews = businessReviews.reviews else {
                    self.showError.onNext(.cantGetReviews)
                    return
                }
                self.businessReviews = reviews
                self.isGetReviewDone.onNext(true)
            case .failure(let error):
                self.showError.onNext(error)
            }
        }
    }
}
