//
//  CommunityDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/03.
//

import Foundation
import UIKit


class CommunityAPI {
    static let shared = CommunityAPI()
    func getCommunityWriteList(CommunityBoardNumber:Int ,pageCount : Int ,completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityPostListGetURL+"\(CommunityBoardNumber)?"+"page=\(pageCount)") else {
            print("Error : Cannot create URL")
            return
        }
        //        print("\(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error : error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode
            else{
                print("\(String(describing: error))")
                return
            }
            do {
                let CommunityWriteList = try JSONDecoder().decode(WriteListInformation.self, from: data)
                completion(true,CommunityWriteList)
            }
            
            catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    func getCommunityTextDetail(CommunityBoardNumber:Int ,PID : Int,completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityTextDetail+"\(CommunityBoardNumber)/"+"\(PID)") else {
            print("Error : Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error : error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode
            else{
                print("\(String(describing: error))")
                return
            }
            do {
                let CommunityTextDetail = try JSONDecoder().decode(WriteTextDetailInformation.self, from: data)
                completion(true,CommunityTextDetail)
            }
            
            catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    func postCommunityWrite(textTitle : String , textContent : String ,CommunityBoardNumber : Int,completionHandler : @escaping(Bool, Any) -> Void){
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
//    func getCommunityTextDetail(PID : Int,completion : @escaping(Bool, Any) -> Void){
//        let session = URLSession(configuration: .default)
//        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityTextDetail+"\(CommunityBoardNumber)/"+"\(PID)") else {
//            print("Error : Cannot create URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "accept")
//        session.dataTask(with: request) { (data, response, error) in
//            guard error == nil else {
//                print("Error : error.")
//                return
//            }
//            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode
//            else{
//                print("\(String(describing: error))")
//                return
//            }
//            do {
//                let CommunityTextDetail = try JSONDecoder().decode(WriteTextDetailInformation.self, from: data)
//                completion(true,CommunityTextDetail)
//            }
//
//            catch(let err){
//                print("Decoding Error")
//                print(err.localizedDescription)
//            }
//        }.resume()
//
//    }
}



