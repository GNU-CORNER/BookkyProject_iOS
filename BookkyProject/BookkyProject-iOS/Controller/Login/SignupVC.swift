//
//  SignupVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/29.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailCheckLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheckTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignupView()
    }
    
    func setSignupView() {
        self.signupLabel?.text = "회원가입"
        
        self.nicknameLabel?.text = "닉네임"
        self.nicknameTextField?.addLeftPadding()
        self.nicknameTextField.layer.borderColor = .none
        self.nicknameTextField.layer.cornerRadius = 8.0
        
        self.emailLabel?.text = "이메일"
        self.emailTextField?.addLeftPadding()
        self.emailTextField.layer.borderColor = .none
        self.emailTextField.layer.cornerRadius = 8.0
        
        self.emailCheckLabel?.text = "이메일 확인"
        self.emailCheckTextField?.addLeftPadding()
        self.emailCheckTextField.layer.borderColor = .none
        self.emailCheckTextField.layer.cornerRadius = 8.0
        
        self.passwordLabel?.text = "비밀번호"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField?.addLeftPadding()
        self.passwordTextField.layer.borderColor = .none
        self.passwordTextField.layer.cornerRadius = 8.0
        
        self.passwordCheckLabel?.text = "비밀번호 확인"
        self.passwordCheckTextField.isSecureTextEntry = true
        self.passwordCheckTextField?.addLeftPadding()
        self.passwordCheckTextField.layer.borderColor = .none
        self.passwordCheckTextField.layer.cornerRadius = 8.0
        
        self.signupButton.setTitle("회원가입", for: .normal)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
