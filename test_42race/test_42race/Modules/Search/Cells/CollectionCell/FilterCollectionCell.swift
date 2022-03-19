//
//  FilterCollectionCell.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var lblFilterTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

}

// MARK: - Helper Methods
extension FilterCollectionCell {
    private func configUI() {
        containView.layer.cornerRadius = containView.bounds.height/2
    }
    
    func updateData(data: String) {
        lblFilterTitle.text = data
    }
    
    func onCellSelected(_ isSelect: Bool) {
        containView.backgroundColor = isSelect ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5052345951)
        lblFilterTitle.textColor = isSelect ? .white : .black
    }
}
