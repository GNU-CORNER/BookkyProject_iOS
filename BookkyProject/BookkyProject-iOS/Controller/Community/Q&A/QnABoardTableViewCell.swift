//
//  QnABoardTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class QnABoardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var likeCntImage: UIImageView!
    @IBOutlet weak var likeCntLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var replyCommetLabel: UILabel!
    var PID : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setQnABoardTableViewCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setQnABoardTableViewCellUI(){
        self.contentsLabel.textColor = UIColor(named: "grayColor")
        self.likeCntImage.image = UIImage(named: "likeThat")
        self.likeCntLabel.textColor = UIColor(named:"PrimaryOrangeColor")
        self.commentLabel.textColor = UIColor(named: "PrimaryBlueColor")
        self.commentImage.image = UIImage(named: "comment")
        self.replyCommetLabel.font = UIFont.systemFont(ofSize: 11)
        self.replyCommetLabel.textColor = .white
        self.replyCommetLabel.layer.borderWidth = 1
        self.replyCommetLabel.layer.cornerRadius = 5
        self.replyCommetLabel.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.replyCommetLabel.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor

    }
}
