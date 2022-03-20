//
//  BusinessDetailViewController.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit

class BusinessDetailViewController: BaseViewController<BusinessDetailViewModel> {

    // MARK: - Outlet
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    // MARK: - Properties
    var onBack: (() -> Void)?
    
    // MARK: - Init
    class func instantiate(viewModel: BusinessDetailViewModel) -> BusinessDetailViewController {
        let controller = R.storyboard.main.businessDetailViewController()!
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
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.onBack?()
    }
}

// MARK: - Helper Method
extension BusinessDetailViewController {
    private func configUI() {
        self.navigationController?.isNavigationBarHidden = true
        closeView.layer.cornerRadius = closeView.bounds.height / 2
        closeView.layer.masksToBounds = true
        btnClose.setTitle("", for: .normal)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(cellType: BusinessMainInfoCell.self)
        detailTableView.register(cellType: BusinessMoreInfoCell.self)
        detailTableView.register(cellType: BusinessOperationHourCell.self)
        
        
    }
    
    private func binding() {
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BusinessDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BusinessMainInfoCell.self)
            cell.updateData(detail: viewModel.businessDetail)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BusinessMoreInfoCell.self)
            cell.updateData(detail: viewModel.businessDetail)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BusinessOperationHourCell.self)
            cell.updateData(detail: viewModel.businessDetail)
            return cell
        } 
    }
    
    
}
