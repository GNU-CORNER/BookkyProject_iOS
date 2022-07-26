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
    @IBOutlet weak var bookViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAPLabel: UILabel!
    @IBOutlet weak var selectBookView: UIView!
    @IBOutlet weak var QnAPostDetailView: UIView!
    var bookdata : QnAPostDetailBookData?
    var comentBookData : CommentBookData?
    var PID : Int = 0
    var BID : Int = 0
    var PostisLiked : Bool = false
    var boardTypeNumber : Int = 0
    var QnAReplyData : [WriteTextDetailQnAReplyData] = []
    var updateImageArray : [UIImage] = []
    var isAccessible : Bool = false //사용자의 글인지 아닌지 확인
    var ImageArray : [String] = []
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
        setCollectionViewCell()
        setBookViewUI()
        print("\(self.PID)test")
        self.navigationItem.rightBarButtonItem = self.rightButton
        
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
            let update = UIAlertAction(title: "글 수정", style: .default){(_)in
                let CommunityStoryboard: UIStoryboard = UIStoryboard(name: "Community", bundle: nil)
                guard let UpdatePostviewController = CommunityStoryboard.instantiateViewController(withIdentifier: "UpdatePostViewController") as? UpdatePostViewController
                else {return}
                UpdatePostviewController.titleString = self.QnATitleLabel.text ?? ""
                UpdatePostviewController.contentsString = self.QnAContentsLabel.text ?? ""
                UpdatePostviewController.BID = self.BID
                UpdatePostviewController.PID = self.PID
                UpdatePostviewController.QnABookData = self.bookdata
                
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
    override func viewWillAppear(_ animated: Bool) {
        getBoardTextDetailQnAData()
        self.updateImageArray = []
    }
    func setTableViewCell(){
        self.QnATableView.dataSource = self
        self.QnATableView.delegate = self
        let cellNib = UINib(nibName: "QnaAnswerTableViewCell", bundle: nil)
        self.QnATableView.register(cellNib, forCellReuseIdentifier: "QnaAnswerTableViewCellid")
        
    }
    func setBookViewUI(){
        self.bookNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.bookAPLabel.font = UIFont.systemFont(ofSize: 12)
        self.selectBookView.layer.borderWidth = 2
        self.selectBookView.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
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
        let textCount = self.QnAContentsLabel.text?.count ?? 0
        
        if self.bookdata?.TITLE == nil && self.ImageArray == [] {
            self.QnAPostDetailView.frame.size.height = 200+CGFloat((textCount/60)*20)
        }else if self.bookdata?.TITLE == nil || self.ImageArray == [] {
            self.QnAPostDetailView.frame.size.height = 320+CGFloat((textCount/60)*20)
        }else {
            self.QnAPostDetailView.frame.size.height = 460+CGFloat((textCount/60)*20)
        }
        
    }
    private func setReplyNComment(model : WriteTextDetailQnAInformation){
        self.CommetButton.setTitle("댓글(\(model.result.commentCnt ?? 0))", for: .normal)
        self.answerLabel.text = "답변(\(model.result.replyCnt))"
    }
    private func setBookView(model : QnAPostDetailBookData ){
        if let url = URL(string: model.thumbnailImage ?? "") {
            self.bookImageView.load(url: url)
        }
        self.bookNameLabel.text = model.TITLE
        let Author = model.AUTHOR ?? ""
        let PUBLISHER = model.PUBLISHER ?? ""
        self.bookAPLabel.text = "\(Author)/\(PUBLISHER)"
        
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
                self.bookdata = communityGetDetailList.result.Book
                
                self.BID = self.bookdata?.TBID ?? 0
                self.ImageArray = writeTextDetailQnAData.postImage ?? []
                self.PostisLiked = writeTextDetailQnAData.isLiked
                
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
extension QnABoardTextDetailViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardTextDetailid", for: indexPath) as? BoardTextDetailImageCollectionViewCell else {return UICollectionViewCell()}
        cell.setImageArray(model: self.ImageArray[indexPath.row])
        self.updateImageArray.append(cell.UIImage)
        
        
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
