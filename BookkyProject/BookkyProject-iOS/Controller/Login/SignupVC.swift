//
//  SignupVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/29.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailAuthenticateTimeLabel: UILabel!
    @IBOutlet weak var emailCheckLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheckTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailAuthenticationRequestButton: UIButton!
    @IBOutlet weak var emailCheckButton: UIButton!
    
    private var didCheckEmail: Bool = false
    private var didDoubleCheckNickName: Bool = false
    var timer: Timer?
    var totalSecond: Int = 0
    
    // MARK: - view Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignupView()
        setTextFieldDelgate()
    }
    
    // MARK: - view Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        timerReset()
    }
    
    // MARK: - set view
    private func setSignupView() {
        self.signupLabel?.text = "회원가입"
        
        self.nicknameLabel?.text = "닉네임"
        self.nicknameTextField?.addLeftPadding()
        self.nicknameTextField.layer.borderColor = .none
        self.nicknameTextField.layer.cornerRadius = 8.0
        
        self.emailLabel?.text = "이메일"
        self.emailTextField?.addLeftPadding()
        self.emailTextField.layer.borderColor = .none
        self.emailTextField.layer.cornerRadius = 8.0
        self.emailAuthenticationRequestButton.layer.borderColor = .none
        self.emailAuthenticationRequestButton.layer.cornerRadius = 8.0
        /// 이메일이 양식에 맞게 입력이 되면 (혹은 텍스트 필드에 무엇인가 입력이 되면) true가 되도록
        self.emailAuthenticationRequestButton.isEnabled = false
        
        self.emailAuthenticateTimeLabel.isHidden = true
        
        self.emailCheckLabel?.text = "이메일 확인"
        self.emailCheckTextField?.addLeftPadding()
        self.emailCheckTextField.layer.borderColor = .none
        self.emailCheckTextField.layer.cornerRadius = 8.0
        self.emailCheckButton.layer.borderColor = .none
        self.emailCheckButton.layer.cornerRadius = 8.0
        /// 이메일 요청을 보내면 그때 활성화 되도록..
        self.emailCheckButton.isEnabled = false
        
        self.passwordLabel?.text = "비밀번호"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField?.addLeftPadding()
        self.passwordTextField.layer.borderColor = .none
        self.passwordTextField.layer.cornerRadius = 8.0
        self.passwordTextField.textContentType = .oneTimeCode
        
        self.passwordCheckLabel?.text = "비밀번호 확인"
        self.passwordCheckTextField.isSecureTextEntry = true
        self.passwordCheckTextField?.addLeftPadding()
        self.passwordCheckTextField.layer.borderColor = .none
        self.passwordCheckTextField.layer.cornerRadius = 8.0
        self.passwordCheckTextField.textContentType = .oneTimeCode
        
        self.signupButton.setTitle("회원가입", for: .normal)
        self.signupButton.layer.cornerRadius = 8.0
    }

    // - [x] 이메일 형식 확인 절차
    private func isValidEmail(testStr: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailReg)
        print("이메일 형식 확인")
        return emailTest.evaluate(with: testStr)
    }
    
    // - [x] 이메일 코드 형식 확인 절차
    private func isValidEmailCode(codeStr: String) -> Bool {
        let codeReg = "[0-9]{8}"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeReg)
        print("이메일 코드 형식 확인")
        return codeTest.evaluate(with: codeStr)
    }
    

    // 코드 확인 필요
    func showToast(message : String) {
        let toastLabel = UILabel(
            frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height - 180, width: 300, height: 35)
        )
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 7.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isCompleted) in toastLabel.removeFromSuperview()
        })
    }
    
    private func timerReset() {
        totalSecond = 180
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
        DispatchQueue.main.async {
            self.emailAuthenticateTimeLabel.isHidden = true
        }
    }
    
    @objc private func ThreeMinutesTimer() {
        // - [x] 3분 타이머 실행
        let second: Int = totalSecond % 60
        let minute: Int = totalSecond / 60
        self.emailAuthenticateTimeLabel.isHidden = false
        self.emailAuthenticateTimeLabel?.text = String(format: "%2d:%02d", minute, second)
        print("타이머 실행!")
        if totalSecond > 0 {
            totalSecond -= 1
        } else {
            if let timer = self.timer {
//                self.emailAuthenticateTimeLabel?.text = "시간 초과"
                self.emailAuthenticationRequestButton.isEnabled = true
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    
}

// MARK: - IBAction Extension
extension SignupVC {
    
    
    // MARK: Request Email Authenticate
    @IBAction func emailAuthenticateRequest(_ sender: Any) {
        timerReset()
        // - [x] 이메일을 입력했는가?
        guard let emailText = self.emailTextField?.text else { return }
        if isValidEmail(testStr: emailText) {
            print("이메일 형식 통과")
            self.emailTextField.layer.borderWidth = 0
            // - [x] 이메일 요청의 응답이 올 때까지 사용자에게 알려주기
            DispatchQueue.main.async {
                // - [x] 3분 타이머 실행
                self.totalSecond = 180
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.ThreeMinutesTimer), userInfo: nil, repeats: true)
                // - [x] 본인의 이메일로 인증번호 확인 부탁한다는 토스트 메시지 띄우기
                self.showToast(message: "해당 이메일로 인증번호를 보냈습니다.")
            }
            // - [x] 서버로 이메일 인증 요청
            if let userEmail = self.emailTextField?.text as? String {
                requestEmailAuth(email: userEmail)
                print("기다려!")
            }
            self.emailAuthenticationRequestButton.isEnabled = false
        } else {
            print("이메일 형식이 맞지 않아요!")
            showToast(message: "이메일 형식이 맞지 않습니다.")
            animateTextFieldBorderColor(userTextField: self.emailTextField, color: UIColor.red)
        }
        
    }
    
    // MARK: Request Email Check Code
    @IBAction func emailCodeCheckRequest(_ sender: Any) {
        guard let emailCode: String = self.emailCheckTextField?.text as? String else {
            print("이메일 코드를 안입력했는데?")
            return
        }
        // - [x] 코드 형식 맞는지 확인 (자릿수, 정수형)
        if isValidEmailCode(codeStr: emailCode) {
            print("형식 맞음~~~!!!")
            // - [x] 서버로 이메일 코드 인증 요청
            if let code = self.emailCheckTextField?.text as? String, let userEmail = self.emailTextField?.text as? String {
                requestEmailCodeCheck(email: userEmail, code: Int(code)!)
            }
        } else {
            print("코드 형식이 안맞아요~")
            showToast(message: "확인 코드 형식이 맞지 않습니다.")
            animateTextFieldBorderColor(userTextField: self.emailCheckTextField, color: UIColor.red)
        }
    }
    
    // MARK: Sign up
    @IBAction func signupDidTap(_ sender: Any) {
        // - [x] 닉네임 입력했는지 확인
        // - [ ] 닉네임 공백처리 할 것
        guard let inputNickName = self.nicknameTextField?.text, self.nicknameTextField?.text != "" else {
            // - [ ] 토스트메시지 말고 일반 아이폰 알림으로 할 것.
            showToast(message: "닉네임을 입력하세요.")
            animateTextFieldBorderColor(userTextField: self.nicknameTextField, color: UIColor.red)
            return
        }
        // - [x] 이메일 확인받았는지 확인
        guard didCheckEmail, let inputEmail = self.emailTextField?.text else {
            showToast(message: "이메일을 확인하세요.")
            animateTextFieldBorderColor(userTextField: self.emailTextField, color: UIColor.red)
            return
        }
        // - [x] 비밀번호 입력했는지 확인
        guard let inputPW = self.passwordTextField?.text, self.passwordTextField?.text != "" else {
            showToast(message: "비밀번호를 입력하세요.")
            animateTextFieldBorderColor(userTextField: self.passwordTextField, color: UIColor.red)
            return
        }
        // - [x] 비밀번호 동일한지 확인
        guard self.passwordTextField?.text == self.passwordCheckTextField?.text else {
            showToast(message: "비밀번호가 다릅니다!")
            animateTextFieldBorderColor(userTextField: self.passwordCheckTextField, color: UIColor.red)
            return
        }
        // - [x] 서버로 (닉네임, 이메일, 비밀번호) 보내서 회원가입 진행
        requestSignup(nickName: inputNickName, email: inputEmail, password: inputPW)
    }
    
}

