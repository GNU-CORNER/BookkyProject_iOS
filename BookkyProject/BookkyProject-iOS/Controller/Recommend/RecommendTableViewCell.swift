//
//  RoadmapBookkyTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/09.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var bookkyView: UIView!
    @IBOutlet weak var bookkyImageView: UIImageView!
    @IBOutlet weak var bookkyTitle: UILabel!
    @IBOutlet weak var bookkyDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookkyView.layer.cornerRadius = 8
        bookkyView.layer.borderWidth = 1.0
        bookkyView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        bookkyView.applyShadow(cornerRadius: 8)
        bookkyImageView.image = UIImage(named: "안내견북키")
        bookkyImageView.layer.opacity = 0.5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
