//
//  GetDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import Foundation
import UIKit

class GetBookData {
    static var shared = GetBookData()
    //메인화면 API
    func getBookData(completion: @escaping(Bool,Any)->Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        print(userEmail)
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)else {
            print("Launch: AccessToken토큰을 불러올 수 없음.")
            return
        }
        print("token\n\(previousAccessToken)")
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.HomeURL) else{
            print("Error: Cannot Create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            //            print("\(error)")
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let bookData = try JSONDecoder().decode(BookInformation.self, from: data)
                completion(true,bookData)
                //                debugPrint("\(bookData)")
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    //Tag클릭시 API
    func getTagBookData(TID:Int,completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.tagURL+"\(TID)")else{
            
            print("Error : Can not Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let tagBookData = try JSONDecoder().decode(TagInformation.self, from: data)
                completion(true,tagBookData)
                
            }
            catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    // 책 클릭시 책상세정보 API
    func getDetailBookData(BID:Int,completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.bookDetatilURL+"\(BID)")else{
            
            print("Error : Can not Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let DetailBookData = try JSONDecoder().decode(BookDetailInformation.self, from: data)
                completion(true,DetailBookData)
                
            }
            catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    //책상세 정보 리뷰 API
    func getBookDetailReviewData(BID : Int ,completion : @escaping(Bool, Any) -> Void){
        
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        print(userEmail)
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)else {
            print("Launch: AccessToken토큰을 불러올 수 없음.")
            return
        }
//        guard let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
//            print("Launch: RefreshToken 토큰을 불러올 수 없음.")
//            return
//        }
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.bookDetailReview+"\(BID)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let detailBookReviewData = try JSONDecoder().decode(BookDetailReviewInformation.self, from: data)
                completion(true,detailBookReviewData)
            }
            
            catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    // tagMoreView Api
    func getTagMoreViewBookData(completion: @escaping(Bool,Any)->Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        print(userEmail)
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)else {
            print("Launch: AccessToken토큰을 불러올 수 없음.")
            return
        }
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.tagMoreViewURL) else{
            print("Error: Cannot Create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            //            print("\(error)")
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
                return
            }
            do {
                let bookData = try JSONDecoder().decode(TagMoreViewBookInformation.self, from: data)
                completion(true,bookData)
                //                debugPrint("\(bookData)")
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
}

class BookReviewAPi{
    static var shared = BookReviewAPi()
    func postBookReViewWrite(textTitle : String , textContent : String ,CommunityBoardNumber : Int,completionHandler : @escaping(Bool, Any) -> Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
      
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
//              let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue)
        else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        let httpBody : [String:Any] = ["title":textTitle,"contents":textContent]
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityWritePostURL+"\(CommunityBoardNumber)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Community Write sender. \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
        }.resume()
    }
}
