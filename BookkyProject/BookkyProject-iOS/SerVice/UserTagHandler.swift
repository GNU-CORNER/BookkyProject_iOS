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
    
    func userTagsUpdate() {
        
    }
}
