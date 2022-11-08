//
//  HomeDeleteSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/05.
//

import Foundation
class HomeReviewDeleteAPI {
    static let shared = HomeReviewDeleteAPI()
    func DeletPost(RID : Int,completionHandler : @escaping(Bool, Any) -> Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
        else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }

        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.bookDeleteReview+"\(RID)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Review Delte sender. \(String(describing: error))")
                return
            }
            guard let response = response as? HTTPURLResponse else {return}
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
            
            if response.statusCode == 401 {
                completionHandler(false, response.statusCode)
            }
        }.resume()
    }

}
