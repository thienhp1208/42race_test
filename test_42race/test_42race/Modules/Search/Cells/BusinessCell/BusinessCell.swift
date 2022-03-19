//
//  BusinessCell.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit
import Kingfisher
import Cosmos
import SwiftUI

class BusinessCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var businessAvatarImgView: UIImageView!
    @IBOutlet weak var lblBusinessName: UILabel!
    @IBOutlet weak var lblBusinessRating: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblBusinessDistance: UILabel!
    @IBOutlet weak var btnSelectCell: UIButton!
    
    // MARK: - Properties
    var onSelect: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
    
    // MARK: - Action
    @IBAction func didTapSelectCell(_ sender: Any) {
        self.onSelect?()
    }
    
}

// MARK: - Helper Methods
extension BusinessCell {
    private func configUI() {
        businessAvatarImgView.layer.cornerRadius = 8
        businessAvatarImgView.contentMode = .scaleAspectFill
        
        ratingView.settings.totalStars = 5
        ratingView.settings.fillMode = .precise
        ratingView.settings.emptyColor = .lightGray
        ratingView.settings.filledColor = #colorLiteral(red: 1, green: 0.8857141137, blue: 0, alpha: 1)
        ratingView.settings.filledBorderColor = .clear
        ratingView.settings.emptyBorderColor = .clear
        ratingView.settings.starSize = ratingView.bounds.height
        ratingView.settings.starMargin = 3
        ratingView.widthAnchor.constraint(equalToConstant: ratingView.intrinsicContentSize.width).isActive = true
        
        btnSelectCell.setTitle("", for: .normal)
    }
    
    func updateData(data: Business) {
        if let imgURL = data.imageURL {
            businessAvatarImgView.kf
                .setImage(with: URL(string: imgURL),
                          placeholder: nil,
                          options: [
                            .transition(.fade(1)),
                            .cacheOriginalImage
                          ])
        }
        lblBusinessName.text = "\(data.name ?? "")"
        ratingView.rating = data.rating ?? 0.0
        lblBusinessRating.text = "(\(data.rating ?? 0.0)/5.0)"
        let distance = (data.distance ?? 0) / 1000
        lblBusinessDistance.text = "\(round(distance * 100) / 100)km away"
    }
}
