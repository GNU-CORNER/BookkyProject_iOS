//
//  UpdatePostViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/05.
//

import UIKit

class UpdatePostViewController: UIViewController,SelectUpdateVCSendData{
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAPLabel: UILabel!
    @IBOutlet weak var bookCancelButton: UIButton!
    @IBOutlet weak var selectBookView: UIView!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var updatePostButton: AutoAddPaddingButtton!
    @IBOutlet weak var selectBookViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ImageCollectionVIewHeight: NSLayoutConstraint!
    var titleString : String = ""
    var contentsString : String = ""
    var boardTypeNumber : Int = 0
    var imageArray : [UIImage] = []
    var bookViewHeight : Int = 0
    var BID : Int = 0
    var PID : Int = 0
    var bookName : String = ""
    var bookAP : String = "" //저자 출판사
    var bookImgstring : String = ""
    var imgString : String = ""
    var bookImage : UIImageView!
    var UserImage : UIImageView!
    var bookData : PostDetailBookData?
    var QnABookData : QnAPostDetailBookData?
    @IBOutlet weak var bookSearchnAddButton: UIButton!
    @IBOutlet weak var updateStackView: UIStackView!
    @IBOutlet weak var ImageAddButton: UIButton!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdateTitleTextField()
        setWriteContentsTextView()
        selectBookUI()
        setUpdateTextButtonUI()
        setStackViewSpacing()
        setCollectionViewCell()
        SetPostData()
        self.keyboardDown()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.imageArray = []
    }
    private func SetPostData(){
        if self.BID == 0 {
            self.selectBookViewHeight.constant = 0
        }else {
            if self.boardTypeNumber == 2{
                if let url = URL(string: self.QnABookData?.thumbnailImage ?? "") {
                    self.bookImageView.load(url: url)
                    self.bookNameLabel.text = self.QnABookData?.TITLE
                    self.bookAPLabel.text = "\(self.QnABookData?.AUTHOR ?? "")/\(self.QnABookData?.PUBLISHER ?? ""))"
                }
            }else {
                if let url = URL(string: self.bookData?.thumbnailImage ?? "") {
                    self.bookImageView.load(url: url)
                    self.bookNameLabel.text = self.bookData?.TITLE
                    self.bookAPLabel.text = "\(self.bookData?.AUTHOR ?? "")/\(self.bookData?.PUBLISHER ?? ""))"
                }
            }
            
        }
        if self.imageArray == []{
            self.ImageCollectionVIewHeight.constant = 0
        }
    }
    //화면터치시내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    private func setUpdateTitleTextField(){
        titleTextField.text = self.titleString
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        
    }
    private func setWriteContentsTextView() {
//        contentsTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        contentsTextView.text = self.contentsString
//        contentsTextView.textColor = UIColor.lightGray
        contentsTextView.layer.borderWidth = 2
        contentsTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        contentsTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
    }
    func selectBookUI(){
        self.bookNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.bookAPLabel.font = UIFont.systemFont(ofSize: 12)
        self.selectBookView.layer.borderWidth = 2
        self.selectBookView.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
    }
    private func setUpdateTextButtonUI(){
        updatePostButton.tintColor = .white
        updatePostButton.layer.borderWidth = 2
        updatePostButton.layer.cornerRadius = 15
        updatePostButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        updatePostButton.backgroundColor = UIColor(named: "primaryColor")
    }
    func setStackViewSpacing(){
        updateStackView.setCustomSpacing(10, after: bookSearchnAddButton)
        updateStackView.setCustomSpacing(200, after: ImageAddButton)
    }
    private func setCollectionViewCell() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 150)  //cellsize
        flowLayout.minimumLineSpacing = 4.0
        self.ImageCollectionView?.collectionViewLayout = flowLayout
        self.ImageCollectionView?.showsHorizontalScrollIndicator = false
        self.ImageCollectionView?.dataSource = self
        self.ImageCollectionView?.delegate = self
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "updateGoSearchView" {
        guard let writePostBookSearchVC : WritePostBookSearchViewController = segue.destination as? WritePostBookSearchViewController else {return}
        writePostBookSearchVC.updateDelegate = self
        }
    }
    func sendData(ImageString:String,bookName: String ,bookAuthorPublisher : String,height : Int,BID:Int){
        self.bookNameLabel.text = bookName
        self.bookAPLabel.text = bookAuthorPublisher
        self.BID = BID
        
        if let url = URL(string: ImageString) {
            self.bookImageView.load(url: url)
        }
        
        self.selectBookViewHeight.constant = CGFloat(height)
    }
    @IBAction func tapDeleteSelectBook(_ sender: UIButton) {
        self.selectBookViewHeight.constant = 0
        self.bookData = nil
        self.QnABookData = nil
        self.BID = 0
    }
    @objc func deleteImg(_ sender : UIButton){
        let row : Int = (sender as! ImageCancelButton).row
        self.imageArray.remove(at: row)
        if self.imageArray.count == 0 {
            self.ImageCollectionVIewHeight.constant = 0
        }
        self.ImageCollectionView.reloadData()
        
    }
    @IBAction func tapUpdatePostButton(_ sender: UIButton) {
        var imgarray : [String] = []
        for i in self.imageArray {
            guard let thumbnail = i.imageToPNGString() else {return}
            let encodedThumbnail = "data:image/png;base64," + thumbnail
            imgarray.append(encodedThumbnail)
        }
        let titleString = self.titleTextField.text ?? ""
        let contentString = self.contentsTextView.text ?? ""
        updatePost(textTitle:titleString, textContent:contentString , CommunityBoardNumber: self.boardTypeNumber, parentQPID: self.PID, TBID: self.BID, thumbnail: imgarray)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.navigationController?.popViewController(animated: true)
        })
      
    }
    @IBAction func tapAddImageButton(_ sender: UIButton) {
        if self.imageArray.count > 4{
            let alert = UIAlertController(title: "사진 추가 최대 5개입니다.", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }else{
            CameraHandler.shared.actionSheetAlert(vc: self)
            
            CameraHandler.shared.imagePickerBlock = { (image) in
                self.imageArray.append(image)
                DispatchQueue.main.async {
                    self.ImageCollectionVIewHeight.constant = 150
                    
                    self.ImageCollectionView.reloadData()
                }
            }
        }
    }
    private func updatePost(textTitle:String,textContent:String,CommunityBoardNumber:Int,parentQPID:Int,TBID:Int,thumbnail:[String]){
        CommunityUpdateAPI.shared.UpdateCommunityWrite(textTitle: textTitle, textContent: textContent, CommunityBoardNumber: CommunityBoardNumber, parentQPID: parentQPID, TBID: TBID, thumbnail: thumbnail) { (success, data) in
            if success {
                print("글 수정 성공")
            }else {
                print("글 수정 실패")
            }
        }
    }
}

extension UpdatePostViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "updateCollectionViewid", for: indexPath) as? UpdateAddImgCollectionViewCell else {return UICollectionViewCell()}
        cell.UserImg.image = self.imageArray[indexPath.row]
        cell.cancelButton.row = indexPath.row
        
        cell.cancelButton.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        return cell
    }

    

}