// MARK: - Email, Signup Extension.
extension SignupVC {
    
    private func requestEmailAuth(email: String) {
        EmailAuthenticate.shared.authenticateCodeSender(userEmail: email) { (success, data) in
            if success {
                guard let resultData = data as? EmailAuthModel else { return }
                if resultData.success {
                    print(resultData)
                    print(resultData.success)
//                    print(resultData.result?.userData?.email)
                } else {
                    // - [x] 이미 존재하는 이메일입니다.
                    DispatchQueue.main.async {
                        self.showToast(message: resultData.errorMessage)
                        self.timerReset()
                    }
                }
            } else {
                // - [x] 통신 실패
                print("통신실패...")
            }
        }
    }
    
    private func requestEmailCodeCheck(email: String, code: Int) {
        EmailAuthenticate.shared.validateCode(userEmail: email, code: code) { (success, data) in
            if success {
                print("통신 굿")
                // - [x] 인증코드가 맞으면 이메일과 이메일 코드 입력창에 파란 테두리! (사용자에게 맞다는 것을 알려줌)
                DispatchQueue.main.async {
                    self.emailTextField.layer.borderWidth = 1.0
                    self.emailTextField.layer.borderColor = UIColor.blue.cgColor
                    self.emailTextField.isEnabled = false
                    self.emailAuthenticationRequestButton.isEnabled = false
                    self.emailCheckTextField.layer.borderWidth = 1.0
                    self.emailCheckTextField.layer.borderColor = UIColor.blue.cgColor
                    self.emailCheckTextField.isEnabled = false
                    self.emailCheckButton.isEnabled = false
                    // - [x] 타이머 멈추기!
                    self.timerReset()
                    self.didCheckEmail = true
                }
            } else {
                print("통신 실패!!")
            }
        }
    }
    
