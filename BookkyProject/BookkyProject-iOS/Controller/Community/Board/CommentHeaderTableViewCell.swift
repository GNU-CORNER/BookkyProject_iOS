//
//  CommentHeaderTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/31.
//

import UIKit

class CommentHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var createDateLabel: UILabel!
    @IBOutlet weak var likeCntLabel: UILabel!
    
    @IBOutlet weak var addFunctionButton: CustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BoardTextCommentTableViewCellUI()
    }

 
    
    private func BoardTextCommentTableViewCellUI(){
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.contentsLabel.font = UIFont.systemFont(ofSize: 12)
        self.createDateLabel.font = UIFont.systemFont(ofSize: 10)
        self.createDateLabel.textColor  = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        self.likeCntLabel.font = UIFont.systemFont(ofSize: 10)
        self.addFunctionButton.tintColor = .black
        
    }
    
}
