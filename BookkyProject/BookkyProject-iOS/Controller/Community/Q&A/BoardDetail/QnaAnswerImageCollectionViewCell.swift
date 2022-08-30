//
//  QnaAnswerImageCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/07/15.
//

import UIKit

class QnaAnswerImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var CommentImageView: UIImageView!
    var UIImage : UIImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setImageArray(model : String) {

        if let url = URL(string: model) {
            self.CommentImageView.load(url: url)
        }
        let url = URL(string: "\(model)")
        let data = try! Data(contentsOf: url!)
        self.UIImage = UIKit.UIImage(data: data)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        CommentImageView.image = nil
    }
}
