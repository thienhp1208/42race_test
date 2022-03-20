//
//  BusinessImageCollectionCell.swift
//  test_42race
//
//  Created by Thien Huynh on 19/03/2022.
//

import UIKit
import Kingfisher

class BusinessImageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var busunessImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Helper Methods
    func updateData(data: String) {
        let url = URL(string: data)
        busunessImgView.kf.setImage(with: url,
                                    placeholder: nil,
                                    options: [
                                        .transition(.fade(1)),
                                        .cacheOriginalImage
                                    ])
    }
}
