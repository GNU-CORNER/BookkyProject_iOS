//
//  QnAWriteAnswerViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/17.
//

import UIKit
// MARK: - Q&A 답변쓰기 컨트롤러
class QnAWriteAnswerViewController: UIViewController {
    @IBOutlet weak var writeContentsTextView: UITextView!
    @IBOutlet weak var writePostButton: AutoAddPaddingButtton!
    @IBOutlet weak var addBookButton: UIButton!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    var PID : Int = 0
    var TBID : Int = 0
    var boardTypeNumber : Int = 0
    var imageArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setWriteTitleTextField()
        writePostButtonUI()
        bottomStackView.setCustomSpacing(200, after: addImageButton)
    }
    
    @IBAction func tapWriteReplyComment(_ sender: UIButton)  {
        let replyCommentContents = self.writeContentsTextView.text
        communityPostWriteData(textTitle: "text", textContetnt: replyCommentContents ?? "", boardTypeNumber: self.boardTypeNumber, parentQPID: self.PID,TBID:self.TBID,thumbnail:self.imageArray)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.imageArray = []
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
