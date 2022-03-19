//
//  BaseViewController.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {

    var viewModel: T!
    let disposeBag = DisposeBag()
    lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
