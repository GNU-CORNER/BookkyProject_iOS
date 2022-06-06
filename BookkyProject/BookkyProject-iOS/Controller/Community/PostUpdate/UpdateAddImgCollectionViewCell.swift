//
//  UpdateAddImgCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/05.
//

import UIKit

class UpdateAddImgCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var cancelButton: ImageCancelButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        UserImg.image = nil
    }
   
}
