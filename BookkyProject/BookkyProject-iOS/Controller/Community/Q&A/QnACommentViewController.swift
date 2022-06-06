//
//  QnACommentViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/17.
//

import UIKit
class QnACommentViewController: UIViewController {
    @IBOutlet weak var QnACommentTableView: UITableView!
    @IBOutlet weak var QnAcommentFooterView: UIView!
    @IBOutlet weak var QnACommentTextView: UITextView!
    @IBOutlet weak var QnAWriteCommentButton: AutoAddPaddingButtton!
    var QnAreplyCommentFooterView : UIView!
    var QnAreplytextField : UITextField!
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    var tableViewfooterHeight : CGFloat = 0
    var QnAreplyCommentContents : String = ""
    var QnACommentContents: String = "" // 댓글 작성내용
    var QnACommentList : [QnACommentDataList] = []
    var section : Int = 0
    var QnAreplyparentID : Int = 0
    var CID : Int = 0 // 댓글 ID
    var replycommentisAccessible : Bool = false // 사용자의 대댓글인지 아닌지 확인
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCell()
        getCommentData()
        QnAfooterViewUISet()
        print("\(self.PID)")
        
    }
    private func QnAfooterViewUISet(){
        self.QnACommentTextView.delegate = self
        self.QnACommentTextView.text = "내용을 입력해주세요"
        self.QnACommentTextView.textColor = UIColor.lightGray
        self.QnACommentTextView.layer.borderWidth = 2
        self.QnACommentTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        self.QnACommentTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        
        self.QnAWriteCommentButton.setTitle("댓글 달기", for: .normal)
        self.QnAWriteCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.QnAWriteCommentButton.tintColor = .white
        self.QnAWriteCommentButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.QnAWriteCommentButton.layer.borderWidth = 1
        self.QnAWriteCommentButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.QnAWriteCommentButton.layer.cornerRadius = 15
    }
    private func setTableViewCell(){
        self.QnACommentTableView.delegate = self
        self.QnACommentTableView.dataSource = self
        let cellNib = UINib(nibName: "BoardTextCommentTableViewCell", bundle: nil)
        self.QnACommentTableView.register(cellNib, forCellReuseIdentifier: "BoardTextCommentTableViewCellid")
        let replyCellNib = UINib(nibName: "CommunityReplyCommentTableViewCell", bundle: nil)
        self.QnACommentTableView.register(replyCellNib, forCellReuseIdentifier: "BoardTextCommentReplyTableViewCellid")
        self.QnACommentTableView.register(UINib(nibName: "CommentHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "CommentHeaderid")
    }

// MARK: - API 통신
    private func getCommentData(){
        CommunityGetAPI.shared.getCommunityQnAComment(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success , data) in
            if success{
                guard let communityQnAGetDetailList = data as? QnACommentDataInformation else {return}
                self.QnACommentList = communityQnAGetDetailList.result.commentdata
                if communityQnAGetDetailList.success{
                    DispatchQueue.main.async {
                        self.QnACommentTableView.reloadData()
                    }
                }else{
                    print("통신오류")
                }
            }
            
            
        }
    }
    private func QnApostCommentWriteData(commnet : String ,parentID : Int ,communityBoardNumber: Int , PID : Int){
        CommunityPostAPI.shared.postCommunityCommentWrite(comment: commnet, parentID: parentID, CommunityBoardNumber: communityBoardNumber, PID: PID) {(succes,data) in
            if succes{
                print("댓글 쓰기 성공")
                
            }else{
                print("실패")
            }
        }
    }
    private func deleteComment(communityBoardNumber: Int ,CID: Int){
        CommunityDeleteAPI.shared.DeletComment(CommunityBoardNumber: communityBoardNumber, CID: CID) { (success,data) in
            if success{
                print("댓글 삭제 성공")
            }else {
                print("실패")
            }
        }
    }
    @IBAction func QnATapWriteComment(_ sender: UIButton) {
        self.QnACommentContents = self.QnACommentTextView.text
        self.QnApostCommentWriteData(commnet: self.QnACommentContents, parentID: 0, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
        self.QnACommentList = []
        QnAreplyCommentComplete()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.getCommentData()
        })
        
        self.QnACommentTextView.text = nil
    }
    // 글작성 완료 alert ,동기 비동기 문제로 대댓글 작성칸이 사라지지 않아 추가를 함!
    func QnAreplyCommentComplete(){
        let alert = UIAlertController(title: "작성이 완료 되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    private func QnAreplyCommentActionsheet(){
        let alert = UIAlertController(title: "대댓글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive)
        if self.replycommentisAccessible == true {
            let delete = UIAlertAction(title: "대댓글 삭제", style: .destructive){(_) in
                self.deleteComment(communityBoardNumber:self.boardTypeNumber  ,CID: self.CID)
                self.commentDelte()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.getCommentData()
                })
            }
            let update = UIAlertAction(title: "대댓글 수정", style: .default){(_) in
            }
            alert.addAction(delete)
            alert.addAction(update)
        }
        alert.addAction(cancel)
        alert.addAction(report)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    // 삭제 완료 alert , 이유 위와 같음
    func commentDelte(){
        let alert = UIAlertController(title: "삭제 되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    //대댓글 작성뷰 버튼 액션 '...'버튼
    @objc func QnAtapAddCommetFunction(_ sender : Any){
        let section : Int = (sender as! CustomButton).section
        let parentID : Int = (sender as! CustomButton).CID
        let isAccessible : Bool = (sender as! CustomButton).isAccessible
        let alert = UIAlertController(title: "댓글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive)
        if isAccessible == true {
            let delete = UIAlertAction(title: "댓글 삭제", style: .destructive){(_) in
                self.deleteComment(communityBoardNumber:self.boardTypeNumber  ,CID: parentID)
                self.commentDelte()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.getCommentData()
                })
            }
            let update = UIAlertAction(title: "댓글 수정", style: .default){(_) in
                
            }
            alert.addAction(delete)
            alert.addAction(update)
        }
        let writeComment = UIAlertAction(title: "대댓글 작성", style: .default){(_) in
            self.QnAreplyparentID = parentID
            self.section = section
            self.tableViewfooterHeight = 50
            self.getCommentData()
        }
        
        alert.addAction(cancel)
        alert.addAction(report)
        alert.addAction(writeComment)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }    //대댓글 작성 TextField
    @objc func QnAreplyCommentText(_ textField: UITextField){
        self.QnAreplyCommentContents = textField.text ?? ""
    }
    //대댓글 작성 버튼
    @objc func QnAtapWriteReplyComment(_ sender: Any){
        self.tableViewfooterHeight = 0
        self.QnApostCommentWriteData(commnet: self.QnAreplyCommentContents, parentID: self.QnAreplyparentID, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
        QnAreplyCommentComplete()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.getCommentData()
        })
    }
    
}
extension QnACommentViewController :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section !=  self.QnACommentList.count+1{
            self.QnAreplyCommentFooterView = UIView(frame: CGRect(x: 25, y: 10, width: self.QnACommentTableView.frame.width, height: 35))
            self.QnAreplytextField = UITextField(frame: CGRect(x: 30, y: 10, width: self.QnACommentTableView.frame.width-100, height: 30))
            let writeReplyButton = UIButton(frame:CGRect(x: self.QnACommentTableView.frame.width-70, y: 10, width: 50, height: 30))
            //            textView.delegate = self
            self.QnAreplytextField.placeholder = "내용을 입력해주세요"
            self.QnAreplytextField.layer.borderWidth = 2
            self.QnAreplytextField.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
            self.QnAreplytextField.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
            self.QnAreplytextField.layer.cornerRadius = 8
            self.QnAreplytextField.clearButtonMode = .whileEditing
            writeReplyButton.setTitle("대댓글 달기", for: .normal)
            writeReplyButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            writeReplyButton.tintColor = .white
            writeReplyButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeReplyButton.layer.borderWidth = 1
            writeReplyButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeReplyButton.layer.cornerRadius = 15
            self.QnAreplytextField.addTarget(self, action: #selector(QnAreplyCommentText), for: .editingChanged)
            writeReplyButton.addTarget(self, action: #selector(QnAtapWriteReplyComment), for: .touchUpInside)
            
            self.QnAreplyCommentFooterView.addSubview(self.QnAreplytextField)
            self.QnAreplyCommentFooterView.addSubview(writeReplyButton)
            return self.QnAreplyCommentFooterView
        }
        return self.QnAcommentFooterView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.section == section {
            print("\(self.tableViewfooterHeight)")
            return self.tableViewfooterHeight
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentHeaderid") as! CommentHeaderTableViewCell
        headerView.userNameLabel.text = self.QnACommentList[section].nickname
        headerView.contentsLabel.text = self.QnACommentList[section].comment
        headerView.createDateLabel.text = self.QnACommentList[section].updateAt
        let likeCnt = self.QnACommentList[section].like?.count ?? 0
        headerView.addFunctionButton.setTitle("공감(\(likeCnt))", for: .normal) 
        headerView.layer.addBorder([.top], color: UIColor(named: "lightGrayColor") ?? UIColor.gray, width : 1)
        headerView.addFunctionButton.section = section
        headerView.addFunctionButton.CID = self.QnACommentList[section].CID
        headerView.addFunctionButton.isAccessible = self.QnACommentList[section].isAccessible
        headerView.addFunctionButton.addTarget(self, action: #selector(QnAtapAddCommetFunction), for: .touchUpInside)
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.QnACommentList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.QnACommentList[section].childComment?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let replycell  = QnACommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentReplyTableViewCellid", for: indexPath)as? CommunityReplyCommentTableViewCell else {return UITableViewCell()}
        replycell.setQnAComment(model: (self.QnACommentList[indexPath.section].childComment?[indexPath.row])!)
        replycell.addbuttonAction = {
            self.QnAreplyCommentActionsheet()
            self.replycommentisAccessible = replycell.isAccessible
            self.CID = replycell.CID
        }
        return replycell
        
    }
}
extension QnACommentViewController : UITextViewDelegate{
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
