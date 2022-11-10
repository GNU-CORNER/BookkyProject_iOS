//
//  CommunityPostDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/02.
//

import Foundation
import Combine
class CommunityPostAPI {
    static let shared = CommunityPostAPI()
    // MARK: - 글작성 , 답글도 포함
    func postCommunityWrite(textTitle : String , textContent : String ,CommunityBoardNumber : Int ,parentQPID : Int,TBID:Int,thumbnail : [String],completionHandler : @escaping(Bool, Any) -> Void){
        var encodedThumbnailArr : [String] = []
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        for i in thumbnail{
            let encodedThumbnail = "data:image/png;base64," + i
            encodedThumbnailArr.append(encodedThumbnail)
        }
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        let httpBody : [String:Any] = ["title":textTitle,"contents":textContent ,"TBID":TBID,"parentQPID":parentQPID,"Images":encodedThumbnailArr]
        
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
            guard let response = response as? HTTPURLResponse else {return}
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
            if response.statusCode >= 200 && response.statusCode <= 300{
                completionHandler(true, response.statusCode)
            }
            if response.statusCode == 401 {
                completionHandler(false, response.statusCode)
            }
            
        }.resume()
        
    }
    // MARK: - 댓글 작성 // 대댓글도 포함
    func postCommunityCommentWrite(comment : String , parentID : Int ,CommunityBoardNumber : Int ,PID : Int,completionHandler : @escaping(Bool, Any) -> Void){
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
        let httpBody : [String:Any] = ["comment":comment,"parentID":parentID ,"PID":PID]
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityCommetPostURL+"\(CommunityBoardNumber)") else {
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
            guard let response = response as? HTTPURLResponse else {return}
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
            if response.statusCode >= 200 && response.statusCode <= 300{
                completionHandler(true, response.statusCode)
            }
            if response.statusCode == 401 {
                completionHandler(false, response.statusCode)
            }
        }.resume()
    }
    func LikeCommunityPost(CommunityBoardNumber : Int ,PID : Int,completionHandler : @escaping(Bool, Any) -> Void){
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
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityLikePost+"\(CommunityBoardNumber)/\(PID)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Community Write sender. \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode >= 200 && response.statusCode <= 300{
                completionHandler(true, response.statusCode)
            }
            if response.statusCode == 401 {
                completionHandler(false, response.statusCode)
            }
        }.resume()
    }
    func LikeCommunityComment(CommunityBoardNumber : Int ,CID : Int,completionHandler : @escaping(Bool, Any) -> Void){
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

        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityLikeComment+"\(CommunityBoardNumber)/\(CID)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Community Write sender. \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode >= 200 && response.statusCode <= 300{
                completionHandler(true, response.statusCode)
            }
            if response.statusCode == 401 {
                completionHandler(false, response.statusCode)
            }
        }.resume()
    }
    
}
