//
//  BusinessMainInfoCell.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos
import Reusable

class BusinessMainInfoCell: UITableViewCell, NibReusable {

    // MARK: - Outlets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblBusinessName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var businessDetail: PublishSubject<BusinessDetail> = PublishSubject()
    var businessImages: PublishSubject<[String]> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        binding()
    }
}

// MARK: - Helper Methods
extension BusinessMainInfoCell {
    private func configUI() {
        
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
        ratingView.settings.emptyColor = .lightGray
        ratingView.settings.filledColor = #colorLiteral(red: 1, green: 0.8857141137, blue: 0, alpha: 1)
        ratingView.settings.filledBorderColor = .clear
        ratingView.settings.emptyBorderColor = .clear
        ratingView.settings.starSize = ratingView.bounds.height
        ratingView.settings.starMargin = 3
        ratingView.widthAnchor.constraint(equalToConstant: ratingView.intrinsicContentSize.width).isActive = true
        
        let imageLayout = UICollectionViewFlowLayout()
        imageLayout.scrollDirection = .horizontal
        imageLayout.minimumInteritemSpacing = 0
        imageLayout.minimumLineSpacing = 0
        let itemWidth = UIScreen.main.bounds.width
        let itemHeight = itemWidth * 2 / 3
        imageLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        imagesCollectionView.setCollectionViewLayout(imageLayout, animated: false)
        imagesCollectionView.register(UINib(resource: R.nib.businessImageCollectionCell), forCellWithReuseIdentifier: R.reuseIdentifier.businessImageCollectionCell.identifier)
    }
    
    private func binding() {
        businessDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] detail in
                self.lblBusinessName.text = detail.name ?? "Business Name"
                self.lblReview.text = "\(detail.reviewCount ?? 0) Reviews"
                self.ratingView.rating = detail.rating ?? 0.0
                
                var listImages: [String] = []
                if let photos = detail.photos {
                    listImages.append(contentsOf: photos)
                }
                self.businessImages.onNext(listImages)
            })
            .disposed(by: disposeBag)
        
        businessImages
            .bind(to: self.imagesCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.businessImageCollectionCell.identifier, cellType: BusinessImageCollectionCell.self)) { (item, url, cell) in
                cell.updateData(data: url)
            }
            .disposed(by: disposeBag)
    }
    
    func updateData(detail: BusinessDetail?) {
        if let detail = detail {
            businessDetail.onNext(detail)
        } else {
            
        }
    }
}
