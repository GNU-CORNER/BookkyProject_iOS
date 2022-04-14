//
//  BookDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/12.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet var bookDetailView: UIView!
    
    @IBOutlet weak var bookDetailImage: UIImageView!
    @IBOutlet weak var detailBookName: UILabel!
    @IBOutlet weak var detailBookAuthor: UILabel!
    
    @IBOutlet weak var detailBookTagListView: UICollectionView!
    var BID = 0
    let bookDetailURl = "http://app.bookky.org:8002/v1/books/"
    
    var bookDetailTagList : [String] = []
    
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.setBookDetailUI()
        self.getBookDeatilData()
        self.setColletioView()
    }
    private func setColletioView(){
        self.detailBookTagListView.delegate = self
        self.detailBookTagListView.dataSource = self
    
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 80, height: 50)  //cellsize
        flowLayout.minimumLineSpacing = 1.0
        self.detailBookTagListView?.collectionViewLayout = flowLayout
        self.detailBookTagListView?.showsHorizontalScrollIndicator = false
    }
    private func setBookDetailData(model:BookDetailData){
        let url = URL(string: "\(model.thumbnailImage)")
        let data = try! Data(contentsOf: url!)
        bookDetailImage.image = UIImage(data: data)
        self.detailBookName.text = model.TITLE
        self.detailBookAuthor.text = model.AUTHOR
        self.bookDetailTagList = model.tagName
        print("\(bookDetailTagList)")
    }
    
    private func setBookDetailUI(){
        self.detailBookName.font = UIFont.boldSystemFont(ofSize: 18)
        self.detailBookAuthor.font = UIFont.systemFont(ofSize: 13)
    }
    private func getBookDeatilData(){
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
                    self.detailBookTagListView.reloadData()
                }
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
}
extension BookDetailViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.bookDetailTagList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookDetailTagCollectionViewCellid", for: indexPath) as? BookDetailTagCollectionViewCell else {return UICollectionViewCell()}
        cell.tagNameLabel.text = self.bookDetailTagList[indexPath.row]
        return cell
    }
    
}
