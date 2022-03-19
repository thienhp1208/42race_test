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
        resultTableView.register(UINib(resource: R.nib.businessCell), forCellReuseIdentifier: R.reuseIdentifier.businessCell.identifier)
    }
    
    private func binding() {
        viewModel.isLoading
            .bind { [unowned self] isLoad in
                if isLoad {
                    self.loadingView.startAnimate(superView: self.view)
                } else {
                    self.loadingView.stopAnimate()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.showError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] error in
                print(error.localizedDescription)
                self.showError(error: error)
            })
            .disposed(by: disposeBag)
        
        viewModel.listBusinesses
            .bind(to: resultTableView.rx.items(cellIdentifier: R.reuseIdentifier.businessCell.identifier, cellType: BusinessCell.self)) { (row, business, cell) in
                cell.updateData(data: business)
            }
            .disposed(by: disposeBag)

    }
}
