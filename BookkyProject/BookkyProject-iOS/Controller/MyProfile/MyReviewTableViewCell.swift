//
//  MyReviewTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var myReviewHeader: UILabel!
    @IBOutlet weak var myReviewMoreButton: UIButton!
    @IBOutlet weak var myReviewListTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myReviewListTableView.delegate = self
        self.myReviewListTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MyReviewTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyReviewListTableViewCell = self.myReviewListTableView.dequeueReusableCell(withIdentifier: "MyReviewListTableViewCellid", for: indexPath) as! MyReviewListTableViewCell
        cell.myReviewBookThumbnail?.image = myReview[indexPath.row].thumbnail
        cell.myReviewTitle?.text = myReview[indexPath.row].title
        cell.myReviewDescription?.text = myReview[indexPath.row].description
        cell.myReviewBookAuthorAndPublisher?.text = myReview[indexPath.row].authorAndPubliser
        cell.bookRateNumber?.text = String(myReview[indexPath.row].bookRateStar)
        cell.likeNumber?.text = String(myReview[indexPath.row].like)
        cell.likeIcon?.image = UIImage(named: "likeIcon")
        return cell
    }
}
