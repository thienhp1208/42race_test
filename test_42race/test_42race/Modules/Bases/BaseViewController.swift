//
//  BaseViewController.swift
//  test_42race
//
//  Created by Thien Huynh on 17/03/2022.
//

import UIKit
import RxSwift

class BaseViewController<T: BaseViewModel>: UIViewController {

    var viewModel: T!
    let disposeBag = DisposeBag()
    lazy var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Helper Methods
extension BaseViewController {
    func showError(error: APIError) {
        let alert = UIAlertController(title: "Alert", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
