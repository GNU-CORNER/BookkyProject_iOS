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
    var CommentContents: String = ""
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    var writeTextDetailcommentData : [WriteTextDetailCommentdata] = []
    var commentCnt : Int =  0
    @IBOutlet weak var postDetailView: UIView!
    //댓글달기
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var writeCommentButton: UIButton!
    @IBOutlet weak var CommentFooterView: UIView!
    var tableViewfooterHeight :CGFloat = 0
    var section : String = ""
    var replyCommentContents : String = ""
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
        self.bookDetailCommentTableView.register(UINib(nibName: "CommentHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "CommentHeaderid")
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
                let commnetCount = communityGetDetailList.result
                self.writeTextDetailcommentData = communityGetDetailList.result.commentdata ?? []
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
        self.CommentContents = self.commentTextView.text
        self.postCommentWriteData(commnet: self.CommentContents, parentID: 0, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
        self.writeTextDetailcommentData = []
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.getBoardTextDetailData()
        })
        self.commentTextView.text = nil
        if self.writeCommentButton.titleLabel?.text == "대댓글 달기"{
            self.writeCommentButton.setTitle("댓글 달기", for: .normal)
            
        }
    }
    @objc func replyCommentText(_ textField: UITextField){
        self.replyCommentContents = textField.text ?? ""
    }
    @objc func tapWriteReplyComment(_ sender: Any){
        print("\(self.replyCommentContents)")
    }
    //대댓글 작성뷰 버튼 액션
    @objc func tapAddCommetFunction(_ sender : Any){
        let section : String = (sender as! CustomButton).section as? String ?? ""
        self.section = section
        if self.tableViewfooterHeight == 50 {
            self.tableViewfooterHeight = 0
            
        }else if self.tableViewfooterHeight == 0 {
            self.tableViewfooterHeight = 50
            
        }
        self.bookDetailCommentTableView.reloadData()
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
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section !=  self.writeTextDetailcommentData.count+1{
            let replyCommentFooterView = UIView(frame: CGRect(x: 25, y: 10, width: self.bookDetailCommentTableView.frame.width, height: 35))
            let textView = UITextField(frame: CGRect(x: 25, y: 10, width: self.bookDetailCommentTableView.frame.width-100, height: 35))
            replyCommentFooterView.addSubview(textView)
            let writeReplyButton = CustomButton(frame:CGRect(x: self.bookDetailCommentTableView.frame.width-70, y: 10, width: 50, height: 30))
            replyCommentFooterView.addSubview(writeReplyButton)
//            textView.delegate = self
//            textView.text = "내용을 입력해주세요"
            textView.placeholder = "내용을 입력해주세요"
            textView.textColor = UIColor.lightGray
            textView.layer.borderWidth = 2
            textView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
            textView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
            textView.layer.cornerRadius = 8
            writeReplyButton.setTitle("대댓글 달기", for: .normal)
            writeReplyButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            writeReplyButton.tintColor = .white
            writeReplyButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeReplyButton.layer.borderWidth = 1
            writeReplyButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeReplyButton.layer.cornerRadius = 15
//            writeReplyButton.section =
            textView.addTarget(self, action: #selector(replyCommentText), for: .editingChanged)
            writeReplyButton.addTarget(self, action: #selector(tapWriteReplyComment), for: .touchUpInside)
            return replyCommentFooterView
        }
        return self.CommentFooterView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.section == String(section) {
           return self.tableViewfooterHeight
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentHeaderid") as! CommentHeaderTableViewCell
        headerView.userNameLabel.text = self.writeTextDetailcommentData[section].nickname
        headerView.contentsLabel.text = self.writeTextDetailcommentData[section].comment
        headerView.createDateLabel.text = self.writeTextDetailcommentData[section].updateAt
        let likeCnt = self.writeTextDetailcommentData[section].like?.count ?? 0
        headerView.likeCntLabel.text = "\(likeCnt)"
        headerView.layer.addBorder([.top], color: UIColor(named: "lightGrayColor") ?? UIColor.gray, width : 1)
        headerView.addFunctionButton.section = "\(section)"
        headerView.addFunctionButton.addTarget(self, action: #selector(tapAddCommetFunction), for: .touchUpInside)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.writeTextDetailcommentData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.writeTextDetailcommentData[section].childComment?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell  = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentTableViewCellid", for: indexPath)as? BoardTextCommentTableViewCell else {return UITableViewCell()}
//        cell.setComment(model: self.writeTextDetailcommentData[indexPath.section])
//        return cell
        guard let replycell  = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentReplyTableViewCellid", for: indexPath)as? CommunityReplyCommentTableViewCell else {return UITableViewCell()}
        replycell.setComment(model: (self.writeTextDetailcommentData[indexPath.section].childComment?[indexPath.row])!)
        //            cell.addMoreFunction.addTarget(self, action: #selector(tapAddCommetFunction), for: .touchUpInside)
        //            print("\(indexPath)")
        return replycell
        
    }
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
class CustomButton : UIButton {
    var section : String = ""
    convenience init(section: String) {
            self.init()
            self.section = section
        }
}

