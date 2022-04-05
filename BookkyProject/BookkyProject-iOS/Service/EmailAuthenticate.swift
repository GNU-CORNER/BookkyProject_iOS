//
//  EmailAuthenticate.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/05.
//

import Foundation

class EmailAuthenticate {
    static let shared = EmailAuthenticate()
    var baseURL = "http://203.255.3.144:8002/v1"
    
    func authenticateCodeSender(userEmail: String, completionHandler: @escaping(Bool, Any) -> Void) {
        // URLSessionConfiguraion 생성, .default로만 생성 가능
        let session = URLSession(configuration: URLSessionConfiguration.default)

        guard let url = URL(string: baseURL + "/user/email") else {
            print("Error: Cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": userEmail], options: [])
        
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
                print(error)
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
            
        }.resume()
    }
    
    func validateCode() {
        
    }
}
