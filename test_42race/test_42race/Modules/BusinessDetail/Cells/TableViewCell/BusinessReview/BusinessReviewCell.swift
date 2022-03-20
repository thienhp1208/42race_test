//
//  BusinessReviewCell.swift
//  test_42race
//
//  Created by Thien Huynh on 20/03/2022.
//

import UIKit
import Cosmos
import RxSwift
import Kingfisher
import Reusable

class BusinessReviewCell: UITableViewCell, NibReusable {

    // MARK: - Outlets
    @IBOutlet weak var userAvateImgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblTimeCreated: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    var businessReview: PublishSubject<Review> = PublishSubject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        binding()
    }
}

// MARK: - Helper Methods
extension BusinessReviewCell {
    private func configUI() {
        userAvateImgView.layer.cornerRadius = userAvateImgView.bounds.width / 2
        userAvateImgView.contentMode = .scaleAspectFill
        
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
        ratingView.settings.emptyColor = .lightGray
        ratingView.settings.filledColor = #colorLiteral(red: 1, green: 0.8857141137, blue: 0, alpha: 1)
        ratingView.settings.filledBorderColor = .clear
        ratingView.settings.emptyBorderColor = .clear
        ratingView.settings.starSize = ratingView.bounds.height
        ratingView.settings.starMargin = 3
        ratingView.widthAnchor.constraint(equalToConstant: ratingView.intrinsicContentSize.width).isActive = true
        
    }
    
    private func binding() {
        businessReview
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] review in
                if let user = review.user {
                    if let avatar = user.imageURL {
                        self.userAvateImgView.kf.setImage(with: URL(string: avatar),
                                                          placeholder: nil,
                                                          options: [
                                                              .transition(.fade(1)),
                                                              .cacheOriginalImage
                                                          ])
                    }
                }
                
                self.lblName.text = review.user?.name ?? ""
                self.ratingView.rating = review.rating ?? 0.0
                
                if let createdDate = review.timeCreated {
                    self.lblTimeCreated.text = "\(createdDate)"
                }
                
                self.lblContent.text = review.text ?? ""
            })
            .disposed(by: disposeBag)
    }
    
    func updateData(detail: Review?) {
        if let detail = detail {
            businessReview.onNext(detail)
        } else {
            
        }
    }
}
