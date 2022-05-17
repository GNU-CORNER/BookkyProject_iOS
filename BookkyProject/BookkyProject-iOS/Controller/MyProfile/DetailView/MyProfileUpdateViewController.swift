//
//  MyProfileUpdateViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/13.
//

import UIKit

class MyProfileUpdateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myprofileImageView: UIImageView!
    @IBOutlet weak var myprofileImageUpdateButton: UIButton!
    @IBOutlet weak var myprofileNicknameTextField: UITextField!
    @IBOutlet weak var myprofileNoticeLabel: UILabel!
    @IBOutlet weak var myprofileUpdateCompleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "프로필 수정"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.myprofileNicknameTextField.delegate = self
        setDefaultView()
    }
    
    private func setDefaultView() {
        self.myprofileImageView.layer.cornerRadius = self.myprofileImageView.frame.width / 2
        
        self.myprofileNicknameTextField.addLeftPadding()
        self.myprofileNicknameTextField.layer.borderColor = .none
        self.myprofileNicknameTextField.layer.cornerRadius = 8.0
        
        self.myprofileUpdateCompleteButton.layer.cornerRadius = 8.0
        self.myprofileUpdateCompleteButton.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.myprofileUpdateCompleteButton.isEnabled = true
        self.myprofileUpdateCompleteButton.backgroundColor = UIColor(named: "primaryColor")
    }
    

    @IBAction func reloadMyprofileImage(_ sender: Any) {
    }
    
    @IBAction func updateMyprofile(_ sender: Any) {
//        self.myprofileNicknameTextField.text
//        self.myprofileImageView.image
        // 닉네임 중복 검사 해야함~~
    }
}
