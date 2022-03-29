//
//  LoginVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/29.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var bookkyLogoImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var socialLoginLabel: UILabel!
    @IBOutlet weak var naverSocialLoginButton: UIButton!

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var somethingWrongInLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginView()
    }

    func setLoginView() {
        self.bookkyLogoImage?.image = UIImage(named: "Bookky_Logo")
        
        self.emailLabel?.text = "이메일"
        self.emailTextField?.addLeftPadding()
        self.emailTextField.layer.borderColor = .none
        self.emailTextField.layer.cornerRadius = 8.0
        
        self.passwordLabel?.text = "비밀번호"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField?.addLeftPadding()
        self.passwordTextField.layer.borderColor = .none
        self.passwordTextField.layer.cornerRadius = 8.0
        
        self.loginButton?.setTitle("로그인", for: .normal)
        
        self.socialLoginLabel?.text = "간편 로그인"
        
        self.signupButton?.setTitle("회원가입", for: .normal)
        self.somethingWrongInLoginButton?.setTitle("로그인에 문제가 있나요?", for: .normal)
    }
}

extension UITextField {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
}
