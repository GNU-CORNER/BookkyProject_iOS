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
        let httpBody: [String:Any] = [
            "email":userEmail, "nickname":userNickName,
            "pwToken":userPassword,
            "loginMethod": slug
        ]
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL + "/user/signup") else {
            print("Error: Cannot Create URL")
            return
        }  /// slug 번호 따로 줘야하는지 확인
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: Email Sender Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: SignupModel = try JSONDecoder().decode(SignupModel.self, from: data)
                completion(true, decodedData)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    func login() {
        
    }
    
    func logout() {
        
    }
    
    private func userDelete() {
        
    }
}
