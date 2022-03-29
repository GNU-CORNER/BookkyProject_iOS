//
//  SetNewPasswordVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/30.
//

import UIKit

class NewPasswordVC: UIViewController {

    @IBOutlet weak var findPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var checkNewPasswordLabel: UILabel!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var checkNewPasswordTextField: UITextField!
    
    @IBOutlet weak var setNewPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNewPassword()
    }
    
    func setNewPassword() {
        self.findPasswordLabel?.text = "PW 찾기"
        
        self.newPasswordLabel?.text = "새로운 비밀번호"
        self.newPasswordTextField.isSecureTextEntry = true
        self.newPasswordTextField?.addLeftPadding()
        self.newPasswordTextField.layer.borderColor = .none
        self.newPasswordTextField.layer.cornerRadius = 8.0
        
        self.checkNewPasswordLabel?.text = "새로운 비밀번호 확인"
        self.checkNewPasswordTextField.isSecureTextEntry = true
        self.checkNewPasswordTextField?.addLeftPadding()
        self.checkNewPasswordTextField.layer.borderColor = .none
        self.checkNewPasswordTextField.layer.cornerRadius = 8.0
        
        self.setNewPasswordButton.setTitle("PW 변경하기", for: .normal)
    }

}
