//
//  BoardTextDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/10.
//

import UIKit

class BoardTextDetailViewController: UIViewController {
    @IBOutlet weak var NavigationBarTitleLabel: UINavigationItem!
    @IBOutlet weak var textDetailTitleLabel: UILabel!
    
    @IBOutlet weak var textDetailCreateDateLabel: UILabel!
    @IBOutlet weak var textDetailViewsLabel: UILabel!
    @IBOutlet weak var textDetailViewsImage: UIImageView!
    @IBOutlet weak var textDetailContentsLabel: UILabel!
    @IBOutlet weak var textDetailUserImage: UIImageView!
    @IBOutlet weak var textDetailUserNickname: UILabel!
    @IBOutlet weak var likeThatButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var bookDetailCommentTableView: UITableView!
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    var writeTextDetailcommentData : [WriteTextDetailCommentdata]? = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookDetailCommentTableView.dataSource = self
        self.bookDetailCommentTableView.delegate = self
        self.NavigationBarTitleLabel.title = "자유 게시판"
        getBoardTextDetailData()
        setBoardTextDetailUI()
        print("\(self.PID)")
    }
    func setBoardTextDetailUI(){
        self.textDetailTitleLabel.font = UIFont.systemFont(ofSize: 20)
        self.textDetailCreateDateLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailCreateDateLabel.textColor = .gray
        self.textDetailViewsLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailContentsLabel.font = UIFont.systemFont(ofSize: 13)
        self.textDetailUserNickname.font = UIFont.systemFont(ofSize: 14)
        
    }
    func setBoardTextDetailData(model :WriteTextDetailPostData ){
        self.textDetailTitleLabel.text = model.title
        self.textDetailCreateDateLabel.text = model.createAt
        self.textDetailViewsLabel.text = "\(model.views)"
        self.textDetailContentsLabel.text = model.contents
        self.textDetailUserNickname.text = model.nickname
        self.textDetailContentsLabel.numberOfLines = 0
        let likeCount =  model.like?.count ?? 0
        self.likeThatButton.setTitle("좋아요(\(likeCount))", for: .normal)
        self.likeThatButton.tintColor = .black
        
        
        self.commentButton.tintColor = .black
    }
    func setCommentCount(model: WriteTextDetailData){
        self.commentButton.setTitle("댓글(\(model.commentCnt ?? 0))", for: .normal)
        //대댓글수 까지 포함
    }
    private func getBoardTextDetailData(){
        CommunityAPI.shared.getCommunityTextDetail(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success, data) in
            if success{
                guard let communityGetDetailList = data as? WriteTextDetailInformation else {return}
                let writeTextDetailData = communityGetDetailList.result.postdata
                self.writeTextDetailcommentData = communityGetDetailList.result.commentdata
                let commnetCount = communityGetDetailList.result
                //                print("\(self.writeTextDetailcommentData)")
                if communityGetDetailList.success{
                    DispatchQueue.main.async {
                        self.setBoardTextDetailData(model: writeTextDetailData)
                        self.setCommentCount(model: commnetCount)
                        self.bookDetailCommentTableView.reloadData()
                        
                    }
                }else{
                    print("통신오류")
                }
                
            }
        }
        
    }
   
    
}
extension BoardTextDetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.writeTextDetailcommentData?.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : BoardTextCommentTableViewCell = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "TextDetailCommentTableViewCellId", for: indexPath)as? BoardTextCommentTableViewCell else {return UITableViewCell()}
        cell.setComment(model: self.writeTextDetailcommentData![indexPath.row])
      
        return cell
    }
    
    
}

