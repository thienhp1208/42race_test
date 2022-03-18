//
//  SearchCoordinator.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import UIKit

class SearchCoordinator: NavigationCoordinator {
    
    // MARK: - Init
    init(with router: NavigationRouter, viewModel: SearchViewModel) {
        super.init(with: router, session: viewModel.session)
        let controller = SearchViewController.instantiate(viewModel: viewModel)

        router.setRootModule(controller)
    }
}