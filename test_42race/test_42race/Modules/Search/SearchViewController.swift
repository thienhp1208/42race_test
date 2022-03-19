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
    var onSelectBusiness: ((BusinessDetail) -> Void)?
    
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
        viewModel.initViewModel()
    }

    // MARK: - Action
    @IBAction func didTapSearchButton(_ sender: Any) {
        view.endEditing(true)
        viewModel.search(with: searchTextField.text ?? "")
    }
    
}

// MARK: - Helper Method
extension SearchViewController {
    private func configUI() {
        self.navigationItem.title = "Search Result"
        resultTableView.register(UINib(resource: R.nib.businessCell), forCellReuseIdentifier: R.reuseIdentifier.businessCell.identifier)
        
        searchTextField.delegate = self
        
        sortByCollectionView.register(UINib(resource: R.nib.filterCollectionViewCell), forCellWithReuseIdentifier: R.reuseIdentifier.filterCollectionCell.identifier)
        searchByCollectionView.register(UINib(resource: R.nib.filterCollectionViewCell), forCellWithReuseIdentifier: R.reuseIdentifier.filterCollectionCell.identifier)
    }
    
    private func binding() {
        // Show loading on call API
        viewModel.isLoading
            .bind { [unowned self] isLoad in
                if isLoad {
                    self.loadingView.startAnimate(superView: self.view)
                } else {
                    self.loadingView.stopAnimate()
                }
            }
            .disposed(by: disposeBag)
        
        // Show error on call API have error
        viewModel.showError
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] error in
                print(error.localizedDescription)
                self.showError(error: error)
            })
            .disposed(by: disposeBag)
        
        // Bind listBusinesses to tableView
        viewModel.listBusinesses
            .bind(to: resultTableView.rx.items(cellIdentifier: R.reuseIdentifier.businessCell.identifier, cellType: BusinessCell.self)) { (row, business, cell) in
                cell.updateData(data: business)
                cell.onSelect = { [unowned self] in
                    guard let businessAlias = self.viewModel.businesses[row].alias else {
                        self.showError(error: .nilValue)
                        return
                    }
                    self.viewModel.getBusiness(with: businessAlias)
                }
            }
            .disposed(by: disposeBag)

        // Observe selectedBusiness change
        viewModel.selectedBusiness
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] detail in
                self.onSelectBusiness?(detail)
            })
            .disposed(by: disposeBag)
        
        // Bind data to sort method collectionView
        viewModel.sortByList
            .bind(to: sortByCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.filterCollectionCell.identifier, cellType: FilterCollectionCell.self)) {(row, filter, cell) in
                cell.updateData(data: filter.title)
                cell.onCellSelected(filter.isSelected)
            }
            .disposed(by: disposeBag)
        
        // Observe sort method collection selected item change
        sortByCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] indexPath in
                self.view.endEditing(true)
                self.viewModel.updateSortMethod(at: indexPath.row)
                if let searchText = searchTextField.text, !searchText.isEmpty {
                    self.viewModel.search(with: searchText)
                }
            })
            .disposed(by: disposeBag)

        // Bind data to search method collectionView
        viewModel.searchByList
            .bind(to: searchByCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.filterCollectionCell.identifier, cellType: FilterCollectionCell.self)) {(row, filter, cell) in
                cell.updateData(data: filter.title)
                cell.onCellSelected(filter.isSelected)
            }
            .disposed(by: disposeBag)
        
        // Observe search method collection selected item change
        searchByCollectionView.rx.itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] indexPath in
                self.view.endEditing(true)
                self.viewModel.updateSearchMethod(at: indexPath.row)
                if let searchText = searchTextField.text, !searchText.isEmpty {
                    self.viewModel.search(with: searchText)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.search(with: textField.text ?? "")
        view.endEditing(true)
        return true
    }
}
