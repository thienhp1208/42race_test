//
//  CoordinatorType.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

public protocol CoordinatorType: AnyObject, Presentable {
    associatedtype DeepLinkType
    associatedtype SessionType
    associatedtype Router: RouterType

    var router: Router { get }

    func start()
    func start(with deeplink: DeepLinkType?)
}

public class Coordinator<DeepLinkType, SessionType, Router: RouterType>: NSObject, CoordinatorType {
    public let router: Router
    public let session: SessionType
    public var childCoordinators: [Coordinator<DeepLinkType, SessionType, NavigationRouter>] = []

    public init(with router: Router, session: SessionType) {
        self.router = router
        self.session = session
        super.init()
    }

    public func start() {
        start(with: nil)
    }

    public func start(with deeplink: DeepLinkType?) {}

    public func addChild(_ coordinator: Coordinator<DeepLinkType, SessionType, NavigationRouter>) {
        childCoordinators.append(coordinator)
    }

    public func removeChild(_ coordinator: Coordinator<DeepLinkType, SessionType, NavigationRouter>?) {
        guard let coordinator = coordinator, let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else {
            return
        }

        childCoordinators.remove(at: index)
    }

    public func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
}

typealias RootCoordinator = Coordinator<DeepLink, Session, AppRouter>
typealias NavigationCoordinator = Coordinator<DeepLink, Session, NavigationRouter>
