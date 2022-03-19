//
//  BusinessMoreInfoCell.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable

class BusinessMoreInfoCell: UITableViewCell, NibReusable {

    // MARK: - Outlets
    @IBOutlet weak var lblCategories: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOpenStatus: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnOpenMap: UIButton!
    @IBOutlet weak var lblTransaction: UILabel!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var categories: [String] = []
    var detail: BusinessDetail?
    private lazy var tempLabel = UILabel()
    var businessDetail: PublishSubject<BusinessDetail> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        binding()
    }
    
    // MARK: - Actions
    @IBAction func didTapCallPhone(_ sender: Any) {
        if let detail = detail,
           let phone = detail.phone,
           let url = URL(string: "tel://\(phone)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
    }
    
//    @IBAction func didTapOpenMap(_ sender: Any) {
//        
//    }
}

// MARK: - Helper Methods
extension BusinessMoreInfoCell {
    private func configUI() {
        btnPhone.setTitle("", for: .normal)
        btnOpenMap.setTitle("", for: .normal)
    }
    
    private func binding() {
        businessDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] detail in
                if let price = detail.price {
                    self.lblPrice.text = "\(price) - "
                }
                
                if let businessCategories = detail.categories {
                    self.categories = businessCategories.compactMap({ $0.title})
                    self.lblCategories.text = "\(self.categories.joined(separator: ", "))"
                }
                
                self.lblOpenStatus.text = (detail.isClosed ?? true) ? "Closed" : "Open"
                self.lblOpenStatus.textColor = (detail.isClosed ?? true) ? .red : .green
                
                
                if let location = detail.location,
                   let displayAddress = location.displayAddress {
                    self.lblAddress.text = "\(displayAddress.joined(separator: ", "))"
                }
                
                if let phone = detail.displayPhone {
                    lblPhone.text = "\(phone)"
                }
                
                if let transactions = detail.transactions {
                    self.lblTransaction.text = "\(transactions.joined(separator: ", "))"
                }
            })
            .disposed(by: disposeBag)
    }
    
    func updateData(detail: BusinessDetail?) {
        if let detail = detail {
            self.detail = detail
            businessDetail.onNext(detail)
        } else {
            
        }
    }
}
