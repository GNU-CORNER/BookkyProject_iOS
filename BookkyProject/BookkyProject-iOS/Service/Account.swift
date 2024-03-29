//
//  Account.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/05.
//

import Foundation
import UIKit

class Account {
    static var shared = Account()
    
    // MARK: - Signup
    func signup(userNickName: String, userEmail: String, userPassword: String, completion: @escaping(Bool, Any) -> Void) {
        let slug = "0"
        let singupHttpBody: [String:Any] = [
            "email":userEmail,
            "nickname":userNickName,
            "pwToken":userPassword,
            "loginMethod": slug
        ]
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL + BookkyURL.signupURL) else {
            print("Error: Cannot Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: singupHttpBody, options: [])
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Error: Email Sender Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
                print(response.statusCode)
                completion(true, decodedData)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    // MARK: - Login(Signin)
    func login(userEmail: String, userPassword: String, completion: @escaping(Bool, Any, Int) -> Void) {
        let slug = "0"
        let signInHttpBody: [String:Any] = [
            "email":userEmail,
            "pwToken":userPassword,
            "loginMethod": slug,
        ]
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL + BookkyURL.signinURL) else {
            print("Error: Cannot Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: signInHttpBody, options: [])
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                if let response = response as? HTTPURLResponse {
                    print("Error: Email Sender Http Request Failed.")
                    print( response.statusCode )
                    print("로그인 실패(400), 해당 내용 사용자에게 꼭 알려줘야함")
                }
                return
            }
            print( response.debugDescription )
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
                completion(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    // MARK: - Signout
    func signout(_ accessToken: String, _ refreshToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        // - [x] API 호출. 이 함수를 호출한 곳에 컴플리션 핸들러 넘겨주기 (거기서 Keychain, UserDefault 모두 초기화 해주기!)
        let session = URLSession(configuration: .default)
        guard let signoutURL = URL(string: BookkyURL.baseURL + BookkyURL.signoutPath) else {
            print("Signout: Cannot Create URL.")
            return
        }
        var request = URLRequest(url: signoutURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        request.setValue(refreshToken, forHTTPHeaderField: "refresh-token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Signup: HTTP Request failed.")
                return
            }
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
                print(decodedData.errorMessage)
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("\(response.statusCode)")
                print("Signup: Decode Error.")
            }
        }.resume()
    }
    
    // MARK: - Withdrawal
    private func Withdrawal(accessToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: .default)
        guard let withdrawalURL = URL(string: BookkyURL.baseURL + BookkyURL.userPath) else {
            print("Withdrawal: Cannot Create URL.")
            return
        }
        var request = URLRequest(url: withdrawalURL)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Withdrawal: Error. \(error.debugDescription)")
                return
            }
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
                print(decodedData.errorMessage)
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print(response.statusCode)
                print("Withdrawal: Decode Error.")
            }
        }.resume()
    }
    
    // MARK: - Refresh Access-Token (Auth)
    func refreshAuth(accessToken: String, refreshToken: String, completion: @escaping(Bool, Any, Int) -> Void) {
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL + BookkyURL.refreshURL) else {
            print("Error: Cannot Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        request.setValue(refreshToken, forHTTPHeaderField: "refresh-token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error.")
                print(error!)
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                if let response = response as? HTTPURLResponse {
                    print("Error: Email Sender Http Request Failed.")
                    print( response.statusCode )
                }
                return
            }
            do {
                let decodedData: RefreshModel = try JSONDecoder().decode(RefreshModel.self, from: data)
                print("Account-refreshAuth: response 받아옴")
                completion(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    // MARK: - Duplicate Nickname Check
    func duplicateNicknameCheck(nickname: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: .default)
        guard var nicknameCheckComponet = URLComponents(string: BookkyURL.baseURL + BookkyURL.nicknameCheckPath) else {
            // - [ ] 닉네임 URL 생성 안되는 것 예외처리
            print("Duplicate Nickname Check: Cannot Create URL.")
            return
        }
        nicknameCheckComponet.queryItems = [
            URLQueryItem(name: "nickname", value: nickname)
        ]
        guard let nicknameCheckURL = nicknameCheckComponet.url else {
            return
        }
        var request = URLRequest(url: nicknameCheckURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Duplicate Nickname Check: Sender Error. \(error.debugDescription)")
                return
            }
            guard let nicknameCheckData = data, let response = response as? HTTPURLResponse else {
                print("Duplicate Nickname Check: HTTP Request Failed.")
                return
            }
            do {
                let decodedNicknameCheckData: MyprofileModel = try JSONDecoder().decode(MyprofileModel.self, from: nicknameCheckData)
                completionHandler(decodedNicknameCheckData.success, decodedNicknameCheckData, response.statusCode)
            } catch {
                print("Duplicate Nickname Check: Decode Error.")
            }
        }.resume()
    }
    
}


