//
//  QnAWriteAnswerViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/17.
//

import UIKit

class QnAWriteAnswerViewController: UIViewController {
    @IBOutlet weak var writeContentsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setWriteTitleTextField()
    }
    
}
extension QnAWriteAnswerViewController:UITextViewDelegate{
    private func setWriteTitleTextField() {
        writeContentsTextView.delegate = self // txtvReview가 유저가 선언한 outlet
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
