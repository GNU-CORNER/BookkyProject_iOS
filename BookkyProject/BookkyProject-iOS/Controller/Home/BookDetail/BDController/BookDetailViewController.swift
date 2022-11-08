//
//  BookDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/12.
//

import UIKit
import Cosmos
class BookDetailViewController: UIViewController {
    @IBOutlet var bookDetailView: UIView!
    @IBOutlet weak var detailBookName: UILabel!
    @IBOutlet weak var detailBookAuthor: UILabel!
    @IBOutlet weak var detailBookTagListCollectionView: UICollectionView!
    @IBOutlet weak var bookDetailImage: UIImageView!
    var BID = 0
    var bookDetailTagList : [BookDetailDataTagData] = []
    //네이버
    var bookDetailRevieList  : [ReviewData] = []
    var bookImage : String = ""
    var bookName : String = ""
    var AUTHOR : String = ""
    @IBOutlet weak var naverGoButton: UIButton!
    //도서정보
    @IBOutlet weak var bookInformationLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookPageLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    //책소개
    @IBOutlet weak var bookExplainTitleLabel: UILabel!
    @IBOutlet weak var bookExplainContent: UILabel!
    
    //목차
    @IBOutlet weak var indexTitleLabel: UILabel!
    @IBOutlet weak var bookIndexLabel: UILabel!
    
    //리뷰
    @IBOutlet weak var reviewTitleLabel: UILabel!
    //펼쳐보기 버튼
    @IBOutlet weak var tapViewMoreBookIntroduction: UIButton!
    @IBOutlet weak var tapViewMoreBookIndex: UIButton!
    //리뷰 테이블뷰
    @IBOutlet weak var bookDetailCommentTableView: UITableView!
    @IBOutlet weak var bookDetailScrollView: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    var userContents : String = ""
    
    // 관심도서 설정
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    //별점뷰
    @IBOutlet weak var starRatingView: CosmosView!
    //리뷰데이터 유무
    var reviewDataOk : Bool = false
    var accessToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //리뷰 테이블뷰
        self.indicatorView.startAnimating()
        bookDetailCommentTableView.delegate = self
        bookDetailCommentTableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.black
        starViewUI()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        setBookDetailUI()
        setColletioView()
        registerNoReviewcell()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setView()
        
    }
    public func setView(){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("MyProfile: 사용자 이메일을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        guard let acessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("MyProfile: 토큰을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        self.accessToken = acessToken
        getBookDetailReViewData(accessToken:acessToken)
        getBookDetailData(accessToken: acessToken)
    }
//MARk: - NoReviewCell
    func registerNoReviewcell(){
        let cellNib = UINib(nibName: "NoReviewTableViewCell", bundle: nil)
        self.bookDetailCommentTableView.register(cellNib, forCellReuseIdentifier: "NoReviewTableViewCellid")
    }
//MARK: - starUI
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        
        starRatingView.rating = newRatingValue
    }
    func starViewUI(){
        starRatingView.settings.fillMode = .precise
    }

    private func setBookDetailUI(){
        self.detailBookName.font = UIFont.boldSystemFont(ofSize: 18)
        self.detailBookAuthor.font = UIFont.systemFont(ofSize: 13)
        
        //Label Bottom Line
        self.bookInformationLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.bookExplainTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.indexTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.reviewTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        //네이버 버튼 수정 필요
        self.naverGoButton.backgroundColor = UIColor(red: 3/255, green: 199/255, blue: 107/255, alpha: 1)
        self.bookExplainContent.font =  UIFont.systemFont(ofSize: 12)
        self.bookIndexLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.bookExplainContent.numberOfLines = 5
        self.bookIndexLabel.numberOfLines = 5
        self.tapViewMoreBookIntroduction.setTitle("펼쳐보기 >", for: .normal)
        self.tapViewMoreBookIntroduction.tintColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.tapViewMoreBookIntroduction.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.tapViewMoreBookIndex.setTitle("펼쳐보기 >", for: .normal)
        self.tapViewMoreBookIndex.tintColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
        self.tapViewMoreBookIndex.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
    }
