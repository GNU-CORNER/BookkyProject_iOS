//
//  QnABoardTextDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/16.
//

import UIKit

class QnABoardTextDetailViewController: UIViewController {
    @IBOutlet weak var QnATitleLabel: UILabel!
    @IBOutlet weak var QnACreateDateLabel: UILabel!
    @IBOutlet weak var QnAViewImage: UIImageView!
    @IBOutlet weak var QnAViewCnt: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var QnAContentsLabel: UILabel!
    @IBOutlet weak var likeCntLButton: UIButton!
    @IBOutlet weak var CommetButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var writeAnswerButton: UIButton!
    @IBOutlet weak var QnATableView: UITableView!
   
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    var QnAReplyData : [WriteTextDetailQnAReplyData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        setTableViewCell()
        setBoardTextDetailUI()
        getBoardTextDetailQnAData()
    }
    
    func setTableViewCell(){
        self.QnATableView.dataSource = self
        self.QnATableView.delegate = self
        let cellNib = UINib(nibName: "QnaAnswerTableViewCell", bundle: nil)
        self.QnATableView.register(cellNib, forCellReuseIdentifier: "QnaAnswerTableViewCellid")
        
    }
    func setBoardTextDetailUI(){
        self.QnATitleLabel.font = UIFont.systemFont(ofSize: 20)
        self.QnACreateDateLabel.font = UIFont.systemFont(ofSize: 11)
        self.QnACreateDateLabel.textColor = .gray
        self.QnAViewCnt.font = UIFont.systemFont(ofSize: 11)
        self.QnAContentsLabel.font = UIFont.systemFont(ofSize: 13)
        
        self.userNameLabel.font = UIFont.systemFont(ofSize: 14)
   
        self.likeCntLButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.likeCntLButton.setTitleColor(UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1), for: .normal)
        self.likeCntLButton.tintColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        self.likeCntLButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        //버튼이미지크기
        self.likeCntLButton.setPreferredSymbolConfiguration(.init(pointSize: 12), forImageIn: .normal)
        self.CommetButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.CommetButton.tintColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
        self.answerLabel.font = UIFont.systemFont(ofSize: 12)
        self.answerLabel.textColor = UIColor(named: "PrimaryBlueColor")
        self.writeAnswerButton.setTitle("답변달기", for: .normal)
        self.writeAnswerButton.tintColor = .black
        self.writeAnswerButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
    }
   
    @IBAction func tapGoCommentView(_ sender: Any) {
        guard let CommentViewConroller  = self.storyboard?.instantiateViewController(withIdentifier: "QnACommentViewController")as? QnACommentViewController else {return}
        self.navigationController?.pushViewController(CommentViewConroller, animated: true)
    }
    private func setBoardTextDetailData(model :WriteTextDetailQnAPostData){
        self.QnATitleLabel.text = model.title
        self.QnAContentsLabel.text = model.contents
        self.QnACreateDateLabel.text = "\(model.createAt)"
        self.userNameLabel.text = model.nickname
        self.QnAViewCnt.text = "\(model.views)"
        self.likeCntLButton.setTitle("좋아요(\(model.like?.count ?? 0))", for: .normal)
        
    }
    private func setReplyNComment(model : WriteTextDetailQnAInformation){
        self.CommetButton.setTitle("댓글(\(model.result.commentCnt ?? 0))", for: .normal)
        self.answerLabel.text = "답변(\(model.result.replyCnt))"
    }
    private func getBoardTextDetailQnAData(){
        CommunityAPI.shared.getCommunityTextDetail(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success, data) in
            if success{
                guard let communityGetDetailList = data as? WriteTextDetailQnAInformation else {return}
                let writeTextDetailQnAData = communityGetDetailList.result.postdata
                self.QnAReplyData = communityGetDetailList.result.replydata!
                if communityGetDetailList.success{
                    DispatchQueue.main.async {
                        self.setBoardTextDetailData(model: writeTextDetailQnAData)
                        self.setReplyNComment(model: communityGetDetailList)
                        self.QnATableView.reloadData()
                        
                    }
                }else{
                    print("통신오류")
                }
            }
        }
    }
    
}
extension QnABoardTextDetailViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.QnAReplyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QnaAnswerTableViewCellid", for: indexPath) as? QnaAnswerTableViewCell else {return UITableViewCell()}
        cell.setReplyData(model:self.QnAReplyData[indexPath.row])
        return cell
    }
    
    
}
