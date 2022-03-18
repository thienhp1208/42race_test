//
//  BaseViewController.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController {

    var viewModel: T?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
