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
    
    @IBOutlet weak var signInWithGoogleButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var somethingWrongInLoginButton: UIButton!
    
    let userDefaultData = UserDefaults.standard
    
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
        self.loginButton.layer.cornerRadius = 8.0
        
        self.socialLoginLabel?.text = "간편 로그인"
        
        self.signupButton?.setTitle("회원가입", for: .normal)
        self.somethingWrongInLoginButton?.setTitle("로그인에 문제가 있나요?", for: .normal)
    }
    
    func requestLogin(email: String, password: String) {
        Account.shared.login(userEmail: email, userPassword: password) { (suceess, data) in
            if suceess {
                guard let userAccount = data as? SignupModel else { return }
                if userAccount.success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                    print( userAccount.result?.accessToken )
                    // - [x] 토큰값 저장할 것, 토큰값 갱신...
                    UserDefaults.standard.set(userAccount.result?.userData.email, forKey: UserDefaultsModel.email.rawValue )
                    UserDefaults.standard.set(userAccount.result?.accessToken, forKey: UserDefaultsModel.accessToken.rawValue )
                    UserDefaults.standard.set(userAccount.result?.refreshToken, forKey: UserDefaultsModel.refreshToken.rawValue )
                    UserDefaults.standard.set(userAccount.result?.userData.loginMethod, forKey: UserDefaultsModel.loginMethod.rawValue )
                    UserDefaults.standard.synchronize()
                    print("엑세스 토큰 값!!!")
                    print( UserDefaults.standard.string(forKey: UserDefaultsModel.accessToken.rawValue) )
                    print( UserDefaults.standard.string(forKey: UserDefaultsModel.refreshToken.rawValue) )
                }
            } else {
                print("통신실패")
            }
        }
    }
    
    
}


extension LoginVC {
    
    @IBAction func signInWithGoogle(_ sender: Any) {
        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SocialSignup") else { return }
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func cancelLogin(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func login(_ sender: Any) {
        guard let userEmail = self.emailTextField?.text, self.emailTextField?.text != "" else {
            print("이메일을 입력하세요.")
            return
        }
        guard let userPassword = self.passwordTextField?.text, self.passwordTextField?.text != "" else {
            print("비밀번호를 입력하세요.")
            return
        }
        requestLogin(email: userEmail, password: userPassword)
    }
    
}
