//
//  WriteTextViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/02.
//

import UIKit

class WriteTextViewController: UIViewController {
   
    @IBOutlet weak var writeContentTextView: UITextView!
    @IBOutlet weak var writeTitleTextField: UITextField!
    @IBOutlet weak var writeTextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.black
        setWriteTitleTextField()
        setWriteTitleTextField()
        setWriteTextButton()
    }
    private func setWriteTextButton(){
        writeTextButton.tintColor = .white
        writeTextButton.layer.borderWidth = 2
        writeTextButton.layer.cornerRadius = 15
        writeTextButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        writeTextButton.backgroundColor = UIColor(named: "primaryColor")
        writeTextButton.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        
    }
    private func setwriteTitleTextField(){
        writeTitleTextField.layer.borderWidth = 1
        writeTitleTextField.textColor = UIColor.lightGray
        writeTitleTextField.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
        
    }
    private func setWriteTitleTextField() {
        writeContentTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        writeContentTextView.text = "내용을 입력해주세요"
        writeContentTextView.textColor = UIColor.lightGray
        writeContentTextView.layer.borderWidth = 2
        writeContentTextView.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        writeContentTextView.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
    }

}
extension WriteTextViewController : UITextViewDelegate{
  
    
    
  
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
