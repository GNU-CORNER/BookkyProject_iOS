//
//  Account.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/05.
//

import Foundation

class Account {
    static var shared = Account()
    
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
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
//                print(decodedData)
                completion(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    func logout() {
        
    }
    
    private func userDelete() {
        
    }
    
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
            guard let data = data, let response = response as? HTTPURLResponse/*, (200..<300) ~= response.statusCode */else {
                if let response = response as? HTTPURLResponse {
                    print("Error: Email Sender Http Request Failed.")
                    print( response.statusCode )
                }
                return
            }
            do {
                let decodedData: RefreshModel = try JSONDecoder().decode(RefreshModel.self, from: data)
                print("Account-refreshAuth: response 받아옴")
                print(response.statusCode)
                print(decodedData)
                completion(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
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
                        print("Launch: 새로운 토큰 제대로 저장이 안되었어요~~~~")
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
    
}
