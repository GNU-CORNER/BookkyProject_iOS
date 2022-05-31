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
    @IBOutlet weak var secondLineStackView: UIStackView!
    var replyContents: String = ""
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    var writeTextDetailcommentData : [WriteTextDetailCommentdata] = []
    var commentCnt : Int =  0
    var totalCommnet : [Any] = []
    // 0 : 댓글 1 : 대댓글
    var commentSection : Int = 0
    var replyCommentNickName : String = ""
    @IBOutlet weak var postDetailView: UIView!
    //댓글달기
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var writeCommentButton: UIButton!
    @IBOutlet weak var CommentFooterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCell()
        
        setNavigationUI()
        getBoardTextDetailData()
        setBoardTextDetailUI()
        print("\(self.PID)")
        
        footerViewUISet()
        secondLineStackView.setCustomSpacing(5, after: self.textDetailViewsImage)
    }
    func setNavigationUI(){
        if self.boardTypeNumber == 0 {
            self.NavigationBarTitleLabel.title = "자유 게시판"
        }else if self.boardTypeNumber == 1{
            self.NavigationBarTitleLabel.title = "책 장터 게시판"
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    func setTableViewCell(){
        self.bookDetailCommentTableView.dataSource = self
        self.bookDetailCommentTableView.delegate = self
        let cellNib = UINib(nibName: "BoardTextCommentTableViewCell", bundle: nil)
        self.bookDetailCommentTableView.register(cellNib, forCellReuseIdentifier: "BoardTextCommentTableViewCellid")
        let cellreplyNib = UINib(nibName: "CommunityReplyCommentTableViewCell", bundle: nil)
        self.bookDetailCommentTableView.register(cellreplyNib, forCellReuseIdentifier: "BoardTextCommentReplyTableViewCellid")
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
    @IBAction func tapWriteComment(_ sender: UIButton) {
        self.replyContents = self.commentTextView.text
        self.postCommentWriteData(commnet: self.replyContents, parentID: 0, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
        self.writeTextDetailcommentData = []
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.getBoardTextDetailData()
        })
        self.commentTextView.text = nil
        if self.writeCommentButton.titleLabel?.text == "대댓글 달기"{
            self.writeCommentButton.setTitle("댓글 달기", for: .normal)
            
        }
    }
    //    @objc func tapWrtieComment(sender: AnyObject){
    //        print("버튼클릭")
    //        self.postCommentWriteData(commnet: self.replyContents, parentID: 0, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
    //        self.writeTextDetailcommentData = []
    //
    //        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
    //            self.getBoardTextDetailData()
    //        })
    //
    //
    //
    //    }
    //    @objc func writeCommentTextField(textField : UITextField){
    //        self.replyContents = "\(textField.text ?? "")"
    //
    //    }
    @objc
    func tapAddCommetFunction(_ sender : UIButton){
        let contentView = sender.superview
        let cell = contentView?.superview?.superview as! UITableViewCell
        let indexPath = self.bookDetailCommentTableView.indexPath(for: cell)
        self.commentTextView.text = self.writeTextDetailcommentData[indexPath?.row ?? 0].nickname
        self.writeCommentButton.setTitle("대댓글 달기", for: .normal)
    }
    
    private func postCommentWriteData(commnet : String ,parentID : Int ,communityBoardNumber: Int , PID : Int){
        CommunityAPI.shared.postCommunityCommentWrite(comment: commnet, parentID: parentID, CommunityBoardNumber: communityBoardNumber, PID: PID) {(succes,data) in
            if succes{
                print("댓글 쓰기 성공")
                
            }else{
                print("실패")
            }
        }
    }
    private func footerViewUISet(){
        self.commentTextView.delegate = self
        self.commentTextView.text = "내용을 입력해주세요"
        self.commentTextView.textColor = UIColor.lightGray
        self.commentTextView.layer.borderWidth = 2
        self.commentTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        self.commentTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        
        self.writeCommentButton.setTitle("댓글 달기", for: .normal)
        self.writeCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.writeCommentButton.tintColor = .white
        self.writeCommentButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeCommentButton.layer.borderWidth = 1
        self.writeCommentButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeCommentButton.layer.cornerRadius = 15
    }
}

extension BoardTextDetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.writeTextDetailcommentData.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            //            return postDetailView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.CommentFooterView
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if self.writeTextDetailcommentData[indexPath.row].reply == 0 {
                guard let cell  = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentTableViewCellid", for: indexPath)as? BoardTextCommentTableViewCell else {return UITableViewCell()}
                cell.setComment(model: self.writeTextDetailcommentData[indexPath.row])
                cell.commentFunctionButton.addTarget(self, action: #selector(tapAddCommetFunction(_:)), for: .touchUpInside)
                
                return cell
            }else if self.writeTextDetailcommentData[indexPath.row].reply == 1 {
                guard let cell  = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentReplyTableViewCellid", for: indexPath)as? CommunityReplyCommentTableViewCell else {return UITableViewCell()}
                cell.setComment(model: self.writeTextDetailcommentData[indexPath.row])
                //            cell.addMoreFunction.addTarget(self, action: #selector(tapAddCommetFunction), for: .touchUpInside)
                //            print("\(indexPath)")
                return cell
            }
            
        }
        return UITableViewCell()
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        let height = tableView.estimatedRowHeight
    //        return CGFloat(height)
    //
    //    }
}


extension BoardTextDetailViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
}

