//
//  Presentable.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

public protocol Presentable {
    func toPresentable() -> UIViewController
}

extension UIViewController: Presentable {
    public func toPresentable() -> UIViewController {
        return self
    }
}
