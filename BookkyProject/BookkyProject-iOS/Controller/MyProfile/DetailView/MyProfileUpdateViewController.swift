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
        self.myprofileImageView.layer.cornerRadius = self.myprofileImageView.frame.height / 2
        
        self.myprofileNicknameTextField.addLeftPadding()
        self.myprofileNicknameTextField.layer.borderColor = .none
        self.myprofileNicknameTextField.layer.cornerRadius = 8.0
        
        self.myprofileUpdateCompleteButton.layer.cornerRadius = 8.0
//        self.myprofileUpdateCompleteButton.isEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.myprofileUpdateCompleteButton.isEnabled = true
        self.myprofileUpdateCompleteButton.backgroundColor = UIColor(named: "primaryColor")
    }
    

    @IBAction func pickMyProfileImage(_ sender: Any) {
        CameraHandler.shared.actionSheetAlert(vc: self)
        CameraHandler.shared.imagePickerBlock = { (image) in
            DispatchQueue.main.async {
                self.myprofileImageView.image = image
            }
        }
    }
    
    
    @IBAction func updateMyprofile(_ sender: Any) {
        // - [] 닉네임 형식 검사
        
        // - [x] 이미지, 닉네임 가져오기
        guard let userNickname = self.myprofileNicknameTextField.text else {
            return
        }
        guard let userThumbnail = self.myprofileImageView.image else {
            return
        }
        // - [x] 닉네임 중복 검사
        Account.shared.duplicateNicknameCheck(nickname: userNickname) { (success, data, statuscode) in
            if success {
                print("사용할 수 있는 닉네임입니다.")
                
            } else {
                print("닉네임 중복입니다.")
                // - [x] alert
                let alert = UIAlertController(title: "중복된 닉네임입니다.", message: nil, preferredStyle: .alert)
                let check = UIAlertAction(title: "확인", style: .cancel)
                alert.addAction(check)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
                return
            }
        }
        // - [] 서버로 보내기 수정사항 보내기
    }
}
