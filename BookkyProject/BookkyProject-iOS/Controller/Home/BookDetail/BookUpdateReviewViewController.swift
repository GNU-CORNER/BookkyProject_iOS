//
//  BookUpdateReviewViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/05.
//

import UIKit

class BookUpdateReviewViewController: UIViewController{

    @IBOutlet weak var tapBackButton: UIButton!
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var starStackView: UIStackView!
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var updateReviewButton: AutoAddPaddingButtton!
    @IBOutlet weak var updateTextView: UITextView!
    var url : URL? = nil
    var RID : Int = 0
    var bookName : String = ""
    var bookAuthor : String  = ""
    var userContents : String = ""
    var starImageView = [UIImageView]()
    var ratingStar : Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        setWriteTitleTextField()
        initStarImageViewArray()
        initSlider()
        updateStarImageView()
    }
    
    private func initSlider(){
        starSlider.setThumbImage(UIImage(), for: .normal)
        starSlider.addTarget(self, action: #selector(sliderStar), for: UIControl.Event.valueChanged)
        
    }
    private func initStarImageViewArray(){
        for idx in 0..<5 {
            starImageView.append(starStackView.subviews[idx] as? UIImageView ?? UIImageView())
        }
        
    }
    private func updateStarImageView(){
        var rating = self.ratingStar
        for idx in 0..<5 {
            if rating > 0.5{
                rating -= 1
                showStarImageFull(imageView: starImageView[idx])
            }else if 0 < rating && rating <= 0.5 {
                rating -= 0.5
                showStarImgaeHalf(imageView: starImageView[idx])
            }else {
                showStarImageEmpty(imageView: starImageView[idx])
            }
                
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
        var rating = starSlider.value
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
        updateHomeReview(reviewContents :updateTextView.text , RID : self.RID , rating : self.ratingStar)
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
