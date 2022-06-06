//
//  WriteAddImgCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/03.
//

import UIKit

class WriteAddImgCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UserImg: UIImageView!
 
    @IBOutlet weak var cancelImgeButton: ImageCancelButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        UserImg.image = nil
    }
   
    
}
