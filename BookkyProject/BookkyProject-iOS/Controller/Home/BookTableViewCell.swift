//
//  BookTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import UIKit
protocol BookCollectionViewCellDeleGate : AnyObject {
    func collectionView(collectionviewcell: BookCollectionViewCell?, index: Int, didTappedInTableViewCell: BookTableViewCell)

}
class BookTableViewCell: UITableViewCell {
    
    let screenHeight = UIScreen.main.bounds.height
    weak var cellDelegate : BookCollectionViewCellDeleGate?
    @IBOutlet weak var bookTableViewCell: UIView!
   
    @IBOutlet weak var tagNameButton: UIButton!
    @IBOutlet weak var bookCollectionView: UICollectionView!
    var bookDataLsit : [BookData] = []
    func setBookInformation(model : BookList){
        tagNameButton.setTitle(model.tag, for:.normal)
        bookDataLsit = model.data
        bookCollectionView.reloadData()
    }
//    var bookList = BookData()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionVieCell()
        self.tagNameButton.backgroundColor = UIColor(named: "primaryColor")
        self.tagNameButton.tintColor = UIColor.white
        self.tagNameButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        self.bookTableViewCell.backgroundColor = UIColor(named: "primaryColor")
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func setCollectionVieCell() {
        self.bookCollectionView.backgroundColor = UIColor(named: "primaryColor")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: screenHeight*(1/4)*(11/14))  //cellsize
        flowLayout.minimumLineSpacing = 4.0
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
        return bookDataLsit.count
        //        print("\(bookList.object[section].book.count)")
        //        return bookList.object[section].book.count
        
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell :BookCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionViewCellid", for: indexPath) as? BookCollectionViewCell else {return UICollectionViewCell()}
        cell.setBookData(model: bookDataLsit[indexPath.row])
        
        //        cell.bookNameLabel.text = bookList.object[indexPath.section].book[indexPath.row].bookName
        //        cell.bookImageView.image = UIImage(named: "\(self.bookList.object[indexPath.row].book[indexPath.row].bookImage)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    
}
