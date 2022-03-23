//
//  MyPostTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import UIKit

class MyPostTableViewCell: UITableViewCell {

    @IBOutlet weak var myPostHeader: UILabel!
    @IBOutlet weak var myPostMoreButton: UIButton!
    @IBOutlet weak var myPostListTableView: UITableView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myPostListTableView.delegate = self
        myPostListTableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyPostTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyPostListTableViewCell = self.myPostListTableView.dequeueReusableCell(withIdentifier: "MyPostListTableViewCellid", for: indexPath) as! MyPostListTableViewCell
        cell.myPostTitle?.text = myPost[indexPath.row].title
        cell.myPostDescription?.text = myPost[indexPath.row].description
        cell.likeIcon?.image = UIImage(named: "likeIcon")
        cell.likeNumber?.text = String(myPost[indexPath.row].like)
        /// 나중에 색상 정해진 것으로 변경해야 함
        cell.likeNumber?.textColor = .systemOrange
        cell.commentIcon?.image = UIImage(named: "commentIcon")
        cell.commentNumber?.text = String(myPost[indexPath.row].comment)
        /// 나중에 색상 정해진 것으로 변경해야 함
        cell.commentNumber?.textColor = .systemBlue
        return cell
    }
}
