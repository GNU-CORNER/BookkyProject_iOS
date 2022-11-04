//
//  BookWriteReviewViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit
import Cosmos
class BookWriteReviewViewController: UIViewController{

    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorNPublisherLabel: UILabel!
    @IBOutlet weak var writeReviewTextView: UITextView!
    @IBOutlet weak var writeReviewButton: UIButton!
    
    var BID : Int = 0
    var url : String = ""
    var bookName : String = ""
    var bookAuthor : String  = ""
    var userContents : String = ""
    @IBOutlet var reviewWriteView: UIView!
    var starImageView = [UIImageView]()
    var ratingStar : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setWriteTitleTextField()
        setStarSliderUI()
        self.keyboardDown()
   
    }
//MARK: - starFunc https://velog.io/@h0neydear/Cosmos 참고
    
    private func setStarSliderUI(){
        starRatingView.rating = 0.0
        starRatingView.settings.starSize = 45
        starRatingView.settings.minTouchRating = 0
        starRatingView.didTouchCosmos = didTouchCosmos
        //단위
        starRatingView.settings.fillMode = .half
        updateRating(0)
    }
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        
        starRatingView.rating = newRatingValue
    }
    func didTouchCosmos(_ rating: Double){
        updateRating(rating)
        self.ratingStar = rating
        
    }
//MARK: -
    private func setUI(){

        self.writeReviewButton.setTitle("리뷰 작성", for: .normal)
        self.writeReviewButton.tintColor = .white
        self.writeReviewButton.layer.borderWidth = 1
        self.writeReviewButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeReviewButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
        self.writeReviewButton.layer.cornerRadius = 15
        
    }
    private func setData(){
        if let url = URL(string: self.url) {
            self.bookImage.load(url: url)
        }
        
        self.bookNameLabel.text = self.bookName
        self.bookAuthorNPublisherLabel.text = self.bookAuthor
    }
     

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapWriteReview(_ sender: UIButton) {
        bookReviewWrite(reviewContents: self.writeReviewTextView.text, BID: self.BID, rating: self.ratingStar)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })

    }
    private func bookReviewWrite(reviewContents: String ,BID: Int , rating: Double){
        HomePostDataAPI.shared.postCommunityWrite(contents: reviewContents, rating: rating, BID: BID){ (success,data) in
            if success {
                print("post통신 성공")
            }else {
                
                print("post 통신 실패")
            }
        }
    }

}
extension BookWriteReviewViewController : UITextViewDelegate{
    private func setWriteTitleTextField() {
        writeReviewTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        writeReviewTextView.text = "리뷰를 작성해 주세요"
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
    //Return버튼클릭시 내려가도록함 다른 방법더있음 둘중에 뭐 할지 선택
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n"){
            textView.resignFirstResponder()
        }
        return true
    }

    
    
}
