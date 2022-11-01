//
//  WritePostBookSearchTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class WritePostBookSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorNPublisherLabel: UILabel!
    var BID : Int = 0
    var UIImageString : String = ""
    var bookName : String = ""
    var bookAuthotPublisher : String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTableViewCellUI()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setBookSearchList(model : BookSearchDataList){
        let imgurl = URL(string: "\(model.thumbnailImage)")
        self.UIImageString = model.thumbnailImage
        let data = try! Data(contentsOf: imgurl!)
        self.bookImage.image = UIImage(data: data)
        self.bookNameLabel.text = model.TITLE
        self.bookName = model.TITLE
        self.BID = model.TBID
        self.bookAuthorNPublisherLabel.text = model.AUTHOR + model.PUBLISHER
        self.bookAuthotPublisher = "\(model.AUTHOR)/\(model.PUBLISHER)"
    }
    func setTableViewCellUI(){
        self.bookNameLabel.font = UIFont.systemFont(ofSize: 18)
        self.bookAuthorNPublisherLabel.font = UIFont.systemFont(ofSize: 14)
    }
}

