//
//  BookWriteReviewViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class BookWriteReviewViewController: UIViewController{

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorNPublisherLabel: UILabel!
    @IBOutlet weak var firstStarButton: UIButton!
    @IBOutlet weak var secondStarButton: UIButton!
    @IBOutlet weak var thirdStarButton: UIButton!
    @IBOutlet weak var fourStarButton: UIButton!
    @IBOutlet weak var fiveStarButton: UIButton!
    @IBOutlet weak var writeReviewTextView: UITextView!
    @IBOutlet weak var writeReviewButton: UIButton!
    var url : URL? = nil
    var bookName : String = ""
    var bookAuthor : String  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setWriteTitleTextField()
        setData()
    }
    
    private func setUI(){

        self.firstStarButton.tintColor = UIColor(red: 255/255, green: 246/255, blue: 20/255, alpha: 1)
        self.secondStarButton.tintColor = UIColor(red: 255/255, green: 246/255, blue: 20/255, alpha: 1)
        self.thirdStarButton.tintColor = UIColor(red: 255/255, green: 246/255, blue: 20/255, alpha: 1)
        self.fourStarButton.tintColor = UIColor(red: 255/255, green: 246/255, blue: 20/255, alpha: 1)
        self.fiveStarButton.tintColor = UIColor(red: 255/255, green: 246/255, blue: 20/255, alpha: 1)
        self.writeReviewButton.setTitle("리뷰 작성", for: .normal)
        self.writeReviewButton.tintColor = .white
        self.writeReviewButton.layer.borderWidth = 1
        self.writeReviewButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeReviewButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeReviewButton.layer.cornerRadius = 15
        
    }
    private func setData(){
        let data = try! Data(contentsOf: self.url!)
        self.bookImage.image = UIImage(data: data)
        self.bookNameLabel.text = self.bookName
        self.bookAuthorNPublisherLabel.text = self.bookAuthor
    }
     

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
  
}
extension BookWriteReviewViewController : UITextViewDelegate{
    private func setWriteTitleTextField() {
        writeReviewTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        writeReviewTextView.text = "리뷰를 작성해주세요."
        writeReviewTextView.textColor = UIColor.lightGray
        writeReviewTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        writeReviewTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
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