// MARK: - API 통신
    private func getBookDetailData(accessToken : String){
        GetBookData.shared.getDetailBookData(BID: self.BID,accessToken: accessToken){ (sucess,data,statusCode) in
            guard let bookDetailData = data as? BookDetailInformation else {return}
            if sucess {
                let DetailData = (bookDetailData.result?.bookList)!
                let favorite = (bookDetailData.result?.isFavorite)!
                if bookDetailData.success{
                    DispatchQueue.main.async {
                        self.bookDetailScrollView.isHidden = false
                        self.indicatorView.isHidden = true
                        self.indicatorView.stopAnimating()
                        self.setBookDetailData(model: DetailData)
                        self.navigationItem.rightBarButtonItem = self.favoriteButton
                        if favorite == true{
                            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
                            self.favoriteButton.image = UIImage(systemName: "heart.fill")
                        }else {
                            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
                            self.favoriteButton.image = UIImage(systemName: "heart")
                        }
                        self.detailBookTagListCollectionView.reloadData()
                        
                    }
                }
            }else {
                if let errMessage = bookDetailData.errorMessage{
                    print("Home request fasle:\(errMessage)")
                }
                print("request Home: false")
                if statusCode == 401 {
                    // 새로 AT 갱신할 것.
                    // 만료된 토큰입니다. RefreshToken의 기간이 지남
                    print(statusCode)
                    if let errorMessage = bookDetailData.errorMessage {
                        print("request Book false의 이유: \(errorMessage)")
                    }

                    guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                        print("사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                print("getAT")
                                self.getBookDetailData(accessToken: newAccessToken)
                            }
                        } else {
                            print(statuscode)
                            if statuscode == 400 {
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print(tokens.errorMessage)
                            } else if statuscode == 401 {
                                // 만료된 토큰입니다.
                                print(tokens.errorMessage)
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.loginView(previousView: self)
                            }
                        }
                    }
                    
                }
                
           
            }
        }
    }
    
    private func getBookDetailReViewData(accessToken:String){
        GetBookData.shared.getBookDetailReviewData(BID: self.BID,accessToken: accessToken) { (success,data,statusCode) in
            guard let bookDetailReviewData = data as? BookDetailReviewInformation else {return}
            if success {
                self.reviewDataOk = true
                self.bookDetailRevieList = (bookDetailReviewData.result?.reviewList)!
                let tableViewCellCount = self.bookDetailRevieList.count
                if bookDetailReviewData.success{
                    DispatchQueue.main.async {
                        self.bookDetailScrollView.isHidden = false
                        self.indicatorView.isHidden = true
                        self.indicatorView.stopAnimating()
                        if self.bookDetailRevieList.count != 0{
                            self.tableViewHeight.constant = CGFloat(100*tableViewCellCount)
                        }else {
                            self.tableViewHeight.constant = 100
                        }
                        self.bookDetailCommentTableView.reloadData()
                    }
                }else {
                    print("통신오류")
                }
            }else {
                if let errMessage = bookDetailReviewData.errorMessage{
                    print("Home request fasle:\(errMessage)")
                }
                print("request Home: false")
                if statusCode == 401 {
                    // 새로 AT 갱신할 것.
                    // 만료된 토큰입니다. RefreshToken의 기간이 지남
                    print(statusCode)
                    if let errorMessage = bookDetailReviewData.errorMessage {
                        print("request Book false의 이유: \(errorMessage)")
                    }

                    guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                        print("사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                print("getAT")
                                self.getBookDetailReViewData(accessToken: newAccessToken)
                            }
                        } else {
                            print(statuscode)
                            if statuscode == 400 {
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print(tokens.errorMessage)
                            } else if statuscode == 401 {
                                // 만료된 토큰입니다.
                                print(tokens.errorMessage)
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.loginView(previousView: self)
                            }
                        }
                    }
                    
                }
                
           
            }
        }
    }
    
    
    private func deleteBookDetailReviewData(RID : Int){
        HomeReviewDeleteAPI.shared.DeletPost(RID : RID) { (success,data) in
            if success {
                print("리뷰가 성공적으로 삭제 되었습니다.")
            }else {
                self.errorNetWork()
            }
        }
    }

    private func likeReviewUpdate(RID : Int){
        HomePostDataAPI.shared.updateHomeReviewLike(RID: RID) { (success,data) in
            if success {
                print("좋아요 성공")
            }else {
                self.errorNetWork()
            }
        }
    }
    private func tapFavoriteBook(BID : Int) {
        HomePostDataAPI.shared.favoriteBook(BID: BID) { (success,data) in
            if success {
                print("좋아요 성공")
            }else {
                self.errorNetWork()
            }
        }
    }

    private func setColletioView(){
        self.detailBookTagListCollectionView.delegate = self
        self.detailBookTagListCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 1.0
        self.detailBookTagListCollectionView?.collectionViewLayout = flowLayout
        self.detailBookTagListCollectionView?.showsHorizontalScrollIndicator = false
    }
    private func setBookDetailData(model:BookDetailData){
    
        if let url = URL(string: model.thumbnailImage) {
            self.bookDetailImage.load(url: url)
        }
        self.detailBookName.text = model.TITLE
        self.detailBookAuthor.text = model.AUTHOR
        self.bookDetailTagList = model.tagData
        
        
        self.bookImage = model.thumbnailImage
        self.bookName = model.TITLE
        self.AUTHOR = model.AUTHOR
        updateRating(model.RATING)
        starRatingView.text = "\(model.RATING)"
        self.publisherLabel.text = "출판사 : " + model.PUBLISHER
        self.authorLabel.text = "저자 : " + model.AUTHOR
        self.priceLabel.text = "정가 : " + model.PRICE
        self.bookPageLabel.text = "페이지 : " + model.PAGE
        self.ISBNLabel.text = "ISBN : " + model.ISBN
        var bookExplainString : String = ""
        if let bookExplain = model.BOOK_INTRODUCTION?.split(separator: "^") {
            for i in bookExplain {
                bookExplainString+="\n"+i
            }
        }
        
        self.bookExplainContent.text = bookExplainString
        let bookIndex = model.BOOK_INDEX.split(separator: "^")
        var bookIndexString : String = ""
        
        for i in bookIndex {
            bookIndexString+="\n"+i
        }
        
        self.bookIndexLabel.text = bookIndexString
        self.bookExplainContent.frame.size.height = 150
        self.bookIndexLabel.frame.size.height = 150
        
        
    }
    @IBAction func tapMoreBookIntroduction(_ sender: UIButton) {
        if bookExplainContent.numberOfLines == 5{
            bookExplainContent.frame.size.height = 100
            bookExplainContent.numberOfLines = 0
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookExplainContent.numberOfLines == 0 {
            bookExplainContent.numberOfLines = 5
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기>", for: .normal)
        }
    }
    
    @IBAction func tapMoreBookIndex(_ sender: UIButton) {
        if bookIndexLabel.numberOfLines == 5{
            bookIndexLabel.numberOfLines = 0
            self.tapViewMoreBookIndex.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookIndexLabel.numberOfLines == 0 {
            bookIndexLabel.numberOfLines = 5
            self.tapViewMoreBookIndex.setTitle("펼쳐보기>", for: .normal)
        }
    }
    @IBAction func tapFaovorite(_ sender: UIBarButtonItem) {
        self.tapFavoriteBook(BID: self.BID)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.getBookDetailData(accessToken: self.accessToken)
        })
        
    }
    
    
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "writeReViewSegue" {
            let BookWriteReViewViewController = segue.destination as! BookWriteReviewViewController
            BookWriteReViewViewController.url = self.bookImage
            BookWriteReViewViewController.bookName = self.bookName
            BookWriteReViewViewController.bookAuthor = self.AUTHOR
            BookWriteReViewViewController.BID = self.BID
        }
    }
    func completeDelete(){
        let alert = UIAlertController(title: "리뷰가 삭제되었습니다.", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    @objc func tapAddLike(_ sender : Any){
        let RID : Int = (sender as! ReviewButton).RID
        likeReviewUpdate(RID: RID)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.getBookDetailReViewData(accessToken: self.accessToken)
        })
        
    }
    @objc func tapAddReviewFunction(_ sender : Any){
        let RID : Int = (sender as! ReviewButton).RID
        let isAccessible : Bool = (sender as! ReviewButton).isAccessible
        let rating : Double = (sender as! ReviewButton).rating
        let contents : String = (sender as! ReviewButton).contents
        self.userContents = contents
        let alert = UIAlertController(title: "리뷰 메뉴", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let report = UIAlertAction(title: "신고", style: .destructive)
        if isAccessible == true {
            let delete = UIAlertAction(title: "삭제", style: .destructive){(_) in
                self.deleteBookDetailReviewData(RID: RID)
                self.completeDelete()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                    self.getBookDetailReViewData(accessToken: self.accessToken)
                    self.getBookDetailData(accessToken: self.accessToken)
                })
                
                
            }
            let update = UIAlertAction(title: "수정", style: .default){(_) in
                guard let BookUpdateReviewViewController =
                        self.storyboard?.instantiateViewController(identifier: "writeReviewController") as? BookUpdateReviewViewController  else {return}
                BookUpdateReviewViewController.modalPresentationStyle = .fullScreen
                BookUpdateReviewViewController.ratingStar = rating
                BookUpdateReviewViewController.url = self.bookImage
                BookUpdateReviewViewController.bookName = self.bookName
                BookUpdateReviewViewController.bookAuthor = self.AUTHOR
                BookUpdateReviewViewController.RID = RID
                BookUpdateReviewViewController.userContents = self.userContents
                self.present(BookUpdateReviewViewController, animated: true, completion: nil)
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
extension BookDetailViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookDetailTagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailTagCollectionViewCellid", for: indexPath) as? BookDetailTagCollectionViewCell else {return UICollectionViewCell()}
        cell.setTagList(model: bookDetailTagList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath)as? BookDetailTagCollectionViewCell else {return}
        guard let tagViewController = self.storyboard?.instantiateViewController(withIdentifier: "TagViewController")as? TagViewController else {return}
        self.navigationController?.pushViewController(tagViewController, animated: true)
        tagViewController.TID = cell.TID
        
    }
    
}
extension BookDetailViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = detailBookTagListCollectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailTagCollectionViewCellid", for: indexPath) as? BookDetailTagCollectionViewCell else {
            return .zero
        }
        cell.tagNameLabel.text = bookDetailTagList[indexPath.row].tag
        cell.tagNameLabel.sizeToFit()
        let cellWidth = cell.tagNameLabel.frame.width + 20
        return CGSize(width: cellWidth, height: 30)
    }
}
extension BookDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviewDataOk == true{
            return self.bookDetailRevieList.count
        }else{
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if reviewDataOk == true {
            guard let cell : BookDetailReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "bookDetailCommentTableViewcellid")as? BookDetailReviewTableViewCell else {return UITableViewCell()}
            cell.setReview(model : self.bookDetailRevieList[indexPath.row])
            
            cell.reviewAddFunction.RID = cell.RID
            cell.reviewAddFunction.isAccessible = cell.reviewIsAccessible
            cell.reviewAddFunction.rating = cell.rating
            cell.reviewAddFunction.contents = cell.contents
            cell.reviewLikeButton.RID = cell.RID
            cell.reviewLikeButton.addTarget(self, action: #selector(tapAddLike), for: .touchUpInside)
            cell.reviewAddFunction.addTarget(self, action: #selector(tapAddReviewFunction), for: .touchUpInside)
            return cell
        }
        guard let cell : NoReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NoReviewTableViewCellid")as? NoReviewTableViewCell else {return UITableViewCell()}
        return cell
    }
}