extension Account {
    
    func requestRefreshAuth() {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }

        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
              let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }

        print("갱신요청")
        Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
            print(success)
            guard let tokens = data as? RefreshModel else { return }
            if success {

                if let newAccessToken = tokens.result?.accessToken {
                    let statusUpdateAccessToken = KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
                    print(statusUpdateAccessToken)
                    print(newAccessToken)
                    if !statusUpdateAccessToken {
                        print("Launch: 새로운 토큰 제대로 저장되지 않았습니다.")
                    }
                }
            } else {
                if statuscode == 400 {
                    // 유효한 토큰입니다.
                    print(tokens.errorMessage)
                } else if statuscode == 403 {
                    // 기간이 지난 토큰입니다.
                    print(tokens.errorMessage)
                }
            }
        }
    }
    
    func requestSignout(vc: UIViewController) {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Signout: 사용자 이메일을 불러올 수 없음.")
            return
        }

        guard let accessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
              let refreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
            print("Signout: 토큰을 불러올 수 없음.")
            return
        }
        
        Account.shared.signout(accessToken, refreshToken) { (success, data, statuscode) in
            if success {
                let alert = UIAlertController(title: "로그아웃 되었습니다.", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
//                    let homeStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//                    guard let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "Home") as? HomeViewController else {return}
//                    homeVC.bookListTableView.reloadData()
                    vc.tabBarController?.selectedIndex = 0
                    vc.navigationController?.popViewController(animated: false)
                    
                }
                alert.addAction(okAction)
                // - [] AT, RT, email 삭제하기
                UserDefaults.standard.removeObject(forKey: UserDefaultsModel.email.rawValue)
                
                if KeychainManager.shared.delete(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) && KeychainManager.shared.delete(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) {
                    DispatchQueue.main.async {
                        vc.present(alert, animated: true)
                    }
                } else {
                    print("AT, RT 삭제가 안되었는데영..")
                }
            } else {
                print("로그아웃이 잘 안되었습니다.")
                print("\(statuscode)")
            }
        }
    }
    
    func requestWithdrawal(vc: UIViewController) {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Signout: 사용자 이메일을 불러올 수 없음.")
            return
        }

        guard let accessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("Signout: 토큰을 불러올 수 없음.")
            return
        }
        
        Account.shared.Withdrawal(accessToken: accessToken) { (success, data, statuscode) in
            if success {
                let alert = UIAlertController(title: "회원탈퇴 되었습니다.", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
                    vc.tabBarController?.selectedIndex = 0
                    vc.navigationController?.popViewController(animated: false)
                }
                alert.addAction(okAction)
                // - [] AT, RT, email 삭제하기
                UserDefaults.standard.removeObject(forKey: UserDefaultsModel.email.rawValue)
                
                if KeychainManager.shared.delete(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) && KeychainManager.shared.delete(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) {
                    DispatchQueue.main.async {
                        vc.present(alert, animated: true)
                    }
                } else {
                    print("AT, RT 삭제가 안되었는데영..")
                }
            } else {
                
            }
        }
    }
    
}
