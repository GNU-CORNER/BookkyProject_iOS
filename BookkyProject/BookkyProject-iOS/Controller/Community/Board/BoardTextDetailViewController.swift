//
//  BoardTextDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/10.
//

import UIKit
import PhotosUI

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
    @IBOutlet weak var postDetailView: UIView!
    // MARK: - 댓글 View
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var writeCommentButton: UIButton!
    @IBOutlet weak var CommentFooterView: UIView!
    // MARK: - 추가한 책 View
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAPLabel: UILabel!
    @IBOutlet weak var userImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bookViewHeight: NSLayoutConstraint!
    var writeTextDetailcommentData : [WriteTextDetailCommentdata] = [] // 글상세정보 댓글 데이터를 위함
    var PID : Int = 0 // POST ID
    var boardTypeNumber : Int = 0 // 게시판 번호
    var commentCnt : Int =  0 // 댓글 갯수
    // commentType  : 작성 0. 수정 1

    var commentType : Int = 0
    var replyCommentType : Int = 0
    // MARK: - 대댓글 을 위한 변수
    var section : Int = 0 //선택한 댓글에 대한 섹션
    var replyparentID : Int = 0  // 대댓글 작성을 위한 댓글의 CID
    var tableViewfooterHeight :CGFloat = 0 // footerView 높이(대댓글 작성 View)
    var replytextField : UITextField! // 대댓글 텍스트 필드
    var CommentContents: String = "" // 댓글 작성내용
    var replyCommentContents : String = "" // 대댓글 작성 내용
    var replyCommentFooterView : UIView! // 대댓글 View
    var writeisAccessible : Bool = false // 사용자의 글인지 아닌지 확인
    var replycommentisAccessible : Bool = false // 사용자의 대댓글인지 아닌지 확인
    var bookdata : PostDetailBookData?
    var CID : Int = 0
    var CommentCID : Int = 0 // 댓글 ID
    var ReplyCellCID : Int = 0 // 대댓글 ID
    var ImageArray : [String] = []
    var updateImageArray : [UIImage] = []
    var BID : Int = 0
    var PostisLiked : Bool = false
    var commentisLiked : Bool = false
    var writeReplyButton : UIButton!
    @IBOutlet weak var DetailBookView: UIView!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    lazy var rightButton: UIBarButtonItem = {
        let buttonImg = UIImage(systemName: "ellipsis")
        let barButtonItem = UIBarButtonItem(image: buttonImg, style: .plain, target: self, action: #selector(rightbarButtonAction(_:)))
        return barButtonItem
    }()
    var previousBoardNumber : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCell()
        setNavigationUI()
        setBoardTextDetailUI()
        footerViewUISet()
        setCollectionViewCell()
        setBookViewUI()
        secondLineStackView.setCustomSpacing(5, after: self.textDetailViewsImage)
        self.navigationItem.rightBarButtonItem = self.rightButton
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getBoardTextDetailData()
        self.updateImageArray = []
    }
    
    
    @objc private func rightbarButtonAction(_ sender : Any){
        let alert = UIAlertController(title: "글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive){(_) in
            let reportAlert = UIAlertController(title: "신고 사유 선택", message: nil, preferredStyle: .actionSheet)
            let diseasePost = UIAlertAction(title: "불건전 글", style: .default){(_) in
                self.reportAlert(CID: 0, PID: self.PID)
            }
            let adNsalePost = UIAlertAction(title: "광고 및 판매 글", style: .default){(_) in
                self.reportAlert(CID: 0, PID: self.PID)
            }
            let spamPost = UIAlertAction(title: "악성 도배 글", style: .default){(_) in
                self.reportAlert(CID: 0, PID: self.PID)
            }
            let swearPost = UIAlertAction(title: "욕설 및 비하 글", style: .default){(_) in
                self.reportAlert(CID: 0, PID: self.PID)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            reportAlert.addAction(diseasePost)
            reportAlert.addAction(adNsalePost)
            reportAlert.addAction(spamPost)
            reportAlert.addAction(swearPost)
            reportAlert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(reportAlert, animated: true)
            }
        }
        if self.writeisAccessible == true {
            let delete = UIAlertAction(title: "글 삭제", style: .destructive){(_) in
                self.deletePost(communityBoardNumber: self.boardTypeNumber, PID: self.PID)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
                
            }
            let update = UIAlertAction(title: "글 수정", style: .default){(_)in
                guard let UpdatePostviewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePostViewController") as? UpdatePostViewController
                else {return}
                UpdatePostviewController.titleString = self.textDetailTitleLabel.text ?? ""
                UpdatePostviewController.contentsString = self.textDetailContentsLabel.text ?? ""
                UpdatePostviewController.BID = self.BID
                UpdatePostviewController.PID = self.PID
                UpdatePostviewController.bookData = self.bookdata
                UpdatePostviewController.imageArray = self.updateImageArray
                UpdatePostviewController.boardTypeNumber = self.boardTypeNumber
                self.navigationController?.pushViewController(UpdatePostviewController, animated: true)
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
    private func setNavigationUI(){
        if self.boardTypeNumber == 0 {
            self.NavigationBarTitleLabel.title = "자유 게시판"
        }else if self.boardTypeNumber == 1{
            self.NavigationBarTitleLabel.title = "책 장터 게시판"
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setBoardTextDetailUI(){
        self.textDetailTitleLabel.font = UIFont.systemFont(ofSize: 20)
        self.textDetailCreateDateLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailCreateDateLabel.textColor = .gray
        self.textDetailViewsLabel.font = UIFont.systemFont(ofSize: 11)
        self.textDetailContentsLabel.font = UIFont.systemFont(ofSize: 13)
        self.textDetailUserNickname.font = UIFont.systemFont(ofSize: 14)
        
    }
    // protocol 및 xib파일 register
    func setTableViewCell(){
        self.bookDetailCommentTableView.dataSource = self
        self.bookDetailCommentTableView.delegate = self
        self.bookDetailCommentTableView.register(UINib(nibName: "CommentHeaderTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "CommentHeaderid")
        let cellreplyNib = UINib(nibName: "CommunityReplyCommentTableViewCell", bundle: nil)
        self.bookDetailCommentTableView.register(cellreplyNib, forCellReuseIdentifier: "BoardTextCommentReplyTableViewCellid")
    }
    
    func setBoardTextDetailData(model :WriteTextDetailPostData ){
        self.textDetailTitleLabel.text = model.title
        self.textDetailCreateDateLabel.text = model.createAt
        self.textDetailViewsLabel.text = "\(model.views)"
        self.textDetailContentsLabel.text = model.contents
        self.textDetailUserNickname.text = model.nickname
        if let url = URL(string: model.thumbnail ?? "") {
            self.textDetailUserImage.load(url: url)
        }
        
        self.textDetailContentsLabel.numberOfLines = 0
        let likeCount =  model.like?.count ?? 0
        self.likeThatButton.setTitle("좋아요(\(likeCount))", for: .normal)
        self.likeThatButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        if self.PostisLiked == true{
            self.likeThatButton.tintColor = UIColor(named: "PrimaryBlueColor")
        }else {
            self.likeThatButton.tintColor = UIColor.gray
        }
        let textCount = self.textDetailContentsLabel.text?.count ?? 0
        if self.bookdata?.TITLE == nil && self.ImageArray == [] {
            self.postDetailView.frame.size.height = 200+CGFloat((textCount/60)*20)
        }else if self.bookdata?.TITLE == nil || self.ImageArray == [] {
            self.postDetailView.frame.size.height = 320+CGFloat((textCount/60)*20)
        }else {
            self.postDetailView.frame.size.height = 460+CGFloat((textCount/60)*20)
        }
        self.commentButton.tintColor = .black
        self.writeisAccessible = model.isAccessible
    }
    func setCommentCount(model: WriteTextDetailData){
        self.commentCnt = model.commentCnt ?? 0
        self.commentButton.setTitle("댓글(\(model.commentCnt ?? 0))", for: .normal)
        //대댓글수 까지 포함
    }
    func setBookView(model : PostDetailBookData ){
        if let url = URL(string: model.thumbnailImage ?? "") {
            self.bookImageView.load(url: url)
        }
        self.bookNameLabel.text = model.TITLE
        let Author = model.AUTHOR ?? ""
        let PUBLISHER = model.PUBLISHER ?? ""
        self.bookAPLabel.text = "\(Author)/\(PUBLISHER)"
        
    }
    func setBookViewUI(){
        self.bookNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.bookAPLabel.font = UIFont.systemFont(ofSize: 12)
        self.DetailBookView.layer.borderWidth = 2
        self.DetailBookView.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
    }
    
    // MARK: - 데이터 통신함수
    //GET PostDetail
    private func getBoardTextDetailData(){
        CommunityGetAPI.shared.getCommunityTextDetail(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { (success, data) in
            if success{
                guard let communityGetDetailList = data as? WriteTextDetailInformation else {return}
                let writeTextDetailData = communityGetDetailList.result.postdata
                let commnetCount = communityGetDetailList.result
                self.bookdata = communityGetDetailList.result.Book
                
                self.BID = self.bookdata?.TBID ?? 0
                self.ImageArray = writeTextDetailData.postImage ?? []
                self.PostisLiked = writeTextDetailData.isLiked
                self.writeTextDetailcommentData = communityGetDetailList.result.commentdata ?? []
                if communityGetDetailList.success{
                    DispatchQueue.main.async {
                        if self.bookdata?.TITLE == nil {
                            self.bookViewHeight.constant = 0
                        }else{
                            self.setBookView(model:self.bookdata!)
                        }
                        if self.ImageArray == [] {
                            self.userImageViewHeight.constant = 0
                        }else {
                            self.ImageCollectionView.reloadData()
                        }
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
    
    // Write 댓글,대댓글
    private func postCommentWriteData(commnet : String ,parentID : Int ,communityBoardNumber: Int , PID : Int){
        CommunityPostAPI.shared.postCommunityCommentWrite(comment: commnet, parentID: parentID, CommunityBoardNumber: communityBoardNumber, PID: PID) {(succes,data) in
            if succes{
                print("댓글 쓰기 성공")
                
            }else{
                print("댓글 쓰기 실패")
            }
        }
    }
    // 댓글 수정
    private func updateCommentWriteData(commnet : String ,parentID : Int ,communityBoardNumber: Int , CID : Int){
        CommunityUpdateAPI.shared.UpdateCommunityComment(textContent: commnet, CommunityBoardNumber: communityBoardNumber, parentQPID: parentID, CID: CID) { success, data in
            if success{
                print("댓글 수정 성공")
            }else {
                print("댓글 수정 실패")
            }
        }
        
    }
    //Delete Post
    private func deletePost(communityBoardNumber: Int ,PID: Int){
        CommunityDeleteAPI.shared.DeletPost(CommunityBoardNumber: communityBoardNumber, PID: PID) { (success,data) in
            if success {
                print("글 삭제 성공")
            }else {
                print("실패")
            }
        }
        
    }
    //Delete Comment
    private func deleteComment(communityBoardNumber: Int ,CID: Int){
        CommunityDeleteAPI.shared.DeletComment(CommunityBoardNumber: communityBoardNumber, CID: CID) { (success,data) in
            if success{
                print("댓글 삭제 성공")
            }else {
                print("실패")
            }
        }
        
    }
    //좋아요 버튼 클릭
    @IBAction func taplikePostButton(_ sender: UIButton) {
        CommunityPostAPI.shared.LikeCommunityPost(CommunityBoardNumber: self.boardTypeNumber, PID: self.PID) { success, data in
            if success {
                print("좋아요 성공")
            }else {
                print("실패")
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            self.getBoardTextDetailData()
        })
    }
    //댓글작성 버튼 클릭
    @IBAction func tapWriteComment(_ sender: UIButton) {
        if self.commentType == 0 {
            
            self.CommentContents = self.commentTextView.text
            self.postCommentWriteData(commnet: self.CommentContents, parentID: 0, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
            self.writeTextDetailcommentData = []
            replyCommentComplete()
        }else if self.commentType == 1{
            self.CommentContents = self.commentTextView.text
            self.updateCommentWriteData(commnet:  self.CommentContents, parentID: self.PID, communityBoardNumber: self.boardTypeNumber, CID:  self.CommentCID)
            self.writeCommentButton.setTitle("댓글 달기", for: .normal)
            self.commentType = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.getBoardTextDetailData()
        })
        
        self.commentTextView.text = nil
    }
    //대댓글 작성 TextField
    @objc func replyCommentText(_ textField: UITextField){
        self.replyCommentContents = textField.text ?? ""
    }
    //대댓글 작성 버튼
    @objc func tapWriteReplyComment(_ sender: Any){
        if self.replyCommentType == 0 {
            self.tableViewfooterHeight = 0
            self.postCommentWriteData(commnet: self.replyCommentContents, parentID: self.replyparentID, communityBoardNumber: self.boardTypeNumber, PID: self.PID)
            replyCommentComplete()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.getBoardTextDetailData()
            })
        }else if self.replyCommentType == 1{
            self.tableViewfooterHeight = 0
            self.updateCommentWriteData(commnet: self.replyCommentContents, parentID:self.PID , communityBoardNumber: self.boardTypeNumber, CID: self.ReplyCellCID)
            replyCommentComplete()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.getBoardTextDetailData()
            })
        }
        
        
        
    }
    func tapReport(CID:Int ,PID :Int ,communityType : Int){
        ReportPostAPi.shared.postReportAPI(CID: CID, PID: PID, communityType: communityType){(success,data) in
            if success {
                self.completeReport()
            }else {
                print("오류가 발생확인필요")
            }
        }
    }
    //신고 팝업창
    func reportAlert(CID : Int , PID : Int){
        let reportAlert = UIAlertController(title: "게시판 성격에 부적절함", message: "게시물의 주제가 게시판의 성격에 벗어나, 다른 이용자에게 불편을 끼칠수 있는 게시물", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "확인", style: .default){(_) in
            self.tapReport(CID: CID, PID: PID,communityType: 0)
        }
        reportAlert.addAction(cancel)
        reportAlert.addAction(report)
        DispatchQueue.main.async {
            self.present(reportAlert, animated: true)
        }
    }
    // 글작성 완료 alert ,동기 비동기 문제로 대댓글 작성칸이 사라지지 않아 추가를 함!
    func replyCommentComplete(){
        let alert = UIAlertController(title: "작성이 완료 되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
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
    //신고 완료 -> 오류 수정 필요 alert main queue 에서 모든 코드를 적어야된다는데 위에 함수는 실행이 왜 되는지 이해안됨.
    func completeReport(){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "신고가 접수되었습니다.", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
    }
    //대댓글 ActionSheet
    private func replyCommentActionsheet(){
        let alert = UIAlertController(title: "대댓글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive){(_) in
            let reportAlert = UIAlertController(title: "신고 사유 선택", message: nil, preferredStyle: .actionSheet)
            let diseasePost = UIAlertAction(title: "불건전 댓글", style: .default){(_) in
                self.reportAlert(CID: self.ReplyCellCID, PID: 0)
            }
            let adNsalePost = UIAlertAction(title: "광고 및 판매 댓글", style: .default){(_) in
                self.reportAlert(CID: self.ReplyCellCID, PID: 0)
            }
            let spamPost = UIAlertAction(title: "악성 도배 댓글", style: .default){(_) in
                self.reportAlert(CID: self.ReplyCellCID, PID: 0)
            }
            let swearPost = UIAlertAction(title: "욕설 및 비하 댓글", style: .default){(_) in
                self.reportAlert(CID: self.ReplyCellCID, PID: 0)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            reportAlert.addAction(diseasePost)
            reportAlert.addAction(adNsalePost)
            reportAlert.addAction(spamPost)
            reportAlert.addAction(swearPost)
            reportAlert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(reportAlert, animated: true)
            }
        }
     
        if self.replycommentisAccessible == true {
            let delete = UIAlertAction(title: "대댓글 삭제", style: .destructive){(_) in
                self.deleteComment(communityBoardNumber:self.boardTypeNumber  ,CID: self.ReplyCellCID)
                self.commentDelte()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    
                    self.getBoardTextDetailData()
                })
            }
            let update = UIAlertAction(title: "대댓글 수정", style: .default){(_)in
                self.replyCommentType = 1
                self.tableViewfooterHeight = 50
                self.getBoardTextDetailData()
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
    //버튼 액션 '...'버튼
    @objc func tapAddCommetFunction(_ sender : Any){
        let section : Int = (sender as! CustomButton).section
        let CID : Int = (sender as! CustomButton).CID
        let isAccessible : Bool = (sender as! CustomButton).isAccessible
        let contents : String = (sender as! CustomButton).contents
        let alert = UIAlertController(title: "댓글 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        if isAccessible == true{
            let delete = UIAlertAction(title: "댓글 삭제", style: .destructive){(_) in
                self.deleteComment(communityBoardNumber:self.boardTypeNumber  ,CID: CID)
                self.commentDelte()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.getBoardTextDetailData()
                })
            }
            let update = UIAlertAction(title: "댓글 수정", style: .default){(_)in
                
                self.commentTextView.text = contents
                self.commentTextView.textColor = .black
                self.commentType = 1
                self.writeCommentButton.setTitle("댓글 수정", for: .normal)
                self.CommentCID = CID
                self.CommentContents = self.commentTextView.text
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.bookDetailCommentTableView.reloadData()
                })
                
            }
            alert.addAction(delete)
            alert.addAction(update)
        }
        let report = UIAlertAction(title: "신고", style: .destructive){(_) in
            let reportAlert = UIAlertController(title: "신고 사유 선택", message: nil, preferredStyle: .actionSheet)
            let diseasePost = UIAlertAction(title: "불건전 댓글", style: .default){(_) in
                self.reportAlert(CID: CID, PID: 0)
            }
            let adNsalePost = UIAlertAction(title: "광고 및 판매 댓글", style: .default){(_) in
                self.reportAlert(CID: CID, PID: 0)
            }
            let spamPost = UIAlertAction(title: "악성 도배 댓글", style: .default){(_) in
                self.reportAlert(CID: CID, PID: 0)
            }
            let swearPost = UIAlertAction(title: "욕설 및 비하 댓글", style: .default){(_) in
                self.reportAlert(CID: CID, PID: 0)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            reportAlert.addAction(diseasePost)
            reportAlert.addAction(adNsalePost)
            reportAlert.addAction(spamPost)
            reportAlert.addAction(swearPost)
            reportAlert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(reportAlert, animated: true)
            }
        }
        let writeComment = UIAlertAction(title: "대댓글 작성", style: .default){(_) in
            self.replyCommentType = 0
            self.replyparentID = CID
            self.section = section
            self.tableViewfooterHeight = 50
            self.getBoardTextDetailData()
        }
        
        alert.addAction(cancel)
        alert.addAction(report)
        
        alert.addAction(writeComment)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
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
    private func setCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 150)  //cellsize
        flowLayout.minimumLineSpacing = 4.0
        self.ImageCollectionView?.collectionViewLayout = flowLayout
        self.ImageCollectionView?.showsHorizontalScrollIndicator = false
        self.ImageCollectionView?.dataSource = self
        self.ImageCollectionView?.delegate = self
    }
    @objc func likeComment(_ sender : UIButton){
        let CommentCID : Int = (sender as! CommentLikeButton).CoomentCID
        CommunityPostAPI.shared.LikeCommunityComment(CommunityBoardNumber: self.boardTypeNumber, CID: CommentCID){ success, data in
            if success {
                print("좋아요 성공")
            }else {
                print("실패")
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.getBoardTextDetailData()
        })
        
    }
}

extension BoardTextDetailViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section !=  self.writeTextDetailcommentData.count+1{
            self.replyCommentFooterView = UIView(frame: CGRect(x: 25, y: 10, width: self.bookDetailCommentTableView.frame.width, height: 35))
            self.replytextField = UITextField(frame: CGRect(x: 30, y: 10, width: self.bookDetailCommentTableView.frame.width-100, height: 30))
            self.writeReplyButton = UIButton(frame:CGRect(x: self.bookDetailCommentTableView.frame.width-70, y: 10, width: 50, height: 30))
            //            textView.delegate = self
            //            textView.text = "내용을 입력해주세요"
            self.replytextField.placeholder = "내용을 입력해주세요"
            self.replytextField.layer.borderWidth = 2
            self.replytextField.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
            self.replytextField.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
            self.replytextField.layer.cornerRadius = 8
            self.replytextField.clearButtonMode = .whileEditing
            if self.replyCommentType == 0 {
                self.writeReplyButton.setTitle("대댓글 달기", for: .normal)
            }else if self.replyCommentType == 1{
                self.writeReplyButton.setTitle("대댓글 수정", for: .normal)
            }
            
            self.writeReplyButton.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            self.writeReplyButton.tintColor = .white
            self.writeReplyButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            self.writeReplyButton.layer.borderWidth = 1
            self.writeReplyButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            self.writeReplyButton.layer.cornerRadius = 15
            self.replytextField.addTarget(self, action: #selector(replyCommentText), for: .editingChanged)
            self.writeReplyButton.addTarget(self, action: #selector(tapWriteReplyComment), for: .touchUpInside)
            
            self.replyCommentFooterView.addSubview(self.replytextField)
            self.replyCommentFooterView.addSubview(self.writeReplyButton)
            return self.replyCommentFooterView
        }
        return self.CommentFooterView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.section == section {
            return self.tableViewfooterHeight
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommentHeaderid") as! CommentHeaderTableViewCell
        headerView.userNameLabel.text = self.writeTextDetailcommentData[section].nickname
        headerView.contentsLabel.text = self.writeTextDetailcommentData[section].comment
        headerView.createDateLabel.text = self.writeTextDetailcommentData[section].updateAt
        self.commentisLiked = self.writeTextDetailcommentData[section].isLiked
        let likeCnt = self.writeTextDetailcommentData[section].like?.count ?? 0
        headerView.likeCntButton.setTitle("공감(\(likeCnt))", for: .normal)
        headerView.likeCntButton.addTarget(self, action: #selector(likeComment), for: .touchUpInside)
        headerView.likeCntButton.CoomentCID = self.writeTextDetailcommentData[section].CID
        if self.commentisLiked == true{
            headerView.likeCntButton.tintColor = UIColor(named: "PrimaryBlueColor")
        }else {
            headerView.likeCntButton.tintColor = UIColor.gray
        }
        headerView.layer.addBorder([.top], color: UIColor(named: "lightGrayColor") ?? UIColor.gray, width : 1)
        headerView.addFunctionButton.section = section
        headerView.addFunctionButton.contents = self.writeTextDetailcommentData[section].comment
        headerView.addFunctionButton.CID = self.writeTextDetailcommentData[section].CID
        headerView.addFunctionButton.isAccessible = self.writeTextDetailcommentData[section].isAccessible
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
        guard let replycell  = bookDetailCommentTableView.dequeueReusableCell(withIdentifier: "BoardTextCommentReplyTableViewCellid", for: indexPath)as? CommunityReplyCommentTableViewCell else {return UITableViewCell()}
        replycell.setComment(model: (self.writeTextDetailcommentData[indexPath.section].childComment?[indexPath.row])!)
        replycell.addbuttonAction = {
            self.replycommentisAccessible = replycell.isAccessible
            self.ReplyCellCID = replycell.CID
            self.replyCommentContents = replycell.replyContents
            self.replyCommentActionsheet()
            self.section = indexPath.section
        }
        replycell.likebuttonAction = {
            CommunityPostAPI.shared.LikeCommunityComment(CommunityBoardNumber: self.boardTypeNumber, CID: replycell.CID){ success, data in
                if success {
                    print("좋아요 성공")
                }else {
                    print("실패")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                self.getBoardTextDetailData()
            })
            
        }
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
extension BoardTextDetailViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardTextDetailid", for: indexPath) as? BoardTextDetailImageCollectionViewCell else {return UICollectionViewCell()}
        cell.setImageArray(model: self.ImageArray[indexPath.row])
        if cell.UIImage != nil {
            self.updateImageArray.append(cell.UIImage)
        }
        return cell
    }
    
}
