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
    var writeTextDetailcommentData : [WriteTextDetailCommentdata] = []
    var childComment : [ChildComment]? = []
    var commentCnt : Int =  0
    var totalCommnet : [Any] = []
    @IBOutlet weak var postDetailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCell()
        self.NavigationBarTitleLabel.title = "자유 게시판"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        getBoardTextDetailData()
        setBoardTextDetailUI()
        print("\(self.PID)")
    }
    func setTableViewCell(){
        self.bookDetailCommentTableView.dataSource = self
        self.bookDetailCommentTableView.delegate = self
        let cellNib = UINib(nibName: "BoardTextCommentTableViewCell", bundle: nil)
        self.bookDetailCommentTableView.register(cellNib, forCellReuseIdentifier: "BoardTextCommentTableViewCellid")
        
    }
    func setBoardTextDetailUI(){
        self.textDetailTitleLabel.font = UIFont.systemFont(ofSize: 20)
        self.textDetailCreateDateLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailCreateDateLabel.textColor = .gray
        self.textDetailViewsLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailContentsLabel.font = UIFont.systemFont(ofSize: 13)
        print("\(self.textDetailContentsLabel.numberOfLines)ddddddd")
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
        let textCount = self.textDetailContentsLabel.text?.count ?? 0
        self.postDetailView.frame.size.height = 200+CGFloat((textCount/60)*20)
        
        self.commentButton.tintColor = .black
    }
    func setCommentCount(model: WriteTextDetailData){
        self.commentCnt = model.commentCnt ?? 0
        self.commentButton.setTitle("댓글(\(model.commentCnt ?? 0))", for: .normal)
        //대댓글수 까지 포함
    }
    private func getBoardTextDetailData(){
        CommunityAPI.shared.getCommunityTextDetail(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success, data) in
            if success{
                guard let communityGetDetailList = data as? WriteTextDetailInformation else {return}
                let writeTextDetailData = communityGetDetailList.result.postdata
                self.writeTextDetailcommentData.append(contentsOf: communityGetDetailList.result.commentdata!)
                
                let commnetCount = communityGetDetailList.result
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
    @objc
    func tapWrtieComment(sender: UIButton!){
        
    }
}

extension BoardTextDetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.writeTextDetailcommentData.count
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footeriew = UIView(frame: CGRect(x: 0, y: 10, width: self.bookDetailCommentTableView.frame.width, height: 30))
        if section == 0 {
            let writeTextField = UITextField(frame: CGRect(x: 5, y: 0, width: Int(self.bookDetailCommentTableView.frame.width)*4/5, height: 30))
            writeTextField.layer.borderColor = UIColor(named: "grayColor")?.cgColor
            writeTextField.layer.borderWidth = 1
            writeTextField.layer.cornerRadius = 5
            let writeCommentButton = UIButton(frame: CGRect(x: Int(self.bookDetailCommentTableView.frame.width)*4/5 + 10, y: 0, width: Int(self.bookDetailCommentTableView.frame.width)*1/6, height: 30))
            writeCommentButton.setTitle("댓글 달기", for: .normal)
            writeCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            writeCommentButton.tintColor = .white
            writeCommentButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeCommentButton.layer.borderWidth = 1
            writeCommentButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeCommentButton.layer.cornerRadius = 10
            footeriew.addSubview(writeTextField)
            footeriew.addSubview(writeCommentButton)
            writeCommentButton.addTarget(self, action: #selector(tapWrtieComment), for: .touchUpInside)
        }
        
        return footeriew
    }
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 70
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : BoardTextCommentTableViewCell = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentTableViewCellid", for: indexPath)as? BoardTextCommentTableViewCell else {return UITableViewCell()}
        cell.setComment(model: self.writeTextDetailcommentData[indexPath.row])
        return cell
    }
    
}




