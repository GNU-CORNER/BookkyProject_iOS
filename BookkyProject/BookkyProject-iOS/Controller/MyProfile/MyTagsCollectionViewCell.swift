//
//  MyTagsCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/04.
//

import UIKit

class MyTagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.tagNameLabel.textColor = UIColor(named: "primaryColor")
        self.backgroundColor = UIColor(named: "F9F9F9")
    }
}
