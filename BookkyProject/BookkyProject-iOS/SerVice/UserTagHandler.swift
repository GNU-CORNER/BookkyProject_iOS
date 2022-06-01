//
//  UserTagHandler.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/01.
//

import Foundation

class UserTagHandler {
    static var shared = UserTagHandler()
    
    func tags(completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: .default)
        guard let tagsURL = URL(string: BookkyURL.baseURL + BookkyURL.tagsPath) else {
            print("Tags: Cannnot Create URL.")
            return
        }
        var request = URLRequest(url: tagsURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Tags: Error. \(error.debugDescription)")
                return
            }
            guard let data = data else {
                print("Tags: Data Cannot Optional Unwrapping.")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Tags: HTTP Request Failed.")
                return
            }
            do {
                let decodedData: TagsModel = try JSONDecoder().decode(TagsModel.self, from: data)
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Tags: Decode Error.")
            }
        }.resume()
    }
    
    func userTagsUpdate(_ tagArray: [Int], _ accessToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        // - [] 서버와 통신
        let session = URLSession(configuration: .default)
        guard let userTagsUpdateURL = URL(string: BookkyURL.baseURL + BookkyURL.userTagsPath) else {
            print("User Tags: Cannot Create URL.")
            return
        }
        let userTagsUpdateHttpBody: [String: Array] = [
            "tag":tagArray
        ]
        
        var request = URLRequest(url: userTagsUpdateURL)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: userTagsUpdateHttpBody, options: [])
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("User Tags: Error. \(error.debugDescription)")
                return
            }
            guard let data = data else {
                return
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            do {
                let decodedData: TagsSettingModel = try JSONDecoder().decode(TagsSettingModel.self, from: data)
                print("User Tags: NICE~~~~~~YEAH~~~~~")
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("User Tags: Decode Error.")
                print("\(response.statusCode)")
//                print("\(response.debugDescription)")
            }
        }.resume()
    }
}
