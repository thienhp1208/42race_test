//
//  SearchViewController.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController<SearchViewModel> {

    // MARK: - Outlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewSearchBy: UIView!
    @IBOutlet weak var searchByCollectionView: UICollectionView!
    @IBOutlet weak var viewSortBy: UIView!
    @IBOutlet weak var sortByCollectionView: UICollectionView!
    @IBOutlet weak var resultTableView: UITableView!
    
    // MARK: - Properties
    var onSelectBusiness: (() -> Void)?
    
    // MARK: - Init
    class func instantiate(viewModel: SearchViewModel) -> SearchViewController {
        let controller = R.storyboard.main.searchViewController()!
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        binding()
    }

    // MARK: - Action
    @IBAction func didTapSearchButton(_ sender: Any) {
        viewModel.search(with: searchTextField.text ?? "")
    }
    
}

// MARK: - Helper Method
extension SearchViewController {
    private func configUI() {
        self.navigationItem.title = "Search Result"
    }
    
    private func binding() {
        viewModel.isLoading
            .bind { [unowned self] isLoad in
                if isLoad {
                    self.loadingView.frame = self.view.frame
                    self.view.addSubview(self.loadingView)
                } else {
                    self.loadingView.removeFromSuperview()
                }
            }
            .disposed(by: disposeBag)
    }
}
