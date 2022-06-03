//
//  EmailAuthenticate.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/05.
//

import Foundation

/// 비슷한 코드가 반복되는데 하나의 함수로 만들 수는 없을까?
class EmailAuthenticate {
    static let shared = EmailAuthenticate()
    
    func authenticateCodeSender(userEmail: String, completionHandler: @escaping(Bool, Any) -> Void) {
        // URLSessionConfiguraion 생성, .default로만 생성 가능
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard var urlComponent = URLComponents(string: BookkyURL.baseURL + "/user/email") else {
            print("Error: Cannot create URL")
            return
        }

        let email = userEmail.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        urlComponent.queryItems = [
            URLQueryItem(name: "email", value: email)
        ]
        guard let url = urlComponent.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: Email Sender. \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: Email Sender Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: EmailAuthModel = try JSONDecoder().decode(EmailAuthModel.self, from: data)
                completionHandler(true, decodedData)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    func validateCode(userEmail: String, code: Int, completionHandler: @escaping(Bool, Any) -> Void) {
        let httpBody: [String: Any] = ["email": userEmail, "code": code]
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL + "/user/check") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: Email Sender. \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: Email Sender Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: EmailAuthCheckModel = try JSONDecoder().decode(EmailAuthCheckModel.self, from: data)
                completionHandler(true, decodedData)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
}
