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
        Account.shared.login(userEmail: email, userPassword: password) { (suceess, data, statuscode) in
            if suceess {
                guard let userAccount = data as? SignupModel else { return }
                if userAccount.success {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                    // - [x] 사용자 이메일, 로그인 방식은 UserDefaults에 저장
                    UserDefaults.standard.set(userAccount.result?.userData?.email, forKey: UserDefaultsModel.email.rawValue )
                    UserDefaults.standard.set(userAccount.result?.userData?.loginMethod, forKey: UserDefaultsModel.loginMethod.rawValue )
                    UserDefaults.standard.synchronize()
                    print("엑세스 토큰 값!!!")
                    // - [x] 사용자 AT, RT는 Keychain에 저장
                    if let accessToken = userAccount.result?.accessToken {
                        if !KeychainManager.shared.update(accessToken, userEmail: email, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                            // - [ ] 저장이 안될 경우 예외처리 할 것.
                            print("Login : AT 저장이 안되었따.")
                        }
                    }
                    if let refreshToken = userAccount.result?.refreshToken {
                        if !KeychainManager.shared.update(refreshToken, userEmail: email, itemLabel: UserDefaultsModel.refreshToken.rawValue) {
                            // - [ ] 저장이 안될 경우 예외처리 할 것.
                            print("Login : RT 저장이 안되었따.")
                        }
                    }
                    // - [x] 사용자가 처음 로그인하는지 확인
                    if UserDefaults.standard.bool(forKey: UserDefaultsModel.launchBefore.rawValue) == false {
                        UserDefaults.standard.set(true, forKey: UserDefaultsModel.launchBefore.rawValue)
                        RedirectView.initialResearchView(presentView: self)
                    }
                    
                    // FIXME: 임시 - AT 갱신코드, 대회 끝나고 지울 것
                    print("LoginVC: \(statuscode)")
                    print("request MyProfile false의 이유: \(userAccount.errorMessage)")
                    
                    guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                        print("사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        print(success)
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                //                                self.requestMyprofile(accessToken: previousAccessToken)
                            }
                        } else {
                            print(statuscode)
                            if statuscode == 400 {
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print("AccessToken의 만료기간이 남음 \(tokens.errorMessage)")
                            } else if statuscode == 401 {
                                // 만료된 토큰입니다.
                                print(tokens.errorMessage)
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 404 {
                                // RefreshTokenStorage와의 연결이 끊김
                            } else if statuscode == 405 {
                                // POST가 아닌 방식으로 접근 했을 경우
                            }
                        }
                    }
                    
                } else {
                    print(statuscode)
                    print("request MyProfile false의 이유: \(userAccount.errorMessage)")
                }
                
            } else {
                print(statuscode)
                print("비번 틀림.")
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

