//
//  AppRouter.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

public class AppRouter: PresentationRouterType {
    let window: UIWindow

    init(with window: UIWindow) {
        self.window = window
    }

    public func setRootModule(_ module: Presentable) {
        let controller = module.toPresentable()

        window.rootViewController = controller

        window.makeKeyAndVisible()
    }

    public func toPresentable() -> UIViewController {
        assert(window.rootViewController != nil, "setRootModule must be already called at this moment")
        return window.rootViewController!
    }
}
