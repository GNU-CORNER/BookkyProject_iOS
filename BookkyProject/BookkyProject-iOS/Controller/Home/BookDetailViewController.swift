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
    let bookDetailURl = "http://app.bookky.org:8002/v1/books/"
    
    var bookDetailTagList : [String] = []
    //네이버
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.setBookDetailUI()
        self.getBookDetailData()
        self.setColletioView()
        self.bookInformationLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.bookExplainTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.indexTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.reviewTitleLabel.layer.addBorder([.bottom], color: UIColor(named: "primaryColor") ?? UIColor.blue, width : 2.5)
        self.naverGoButton.backgroundColor = UIColor(red: 3/255, green: 199/255, blue: 107/255, alpha: 1)
        
        self.bookExplainContent.font =  UIFont.systemFont(ofSize: 12)
        self.bookIndexLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.bookExplainContent.numberOfLines = 4
        self.bookIndexLabel.numberOfLines = 4
       
        
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
        self.bookDetailTagList = model.tagName
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
        
        
    }
    
    private func setBookDetailUI(){
        self.detailBookName.font = UIFont.boldSystemFont(ofSize: 18)
        self.detailBookAuthor.font = UIFont.systemFont(ofSize: 13)
    }
    private func getBookDetailData(){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: bookDetailURl+"\(BID)") else{
            print("Error: Cannot Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let bookDetailData = try JSONDecoder().decode(BookDetailInformation.self, from: data)
                let bookDeatilData = bookDetailData.result.bookList
                DispatchQueue.main.async {
                    self.setBookDetailData(model: bookDeatilData)
                    self.detailBookTagListCollectionView.reloadData()
                }
                debugPrint("\(bookDetailData)")
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    
    @IBAction func tapMoreBookIntroduction(_ sender: UIButton) {
        if bookExplainContent.numberOfLines == 4{
            bookExplainContent.numberOfLines = 0
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookExplainContent.numberOfLines == 0 {
            bookExplainContent.numberOfLines = 4
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기>", for: .normal)
        }
        
        
    }
    
    @IBAction func tapMoreBookIndex(_ sender: UIButton) {
        if bookIndexLabel.numberOfLines == 4{
            bookIndexLabel.numberOfLines = 0
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기 닫기>", for: .normal)
        }else if bookIndexLabel.numberOfLines == 0 {
            bookIndexLabel.numberOfLines = 4
            self.tapViewMoreBookIntroduction.setTitle("펼쳐보기>", for: .normal)
        }
    }
}
extension BookDetailViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.bookDetailTagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailTagCollectionViewCellid", for: indexPath) as? BookDetailTagCollectionViewCell else {return UICollectionViewCell()}
        cell.tagNameLabel.text = "# "+self.bookDetailTagList[indexPath.row]
        
        return cell
    }
    
}
extension BookDetailViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailTagCollectionViewCellid", for: indexPath) as? BookDetailTagCollectionViewCell else {
            return .zero
        }
        cell.tagNameLabel.text = self.bookDetailTagList[indexPath.row]
        cell.tagNameLabel.sizeToFit()
        
        let cellWidth = cell.tagNameLabel.frame.width + 25
        
        return CGSize(width: cellWidth, height: 30)
    }
}
