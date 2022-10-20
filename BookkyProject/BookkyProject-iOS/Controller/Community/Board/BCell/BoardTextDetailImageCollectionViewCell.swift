//
//  BoardTextDetailImageCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/04.
//

import UIKit

class BoardTextDetailImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UIimageView: UIImageView!
    var ImageArray : [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setImageArray(model : String) {
        if let url = URL(string: model) {
            self.UIimageView.load(url: url)
        }
        self.ImageArray = []
        self.ImageArray.append(model)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
