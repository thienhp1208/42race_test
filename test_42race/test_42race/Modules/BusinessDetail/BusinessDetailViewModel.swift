//
//  BusinessDetailViewModel.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit

class BusinessDetailViewModel: BaseViewModel {
    
    var businessDetail: BusinessDetail?
    
    init(with session: Session, businessDetail: BusinessDetail) {
        super.init(session: session)
        self.businessDetail = businessDetail
    }
}

// MARK: - Helper Methods
extension BusinessDetailViewModel {
    func getBusinessReview(with alias: String) {
        
    }
}
