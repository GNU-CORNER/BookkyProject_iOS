//
//  MyProfileAPI.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/10.
//

import Foundation

class MyProfileAPI {
    
    static var shared = MyProfileAPI()
    
    func myprofile(accessToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let myprofileURL = URL(string: BookkyURL.baseURL + BookkyURL.myprofilePath) else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: myprofileURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error: Email Sender. \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Error: Email Sender Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: MyprofileModel = try JSONDecoder().decode(MyprofileModel.self, from: data)
                print("myprofile: 통신 완료. response.")
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: Email Sender Decode Error. \(String(describing: error))")
            }
        }.resume()

    }
    
    
    
}
