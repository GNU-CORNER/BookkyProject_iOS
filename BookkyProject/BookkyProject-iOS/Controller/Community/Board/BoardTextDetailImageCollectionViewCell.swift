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
        if let url = URL(string: model) {
            self.UIimageView.load(url: url)
        }
        let url = URL(string: "\(model)")
        let data = try! Data(contentsOf: url!)
        self.UIImage = UIKit.UIImage(data: data)
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        UIimageView.image = nil
    }
}
