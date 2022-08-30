//
//  BoardTextDetailImageCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/04.
//

import UIKit

class BoardTextDetailImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIimageView: UIImageView!
    var UIImage : UIImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setImageArray(model : String) {

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        UIimageView.image = nil
    }
}
