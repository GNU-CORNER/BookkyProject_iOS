//
//  BookCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    var BID :Int = 0
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    func setBookData(model: BookData){
        BID = model.TBID
        bookNameLabel.text = model.TITLE
        if let url = URL(string: "\(model.thumbnailImage)" ){
            bookImageView.load(url: url)
        }
    }
    func setTagMoreViewBookData(model : TagMoreViewBookData){
        BID = model.TBID
        self.bookNameLabel.text = model.TITLE
        if let url = URL(string: "\(model.thumbnailImage)"){
            self.bookImageView.load(url: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bookNameLabel.textColor = UIColor.white
      
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        bookNameLabel.text = ""
    }
 
}

