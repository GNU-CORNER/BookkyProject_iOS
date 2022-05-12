//
//  TagsCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/11.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLabel: UILabel!
    var isSelectedBefore: Bool = false
    
    override func awakeFromNib() {
        self.layer.backgroundColor = UIColor(named: "grayColor")?.cgColor
        self.layer.cornerRadius = 80 / 2
    }
    
}
