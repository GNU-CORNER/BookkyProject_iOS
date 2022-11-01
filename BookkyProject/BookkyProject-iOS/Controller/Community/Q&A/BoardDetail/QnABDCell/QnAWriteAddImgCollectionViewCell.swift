//
//  QnAWriteAddImgCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/07/18.
//

import UIKit

class QnAWriteAddImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectImg: UIImageView!
    @IBOutlet weak var cancelImgButton: ImageCancelButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        selectImg.image = nil
    }
   
}
