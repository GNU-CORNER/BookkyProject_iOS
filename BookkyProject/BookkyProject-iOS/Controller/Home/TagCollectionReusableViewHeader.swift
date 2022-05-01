//
//  TagCollectionReusableViewHeader.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/01.
//

import UIKit

class TagCollectionReusableViewHeader: UICollectionReusableView {
    @IBOutlet weak var tagNameLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        tagNameLabel.numberOfLines = 2
        tagNameLabel.textColor = UIColor.white
        tagNameLabel.font = UIFont.systemFont(ofSize: 30)
        
    }
}
extension TagViewCollectionViewCell  {
    
}
