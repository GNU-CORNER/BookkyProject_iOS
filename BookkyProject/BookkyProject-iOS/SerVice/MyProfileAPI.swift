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
                print("Error: myprofile Sender. \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("Error: myprofile Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: MyprofileModel = try JSONDecoder().decode(MyprofileModel.self, from: data)
                print("myprofile: 통신 완료. response.")
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("Error: myprofile Decode Error. \(String(describing: error))")
            }
        }.resume()

    }
    
    func favoriteBooks(accessToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let myprofileURL = URL(string: BookkyURL.baseURL + BookkyURL.favoriteBookPath + "0") else {
            print("My Favorite Books: Cannot create URL")
            return
        }
        print("\(BookkyURL.baseURL + BookkyURL.favoriteBookPath)")
        var request = URLRequest(url: myprofileURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("My Favorite Books: \(String(describing: error))")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("My Favorite Books: Http Request Failed. \(String(describing: error))")
                return
            }
            do {
                let decodedData: MyprofileModel = try JSONDecoder().decode(MyprofileModel.self, from: data)
                print("v: 통신 완료.")
                completionHandler(decodedData.success, decodedData, response.statusCode)
            } catch {
                print("My Favorite Books: Decode Error. \(String(describing: error))")
            }
        }.resume()
    }
    
    func myReviews(accessToken: String, completionHandler: @escaping(Bool, Any, Int) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let myprofileURL = URL(string: BookkyURL.baseURL + BookkyURL.myReviewsPath) else {
            print("Cannot create URL")
            return
        }
        print("\(myprofileURL)")
        var request = URLRequest(url: myprofileURL)
        print("\(myprofileURL)")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "access-token")
        print("오호")
        session.dataTask(with: request) { (data, response, error) in
            print(1)
            guard error == nil else {
                print("My Reviews: \(error.debugDescription)")
                return
            }
            print(2)
            guard let myReviewsData = data, let myReviewsReseponse = response as? HTTPURLResponse else {
                print("My Reviews: Http Request Failed. \(error.debugDescription)")
                return
            }
            print(3)
            do {
                let decodedMyReiviewData: MyprofileModel = try JSONDecoder().decode(MyprofileModel.self, from: myReviewsData)
                print("My Reviews: 통신 완료")
                completionHandler(decodedMyReiviewData.success, decodedMyReiviewData, myReviewsReseponse.statusCode)
            } catch {
                print(myReviewsReseponse.statusCode)
                print(myReviewsData)
                print("My Reviews: Decode Error.")
            }
        }.resume()
        print(4)
    }
    
}
