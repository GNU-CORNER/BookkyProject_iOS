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
    @IBOutlet weak var writeReviewTextView: UITextView!
    @IBOutlet weak var writeReviewButton: UIButton!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var starRatingSlider: UISlider!
    var BID : Int = 0
    var url : URL? = nil
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
        initStarImageViewArray()
        initSlider()
    }
    
    private func initSlider(){
        starRatingSlider.setThumbImage(UIImage(), for: .normal)
        starRatingSlider.addTarget(self, action: #selector(sliderStar), for: UIControl.Event.valueChanged)
        
    }
    private func initStarImageViewArray(){
        for idx in 0..<5 {
            starImageView.append(starStackView.subviews[idx] as? UIImageView ?? UIImageView())
        }
        
    }
 
    private func showStarImageFull(imageView : UIImageView){
        imageView.image = UIImage(named: "star_full")
        
    }
    private func showStarImgaeHalf(imageView : UIImageView){
        imageView.image = UIImage(named: "star_half")
    }
    private func showStarImageEmpty(imageView : UIImageView){
        imageView.image = UIImage(named: "star_empty")
    }
    @objc func sliderStar(){
        var rating = starRatingSlider.value
        switch rating {
        case 0:
            self.ratingStar = 0.0
        case 0..<0.5:
            self.ratingStar = 0.5
        case 0.5..<1.0:
            self.ratingStar = 1
        case 1.0..<1.5:
            self.ratingStar = 1.5
        case 1.5..<2.0:
            self.ratingStar = 2.0
        case 2.0..<2.5:
            self.ratingStar = 2.5
        case 2.5..<3.0:
            self.ratingStar = 3.0
        case 3.0..<3.5:
            self.ratingStar = 3.5
        case 3.5..<4.0:
            self.ratingStar = 4.0
        case 4.0..<4.5:
            self.ratingStar = 4.5
        case 4.5..<5.0:
            self.ratingStar = 5
        default:
            self.ratingStar = 5
        }
        for idx in 0..<5 {
            if rating > 0.5{
                rating -= 1
                showStarImageFull(imageView: starImageView[idx])
            }else if 0 < rating && rating < 0.5 {
                rating -= 0.5
                showStarImgaeHalf(imageView: starImageView[idx])
            }else {
                showStarImageEmpty(imageView: starImageView[idx])
            }
                
        }
        
    }
    private func setUI(){

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
}
