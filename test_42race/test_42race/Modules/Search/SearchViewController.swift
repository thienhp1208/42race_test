//
//  SearchViewController.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import UIKit

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
    }

    // MARK: - Action
    @IBAction func didTapSearchButton(_ sender: Any) {
        
    }
    
}

// MARK: - Helper Method
extension SearchViewController {
    
}
