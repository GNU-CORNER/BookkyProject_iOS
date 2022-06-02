//
//  WriteTextViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/02.
//

import UIKit

class WriteTextViewController: UIViewController {
    var boardTypeNumber : Int = 0
    
    
    @IBOutlet weak var boardNameButton: UIButton!
    
    @IBOutlet weak var freeBoardGoButton: UIButton!
    @IBOutlet weak var QnABoardGoButton: UIButton!
    @IBOutlet weak var bookMarketGoButton: UIButton!
    
    @IBOutlet weak var boardTypeStackView: UIStackView!
    
    @IBOutlet weak var writeContentTextView: UITextView!
    @IBOutlet weak var writeTitleTextField: UITextField!
    
    @IBOutlet weak var writeTextButton: UIButton!
    @IBOutlet weak var bookthumbnailImageAddButton: UIButton!
    @IBOutlet weak var ImageAddButton: UIButton!
    @IBOutlet weak var writeTextBottomStackView: UIStackView!
    @IBOutlet weak var communityGoBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        setWriteTitleTextField()
        setWriteTitleTextField()
        setWriteTextButtonUI()
        setStackViewSpacing()
        setdropDownView()
        setinitCommunity()
        boardTypeColor()
        
    }
    func setBackButton(){
        communityGoBackButton.tintColor = UIColor.black
        communityGoBackButton.setTitle("Back", for: .normal)
        communityGoBackButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
    }
    func setdropDownView(){
        self.freeBoardGoButton.setTitle("자유", for: .normal)
        self.QnABoardGoButton.setTitle("Q&A", for: .normal)
        self.bookMarketGoButton.setTitle("책 장터", for: .normal)
        
    }
    func setinitCommunity(){
        //보드게시판 클릭전 초기
        self.boardNameButton.setTitle("자유 게시판", for: .normal)
        self.boardNameButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        self.boardNameButton.sizeToFit()
        self.boardNameButton.tintColor = .black
        self.freeBoardGoButton.setTitleColor(.black, for: .normal)
    }
    private func boardTypeColor() {
        self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
        self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
        self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
    }
    //드롭다운 메뉴구현
    @IBAction func tapGoBoard(_ sender: UIButton) {
        if sender == self.freeBoardGoButton{
            self.boardTypeNumber = 0
            setDropDownMenu()
        }else if sender == self.bookMarketGoButton{
            self.boardTypeNumber = 1
            setDropDownMenu()
        }else if sender == self.QnABoardGoButton{
            self.boardTypeNumber = 2
            setDropDownMenu()
        }
    }
    @IBAction func tapChangeBoard(_ sender: UIButton) {
        if boardTypeStackView.isHidden == false {
            self.boardTypeStackView.isHidden = true
        }else{
            self.boardTypeStackView.isHidden = false
            self.boardTypeStackView.backgroundColor = .white
            self.boardTypeStackView.layer.borderWidth = 1
            self.boardTypeStackView.layer.cornerRadius = 8
            self.boardNameButton.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
    }
    func setDropDownMenu(){
        var boardName : String = "자유 게시판"
        self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
        self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
        self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
        
        
        self.freeBoardGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.QnABoardGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.bookMarketGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        self.boardTypeStackView.isHidden = true
        
        self.boardNameButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
        
        if boardTypeNumber == 0{
            self.freeBoardGoButton.setTitleColor(.black, for: .normal)
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "자유 게시판"
        }else if boardTypeNumber == 1{
            self.bookMarketGoButton.setTitleColor(.black, for: .normal)
            self.bookMarketGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "책 장터 게시판"
        }else if boardTypeNumber == 2{
            self.QnABoardGoButton.setTitleColor(.black, for: .normal)
            self.QnABoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "Q&A 게시판"
        }else{
            self.freeBoardGoButton.setTitleColor(.black, for: .normal)
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "자유 게시판"
        }
        self.boardNameButton.setTitle(boardName, for: .normal)
        
    }
    func setStackViewSpacing(){
        writeTextBottomStackView.setCustomSpacing(10, after: bookthumbnailImageAddButton)
        writeTextBottomStackView.setCustomSpacing(200, after: ImageAddButton)
    }
    
    private func setWriteTextButtonUI(){
        writeTextButton.tintColor = .white
        writeTextButton.layer.borderWidth = 2
        writeTextButton.layer.cornerRadius = 15
        writeTextButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        writeTextButton.backgroundColor = UIColor(named: "primaryColor")
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
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
        
    }
    
    @IBAction func tapGoBackCommunityButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postTextContent(_ sender: UIButton) {
        let textTitle = writeTitleTextField.text ?? ""
        let textContent = writeContentTextView.text ?? ""
        communityPostWriteData(textTitle: textTitle, textContetnt: textContent, boardTypeNumber: boardTypeNumber,parentQPID: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.navigationController?.popViewController(animated: true)
        })
        
        
    }
    private func communityPostWriteData(textTitle: String ,textContetnt: String , boardTypeNumber: Int , parentQPID : Int){
        CommunityPostAPI.shared.postCommunityWrite(textTitle: textTitle, textContent: textContetnt, CommunityBoardNumber: boardTypeNumber , parentQPID : parentQPID ){(success,data)in
            if success {
                print("post통신 성공")
            }else {
                print("post 통신 실패")
            }
        }
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