    private func requestSignup(nickName: String, email: String, password: String) {
        // - [x] 회원가입 API 호출
        Account.shared.signup(userNickName: nickName, userEmail: email, userPassword: password) { (success, data) in
            if success {
                guard let userAccount = data as? SignupModel else { return }
                if userAccount.success {
                    DispatchQueue.main.async {
                        // - [ ] 로그인까지 자동으로 하자~~
                        self.dismiss(animated: true)
                    }
                    // - [x] 사용자 이메일, 로그인 방식은 UserDefaults에 저장
                    UserDefaults.standard.set(email, forKey: UserDefaultsModel.email.rawValue )
                    UserDefaults.standard.set(userAccount.result?.userData?.loginMethod, forKey: UserDefaultsModel.loginMethod.rawValue )
                    // - [x] 사용자 AT, RT는 Keychain에 저장
                    if let accessToken = userAccount.result?.accessToken {
                        if !KeychainManager.shared.create(accessToken, userEmail: email, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                            // - [ ] 저장이 안될 경우 예외처리 할 것.
                            print("Signup : AT 저장이 안되었따.")
                        }
                    }
                    if let refreshToken = userAccount.result?.refreshToken {
                        if !KeychainManager.shared.create(refreshToken, userEmail: email, itemLabel: UserDefaultsModel.refreshToken.rawValue) {
                            // - [ ] 저장이 안될 경우 예외처리 할 것.
                            print("Signup : RT 저장이 안되었따.")
                        }
                    }
                    print( KeychainManager.shared.read(userEmail: email, itemLabel: UserDefaultsModel.refreshToken.rawValue) as Any )
                    
                }
            } else {
                print("통신 실패...")
            }
        }
    }
    
    
    
}

// MARK: - TextField Delegate Extension.
extension SignupVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.emailTextField.isEditing {
            print("이메일 텍스트 입력중")
            self.emailAuthenticationRequestButton.isEnabled = true
            self.emailAuthenticationRequestButton.backgroundColor = UIColor(named: "primaryColor")
//            self.emailAuthenticationRequestButton.setTitleColor(UIColor(named: "White color"), for: .normal)
        } else if self.emailCheckTextField.isEditing {
            print("이메일 체크 텍스트 입력중")
            self.emailCheckButton.isEnabled = true
            self.emailCheckButton.backgroundColor = UIColor(named: "primaryColor")
//            self.emailAuthenticationRequestButton.setTitleColor(UIColor(named: "White color"), for: .normal)
        } else { return }
    }
    
    func setTextFieldDelgate() {
        self.emailTextField.delegate = self
        self.emailCheckTextField.delegate = self
    }
    
    func animateTextFieldBorderColor(userTextField: UITextField, color: UIColor) {
        userTextField.layer.borderWidth = 1.0
        userTextField.layer.borderColor = color.cgColor
        UIView.animate(withDuration: 2.0, animations: {
            userTextField.layer.borderWidth = 0
        })
    }
}
