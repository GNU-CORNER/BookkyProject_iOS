//
//  BookUpdateReviewViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/05.
//

import UIKit
import Cosmos
class BookUpdateReviewViewController: UIViewController{

    @IBOutlet weak var tapBackButton: UIButton!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var updateReviewButton: AutoAddPaddingButtton!
    @IBOutlet weak var updateTextView: UITextView!
    var url : URL? = nil
    var RID : Int = 0
    var bookName : String = ""
    var bookAuthor : String  = ""
    var userContents : String = ""
    var starImageView = [UIImageView]()
    var ratingStar : Double = 0.0
    @IBOutlet weak var updateStarView: CosmosView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setWriteTitleTextField()
        setStarSliderUI()
        updateRating(self.ratingStar)
        self.keyboardDown()
    }
    private func setStarSliderUI(){
        updateStarView.rating = 0.0
        updateStarView.settings.starSize = 45
        updateStarView.settings.minTouchRating = 0
        updateStarView.didTouchCosmos = didTouchCosmos
        //단위
        updateStarView.settings.fillMode = .half
      
    }
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        
        updateStarView.rating = newRatingValue
    }
    func didTouchCosmos(_ rating: Double){
        updateRating(rating)
        self.ratingStar = rating
        
    }
    private func setUI(){

        self.updateReviewButton.setTitle("리뷰 작성", for: .normal)
        self.updateReviewButton.tintColor = .white
        self.updateReviewButton.layer.borderWidth = 1
        self.updateReviewButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.updateReviewButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.updateReviewButton.layer.cornerRadius = 15
        
    }
    private func setData(){
        let data = try! Data(contentsOf: self.url!)
        self.bookImageView.image = UIImage(data: data)
        self.bookNameLabel.text = self.bookName
        self.bookAuthorLabel.text = self.bookAuthor
    }
     

    @IBAction func tapCancel(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
  
    
    
    @IBAction func tapUpdateReview(_ sender: UIButton) {
        updateHomeReview(reviewContents :updateTextView.text , RID : self.RID , rating : Float(self.ratingStar))
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }
    

    private func updateHomeReview(reviewContents :String , RID : Int , rating : Float) {
        HomePostDataAPI.shared.updateHomeReview(contents: reviewContents, rating: rating, RID: RID) { (success,data) in
            if success {
                print("리뷰 업데이트 성공")
            }else {
                print("리뷰 업데이트 실패")
            }
        }
    }
}
extension BookUpdateReviewViewController : UITextViewDelegate{
    private func setWriteTitleTextField() {
        updateTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        updateTextView.text = "\(self.userContents)"
        updateTextView.textColor = UIColor.lightGray
        updateTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        updateTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
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
