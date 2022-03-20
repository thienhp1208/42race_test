//
//  SearchCoordinator.swift
//  test_42race
//
//  Created by Thien Huynh on 17/03/2022.
//

import UIKit

class SearchCoordinator: NavigationCoordinator {
    
    // MARK: - Init
    init(with router: NavigationRouter, viewModel: SearchViewModel) {
        super.init(with: router, session: viewModel.session)
        let controller = SearchViewController.instantiate(viewModel: viewModel)

        controller.onSelectBusiness = { [unowned self] detail in
            self.showBusinessDetail(with: detail)
        }
        
        router.setRootModule(controller)
    }
}

// MARK: - Helper Methods
extension SearchCoordinator {
    private func showBusinessDetail(with detail: BusinessDetail) {
        let viewModel = BusinessDetailViewModel(with: session, businessDetail: detail)
        let controller = BusinessDetailViewController.instantiate(viewModel: viewModel)
        
        controller.onBack = { [unowned self] in
            self.router.popModule()
        }
        
        
        router.push(controller)
    }
}
