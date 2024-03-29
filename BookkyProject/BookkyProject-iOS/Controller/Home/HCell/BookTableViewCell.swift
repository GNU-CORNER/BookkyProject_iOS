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
    
    var TID : Int = 0
    
    weak var cellDelegate : BookCollectionViewCellDeleGate?
    
    @IBOutlet weak var bookTableViewCell: UIView!
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    var ViewControllernumber : Int = 0
    var bookDataList : [BookData] = []
    var tagMoreViewDataList : [TagMoreViewBookData] = []
    func setBookInformation(model : BookList){
        tagNameLabel.text = model.tag
        bookDataList = model.data
        self.TID = model.TMID ?? 0
        bookCollectionView.reloadData()
        self.ViewControllernumber = 0
    }
    func setTagMoreViewInformation(model : TagmoreViewBookList){
        tagNameLabel.text = model.tag
        tagMoreViewDataList = model.data
        self.TID = model.TMID ?? 0
        bookCollectionView.reloadData()
        self.ViewControllernumber = 1
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionViewCell()
        self.tagNameLabel.textColor = UIColor.white
        self.tagNameLabel.font = UIFont.systemFont(ofSize: 18)
        self.bookTableViewCell.backgroundColor = UIColor(named: "primaryColor")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    private func setCollectionViewCell() {
        self.bookCollectionView.backgroundColor = UIColor(named: "primaryColor")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120, height: 180)  //cellsize
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
        if self.ViewControllernumber == 0{
            return bookDataList.count
        }else if self.ViewControllernumber == 1 {
            return tagMoreViewDataList.count
        }else{
            return bookDataList.count
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell :BookCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCollectionViewCellid", for: indexPath) as? BookCollectionViewCell else {return UICollectionViewCell()}
        DispatchQueue.main.async {
            if self.ViewControllernumber == 0 {
                cell.setBookData(model: self.bookDataList[indexPath.row])
            }else if self.ViewControllernumber == 1{
                cell.setTagMoreViewBookData(model: self.tagMoreViewDataList[indexPath.row])
            }
        }
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.ViewControllernumber == 0 {
            let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }else if self.ViewControllernumber == 1{
            let cell = collectionView.cellForItem(at: indexPath) as? BookCollectionViewCell
            self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        }
        
        
    }
    
    
}
