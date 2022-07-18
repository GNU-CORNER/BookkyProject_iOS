//
//  QnAWriteAnswerViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/17.
//

import UIKit
// MARK: - Q&A 답변쓰기 컨트롤러
class QnAWriteAnswerViewController: UIViewController,SelectSendData {
    
    
    @IBOutlet weak var writeContentsTextView: UITextView!
    @IBOutlet weak var writePostButton: AutoAddPaddingButtton!
    @IBOutlet weak var addBookButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var ImageCollectionView: UICollectionView!
    @IBOutlet weak var ImgCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectBookViewHeight: NSLayoutConstraint!
    @IBOutlet weak var BookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAPLabel: UILabel!
    @IBOutlet weak var selectBookView: UIView!
    @IBOutlet weak var selectBookDeleteButton: UIButton!
    var imageArray : [UIImage] = []
    var postImageArray : [String] = []
    var bookViewHeight : Int = 0
    var bookName : String = ""
    var bookAP : String = "" //저자 출판사
    var bookImgstring : String = ""
    var imgString : String = ""
    var bookImage : UIImageView!
    var UserImage : UIImageView!
    var PID : Int = 0
    var TBID : Int = 0
    var boardTypeNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWriteTitleTextField()
        
        writePostButtonUI()
        setCollectionViewCell()
        bottomStackView.setCustomSpacing(200, after: addImageButton)
        self.selectBookViewHeight.constant = 0
        self.ImgCollectionViewHeight.constant = 0
    }
    //화면터치시내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    @IBAction func tapSelectBookButtoon(_ sender: UIButton) {
        let commubityStoryBoard = UIStoryboard.init(name: "Community", bundle: nil)
        guard let WritePostBookSearchViewController = commubityStoryBoard.instantiateViewController(withIdentifier: "WritePostBookSearchViewController") as? WritePostBookSearchViewController
        else {return}
        WritePostBookSearchViewController.modalPresentationStyle = .fullScreen
        WritePostBookSearchViewController.delegate = self
        self.present(WritePostBookSearchViewController, animated: true, completion: nil)
    }
    @IBAction func tapAddImgButton(_ sender: UIButton) {
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
                    self.ImgCollectionViewHeight.constant = 150
                    self.ImageCollectionView.reloadData()
                }
                print("\(self.imageArray)r")
            }
        }
    }
    @IBAction func tapWriteReplyComment(_ sender: UIButton)  {
        let textContent = writeContentsTextView.text ?? ""
        var imgarray : [String] = []
        for i in self.imageArray {
            guard let thumbnail = i.imageToPNGString() else {return}
            let encodedThumbnail = "data:image/png;base64," + thumbnail
            imgarray.append(encodedThumbnail)
        }
        communityPostWriteData(textTitle: "Title", textContetnt: textContent , boardTypeNumber: self.boardTypeNumber, parentQPID: self.PID,TBID:self.TBID,thumbnail:imgarray)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.navigationController?.popViewController(animated: true)
        })
    }
    private func communityPostWriteData(textTitle: String ,textContetnt: String , boardTypeNumber: Int , parentQPID : Int,TBID : Int,thumbnail:[String]){
        CommunityPostAPI.shared.postCommunityWrite(textTitle: textTitle, textContent: textContetnt, CommunityBoardNumber: boardTypeNumber , parentQPID : parentQPID ,TBID:TBID ,thumbnail:[]){(success,data)in
            if success {
                print("post통신 성공")
            }else {
                print("post 통신 실패")
            }
        }
    }
    private func writePostButtonUI(){
        writePostButton.tintColor = .white
        writePostButton.layer.borderWidth = 2
        writePostButton.layer.cornerRadius = 15
        writePostButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        writePostButton.backgroundColor = UIColor(named: "primaryColor")
        
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
    @objc func deleteImg(_ sender : UIButton){
        let row : Int = (sender as! ImageCancelButton).row
        self.imageArray.remove(at: row)
        if self.imageArray.count == 0 {
            self.ImgCollectionViewHeight.constant = 0
        }
        self.ImageCollectionView.reloadData()
        
    }
    
    func sendData(ImageString:String,bookName: String ,bookAuthorPublisher : String,height : Int,BID:Int){
        self.bookNameLabel.text = bookName
        self.bookAPLabel.text = bookAuthorPublisher
        self.TBID = BID
        
        if let url = URL(string: ImageString) {
            self.BookImageView.load(url: url)
        }
        
        self.selectBookViewHeight.constant = CGFloat(height)
    }
    @IBAction func tapDeleteSelectBook(_ sender: UIButton) {
        self.selectBookViewHeight.constant = 0
    }
}
extension QnAWriteAnswerViewController:UITextViewDelegate{
    private func setWriteTitleTextField() {
        writeContentsTextView.delegate = self
        writeContentsTextView.text = "내용을 입력해주세요"
        writeContentsTextView.textColor = UIColor.lightGray
        writeContentsTextView.layer.borderWidth = 2
        writeContentsTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        writeContentsTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
}
extension QnAWriteAnswerViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "QnAwriteCollectionViewid", for: indexPath) as? QnAWriteAddImgCollectionViewCell else {return UICollectionViewCell()}
        cell.selectImg.image = self.imageArray[indexPath.row]
        cell.cancelImgButton.row = indexPath.row
        cell.cancelImgButton.addTarget(self, action: #selector(deleteImg), for: .touchUpInside)
        return cell
    }

    

}
