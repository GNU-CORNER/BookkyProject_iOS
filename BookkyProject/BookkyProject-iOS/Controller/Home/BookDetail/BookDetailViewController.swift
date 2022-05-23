//
//  BookDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/12.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet var bookDetailView: UIView!
    @IBOutlet weak var detailBookName: UILabel!
    @IBOutlet weak var detailBookAuthor: UILabel!
    @IBOutlet weak var detailBookTagListCollectionView: UICollectionView!
    
    //    @IBOutlet weak var detailBookTagListView: UICollectionView!
    @IBOutlet weak var bookDetailImage: UIImageView!
    var BID = 0
    //    let
    
    var bookDetailTagList : [BookDetailDataTagData] = []
    //네이버
    var bookDetailRevieList  : [ReviewData] = []
    var bookImage : URL?  = nil
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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //리뷰 테이블뷰
        self.bookDetailCommentTableView.delegate = self
        self.bookDetailCommentTableView.dataSource = self
        getBookDetailReViewData()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.setBookDetailUI()
        self.getBookDetailData()
        self.setColletioView()
        
        
        
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
    private func setAddMoreButtonUI(){
        
    }
    private func getBookDetailData(){
        
        GetBookData.shared.getDetailBookData(BID: self.BID){ (sucess,data) in
            if sucess {
                guard let bookDetailData = data as? BookDetailInformation else {return}
                
                let DetailData = bookDetailData.result.bookList
                if bookDetailData.success{
                    DispatchQueue.main.async {
                        self.setBookDetailData(model: DetailData)
                        self.detailBookTagListCollectionView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
    private func getBookDetailReViewData(){
        GetBookData.shared.getBookDetailReviewData(BID: self.BID) { (success,data) in
            if success {
                guard let bookDetailReviewData = data as? BookDetailReviewInformation else {return}
                self.bookDetailRevieList = bookDetailReviewData.result.reviewList
                if bookDetailReviewData.success{
                    DispatchQueue.main.async {
                        self.bookDetailCommentTableView.reloadData()
                    }
                }else {
                    print("통신오류")
                }
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
        let url = URL(string: "\(model.thumbnailImage)")
        let data = try! Data(contentsOf: url!)
        bookDetailImage.image = UIImage(data: data)
        self.detailBookName.text = model.TITLE
        self.detailBookAuthor.text = model.AUTHOR
        self.bookDetailTagList = model.tagData
        
        self.bookImage = URL(string: "\(model.thumbnailImage)")
        self.bookName = model.TITLE
        self.AUTHOR = model.AUTHOR
        
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
        print("\(self.bookExplainContent.frame.height)")
        print("\(self.bookIndexLabel.frame.height)")
        
    }
    @IBAction func tapMoreBookIntroduction(_ sender: UIButton) {
        if bookExplainContent.numberOfLines == 5{
            print("펼쳐보기")
            bookExplainContent.frame.size.height = 100
            bookExplainContent.numberOfLines = 0
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookExplainContent.numberOfLines == 0 {
            print("펼쳐 닫기")
            bookExplainContent.numberOfLines = 5
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기>", for: .normal)
        }
        print("\(self.bookExplainContent.frame.size)")
    }
    
    @IBAction func tapMoreBookIndex(_ sender: UIButton) {
        if bookIndexLabel.numberOfLines == 5{
            bookIndexLabel.numberOfLines = 0
            self.tapViewMoreBookIndex.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookIndexLabel.numberOfLines == 0 {
            bookIndexLabel.numberOfLines = 5
            self.tapViewMoreBookIndex.setTitle("펼쳐보기>", for: .normal)
        }
        print("\(self.bookIndexLabel.frame.size)")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "writeReViewSegue" {
            let BookWriteReViewViewController = segue.destination as! BookWriteReviewViewController
            BookWriteReViewViewController.url = self.bookImage
            BookWriteReViewViewController.bookName = self.bookName
            BookWriteReViewViewController.bookAuthor = self.AUTHOR
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
        return self.bookDetailRevieList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : BookDetailReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "bookDetailCommentTableViewcellid")as? BookDetailReviewTableViewCell else {return UITableViewCell()}
        cell.setReview(model : self.bookDetailRevieList[indexPath.row])
        return cell
    }
}
