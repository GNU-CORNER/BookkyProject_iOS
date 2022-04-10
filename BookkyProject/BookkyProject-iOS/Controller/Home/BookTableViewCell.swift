//
//  BookTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import UIKit

class BookTableViewCell: UITableViewCell {


    @IBOutlet weak var bookTableViewCell: UIView!
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    var bookDataLsit : [BookData] = []
    func setBookInformation(model : BookList){
        tagNameLabel.text = model.tag
        bookDataLsit = model.data
        bookCollectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionVieCell()
        self.bookTableViewCell.backgroundColor = UIColor(named: "primaryColor")
       
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }
    private func setCollectionVieCell() {
        self.bookCollectionView.backgroundColor = UIColor(named: "primaryColor")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 150)  //cellsize
        flowLayout.minimumLineSpacing = 2.0
        self.bookCollectionView?.collectionViewLayout = flowLayout
        self.bookCollectionView?.showsHorizontalScrollIndicator = false
        self.bookCollectionView?.dataSource = self
        self.bookCollectionView?.delegate = self
        let cellNib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        self.bookCollectionView?.register(cellNib, forCellWithReuseIdentifier: "bookCollectionViewCellid")
    }

}
extension BookTableViewCell :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(bookDataLsit.count)")
        return bookDataLsit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell :BookCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionViewCellid", for: indexPath) as? BookCollectionViewCell else {return UICollectionViewCell()}
        cell.setBookData(model: bookDataLsit[indexPath.row])
//        cell.bookNameLabel.text = bookList.object[indexPath.section].book[indexPath.row].bookName
//        cell.bookImageView.image = UIImage(named: "\(bookList.object[indexPath.section].book[indexPath.row].bookImage)")
        return cell
    }
    
    
}
