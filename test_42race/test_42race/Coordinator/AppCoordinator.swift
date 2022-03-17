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
//		let controller = SplashViewController.instantiate(viewModel: SplashControllerViewModel(session: session))
//
//		controller.didLogin = { [weak self] in
//			self?.isOnSplashScreen = false
//			self?.runMain()
//		}
//		controller.notAuth = { [weak self] in
//			self?.isOnSplashScreen = false
//			self?.runLogin()
//		}
//
//		router.setRootModule(controller)
	}
}
