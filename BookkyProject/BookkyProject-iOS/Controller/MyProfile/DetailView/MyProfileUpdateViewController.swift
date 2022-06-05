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
    
    var thumbnailImageRecived: UIImage!
    var nicknameTextRecived: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "프로필 수정"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.myprofileNicknameTextField.delegate = self
        setDefaultView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        guard let email = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
//            return
//        }
//        guard let accessToken = KeychainManager.shared.read(userEmail: email, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
//            return
//        }
        self.myprofileImageView.image = thumbnailImageRecived
        self.myprofileNicknameTextField.text = nicknameTextRecived
    }
    
    private func accessToken() {
        
    }
    
    private func setDefaultView() {
        self.myprofileImageView.layer.cornerRadius = self.myprofileImageView.frame.height / 2
        
        self.myprofileNicknameTextField.addLeftPadding()
        self.myprofileNicknameTextField.layer.borderColor = .none
        self.myprofileNicknameTextField.layer.cornerRadius = 8.0
        self.myprofileUpdateCompleteButton.backgroundColor = UIColor(named: "primaryColor")
        self.myprofileUpdateCompleteButton.layer.cornerRadius = 8.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.myprofileUpdateCompleteButton.isEnabled = true
//        self.myprofileUpdateCompleteButton.backgroundColor = UIColor(named: "primaryColor")
//    }
    
//    private func requestDuplicateNicknameCheck() {
//
//    }

    @IBAction func pickMyProfileImage(_ sender: Any) {
        CameraHandler.shared.actionSheetAlert(vc: self)
        CameraHandler.shared.imagePickerBlock = { (image) in
            DispatchQueue.main.async {
                self.myprofileImageView.image = image
            }
        }
    }
    
    
    @IBAction func myProfileWillUpdate(_ sender: Any) {
        // - [x] 이미지, 닉네임 가져오기
        guard let userNickname = self.myprofileNicknameTextField.text else {
            return
        }
        guard let userThumbnail = self.myprofileImageView.image?.imageToPNGString() else {
            return
        }
        // - [ ] 닉네임 형식 검사

        // - [x] 닉네임 중복 검사
        Account.shared.duplicateNicknameCheck(nickname: userNickname) { (success, data, statuscode) in
            if success {
                print("사용할 수 있는 닉네임입니다.")
                // - [] 서버로 보내기 수정사항 보내기
                guard let email = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                    return
                }
                guard let accessToken = KeychainManager.shared.read(userEmail: email, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
                    return
                }
                MyProfileAPI.shared.myProfileUpdate(accessToken: accessToken, nickname: userNickname, thumbnailString: userThumbnail) { (data, statuscode) in
                    print("프로필 수정에 성공했습니다.")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "프로필을 수정했습니다.", message: nil, preferredStyle: .alert)
                        let check = UIAlertAction(title: "확인", style: .cancel) { (_) in
                            // - [x] redirect myprofile
                            self.navigationController?.popViewController(animated: false)
                        }
                        alert.addAction(check)
                        self.present(alert, animated: true)
                    }
                }
            } else {
                print("닉네임 중복입니다.")
                // - [x] alert , 함수화하자...
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "중복된 닉네임입니다.", message: nil, preferredStyle: .alert)
                    let check = UIAlertAction(title: "확인", style: .cancel)
                    alert.addAction(check)
                    self.present(alert, animated: true)
                }
                return
            }
        }
        
    }
}
