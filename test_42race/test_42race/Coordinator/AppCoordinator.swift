//
//  AppCoordinator.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

class AppCoordinator: RootCoordinator {

	override init(with router: AppRouter, session: Session) {
		super.init(with: router, session: session)
	}

	override func start() {
		runSplash()
	}

	// MARK: - Routing

	private func runSplash() {
        let viewModel = SearchViewModel(session: session)
        let coordinator = SearchCoordinator.init(with: NavigationRouter(), viewModel: viewModel)

        addChild(coordinator)
        router.setRootModule(coordinator.toPresentable())
	}
}
