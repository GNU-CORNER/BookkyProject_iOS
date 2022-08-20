//
//  RoadmapTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/09.
//

import UIKit

class RoadmapTableViewCell: UITableViewCell {

    @IBOutlet weak var roadmapAnswerBackgroundView: UIView!
    @IBOutlet weak var roadmapAnswerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roadmapAnswerBackgroundView.layer.borderWidth = 0.8
        self.roadmapAnswerBackgroundView.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        self.roadmapAnswerBackgroundView.layer.cornerRadius = 8

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
