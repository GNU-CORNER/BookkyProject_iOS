//
//  CommunityUpdateService.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/06.
//

import Foundation
class CommunityUpdateAPI{
    static let shared = CommunityUpdateAPI()
    //글수정
    func UpdateCommunityWrite(textTitle : String , textContent : String ,CommunityBoardNumber : Int ,parentQPID : Int,TBID:Int,thumbnail : [String],completionHandler : @escaping(Bool, Any) -> Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
        else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        let httpBody : [String:Any] = ["title":textTitle,"contents":textContent ,"TBID":TBID,"PID":parentQPID,"Images":thumbnail]
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityUpdatePostURL+"\(CommunityBoardNumber)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Community Update POST. \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
        }.resume()
    }
    func UpdateCommunityComment(textContent : String ,CommunityBoardNumber : Int ,parentQPID : Int,CID:Int,completionHandler : @escaping(Bool, Any) -> Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
        else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        let httpBody : [String:Any] = ["comment":textContent ,"PID":parentQPID,"CID":CID]
        print("\(httpBody)갱")
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.communityUpdateCommentURL+"\(CommunityBoardNumber)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Community Update POST. \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")
            }
        }.resume()
    }
}
