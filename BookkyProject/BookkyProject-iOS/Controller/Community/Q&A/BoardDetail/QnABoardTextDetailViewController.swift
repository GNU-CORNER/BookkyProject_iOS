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
    var isAccessible : Bool = false //사용자의 글인지 아닌지 확인
    lazy var rightButton: UIBarButtonItem = {
        let buttonImg = UIImage(systemName: "ellipsis")
        let barButtonItem = UIBarButtonItem(image: buttonImg, style: .plain, target: self, action: #selector(rightbarButtonAction(_:)))
        return barButtonItem
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        setTableViewCell()
        setBoardTextDetailUI()
        self.navigationItem.rightBarButtonItem = self.rightButton
        print("\(self.PID)BoardPID")
    }
    @objc private func rightbarButtonAction(_ sender : Any){
        let alert = UIAlertController(title: "글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive)
        if self.isAccessible == true {
            let delete = UIAlertAction(title: "글 삭제", style: .destructive){(_) in
                self.deletePost(communityBoardNumber: self.boardTypeNumber, PID: self.PID)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            let update = UIAlertAction(title: "글 수정", style: .default)
            alert.addAction(delete)
            alert.addAction(update)
            
        }
        alert.addAction(cancel)
        alert.addAction(report)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.getBoardTextDetailQnAData()
        })
      
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
   
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "writePostCommentSegue" {
            guard let QnAWriteAnswerVIewController = segue.destination as? QnAWriteAnswerViewController else {return}
            QnAWriteAnswerVIewController.PID = self.PID
            QnAWriteAnswerVIewController.boardTypeNumber = self.boardTypeNumber
        }else if  segue.identifier == "QnACommentSegue" {
            guard let QnACommentViewController = segue.destination as? QnACommentViewController else {return}
            QnACommentViewController.PID = self.PID
            QnACommentViewController.boardTypeNumber = self.boardTypeNumber
        }
    }
    private func setBoardTextDetailData(model :WriteTextDetailQnAPostData){
        self.QnATitleLabel.text = model.title
        self.QnAContentsLabel.text = model.contents
        self.QnACreateDateLabel.text = "\(model.createAt)"
        self.userNameLabel.text = model.nickname
        self.QnAViewCnt.text = "\(model.views)"
        self.likeCntLButton.setTitle("좋아요(\(model.like?.count ?? 0))", for: .normal)
        self.isAccessible = model.isAccessible
        
    }
    private func setReplyNComment(model : WriteTextDetailQnAInformation){
        self.CommetButton.setTitle("댓글(\(model.result.commentCnt ?? 0))", for: .normal)
        self.answerLabel.text = "답변(\(model.result.replyCnt))"
    }
// MARK: - API통신
    private func deletePost(communityBoardNumber: Int ,PID: Int){
        CommunityDeleteAPI.shared.DeletPost(CommunityBoardNumber: communityBoardNumber, PID: PID) { (success,data) in
            if success {
                print("댓글쓰기 성공")
            }else {
                print("실패")
            }
        }
        
    }
    private func getBoardTextDetailQnAData(){
        CommunityGetAPI.shared.getCommunityTextDetail(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success, data) in
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
    @objc func tapGoCommentofReplyComment(_ sender : Any){
        let parentID : Int = (sender as! CustomQnAButton).parentID
        guard let QnACommentViewController = storyboard?.instantiateViewController(withIdentifier: "QnACommentViewController") as? QnACommentViewController else{return}
        self.navigationController?.pushViewController(QnACommentViewController, animated: true)
        QnACommentViewController.PID = parentID
        QnACommentViewController.boardTypeNumber = self.boardTypeNumber
    }
    func commentDelte(){
        let alert = UIAlertController(title: "삭제 되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    //답글 ...버튼 액션
    @objc func addReplyCommentFunction(_ sender : Any){
        let parentID : Int = (sender as! CustomQnAButton).parentID
        let isAccessible : Bool = (sender as! CustomQnAButton).isAccessible
        let alert = UIAlertController(title: "답글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive)
        if isAccessible == true{
            let delete = UIAlertAction(title: "답글 삭제", style: .destructive){(_) in
                self.deletePost(communityBoardNumber: self.boardTypeNumber, PID: parentID)
                self.commentDelte()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.getBoardTextDetailQnAData()
                })
            }
            let update = UIAlertAction(title: "답글 수정", style: .default){(_)in
                
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
}
extension QnABoardTextDetailViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.QnAReplyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QnaAnswerTableViewCellid", for: indexPath) as? QnaAnswerTableViewCell else {return UITableViewCell()}
        cell.setReplyData(model:self.QnAReplyData[indexPath.row])
        cell.commentButton.addTarget(self, action: #selector(tapGoCommentofReplyComment) , for: .touchUpInside)
        cell.commentButton.parentID = self.QnAReplyData[indexPath.row].PID
        cell.addFunctionButton.addTarget(self, action: #selector(addReplyCommentFunction), for: .touchUpInside)
        cell.addFunctionButton.isAccessible = cell.QnaAnswerisAccessible
        cell.addFunctionButton.parentID = cell.PID
        return cell
    }
    
    
}
class CustomQnAButton : UIButton {
    var parentID : Int = 0
    var isAccessible : Bool = false
    convenience init(parentID : Int,isAccessible : Bool) {
        self.init()
        self.parentID = parentID
        self.isAccessible = isAccessible
        }
}
