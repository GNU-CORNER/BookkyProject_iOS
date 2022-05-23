//
//  TagViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/30.
//

import UIKit

class TagViewController: UIViewController {
    var TID : Int = 0
    var BID : Int = 0
    @IBOutlet weak var tagCollectionView: UICollectionView!
    var tagBookList : [TagBookData]  = []
    var tagName : String = ""
    var deviceWidth = UIScreen.main.bounds.size.width
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        getTagBookData()
        //        UIApplication.shared.statusBarStyle
        // 13에서 안먹힌다 다른방법 연구
        //
    }
    private func getTagBookData(){
        GetBookData.shared.getTagBookData(TID: self.TID){ (sucess,data) in
            if sucess {
                guard let tagBookData = data as? TagInformation else {return}
                self.tagBookList = tagBookData.result.bookList.data
                self.tagName = tagBookData.result.bookList.tag
                if tagBookData.success{
                    DispatchQueue.main.async {
                        self.tagCollectionView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
    private func setCollectionView(){
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        //        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "primaryColor")
        // 꼭 체킹해줘야함 선언한지안한지
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.delegate = self
        let flowlLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowlLayout.itemSize = CGSize(width: deviceWidth*(1/5), height: 120)
        tagCollectionView.collectionViewLayout = flowlLayout
    }
}
extension TagViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagBookList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell : TagViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewId", for: indexPath) as? TagViewCollectionViewCell else {return UICollectionViewCell()}
        cell.setTagBookList(model: tagBookList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "tagCollectionViewHedaerId", for: indexPath)as! TagCollectionReusableViewHeader
        headerView.tagNameLabel.text = "\(self.tagName)과\n관련된 책이에요!"
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: tagCollectionView.frame.width, height: 110)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tagMoreViewGoBookDetailSegue" {
            let BookDetailViewController = segue.destination as! BookDetailViewController
            BookDetailViewController.BID = self.BID
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath)as? TagViewCollectionViewCell else {return}
        self.BID = cell.BID
        performSegue(withIdentifier: "tagMoreViewGoBookDetailSegue", sender: self)
    }
    
}
extension TagViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //컬렉션뷰 전체 상화좌우 간격
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //cell 위아래 간격
        return 25
    }
}
