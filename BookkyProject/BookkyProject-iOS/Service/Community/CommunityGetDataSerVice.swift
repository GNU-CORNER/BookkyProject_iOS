//
//  CommunityDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/03.
//

import Foundation
import UIKit


class CommunityGetAPI {
    static let shared = CommunityGetAPI()
    func getCommunityWriteList(CommunityBoardNumber:Int ,pageCount : Int ,completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityPostListGetURL+"\(CommunityBoardNumber)?"+"page=\(pageCount)") else {
            print("Error : Cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        if CommunityBoardNumber == 3 {
            guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                print("Launch: 사용자 이메일을 불러올 수 없음.")
                return
            }
            guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
            else {
                print("Launch: 토큰을 불러올 수 없음.")
                return
            }
            request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        }
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
            do{
                let CommunityWriteList = try JSONDecoder().decode(WriteListInformation.self, from: data)
                completion(true,CommunityWriteList)
            }catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    func getCommunityWriteQnAList(CommunityBoardNumber:Int ,pageCount : Int ,completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityPostListGetURL+"\(CommunityBoardNumber)?"+"page=\(pageCount)") else {
            print("Error : Cannot create URL")
            return
        }
        //                print("\(url)")
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
                let CommunityWriteList = try JSONDecoder().decode(WriteListQnAInformation.self, from: data)
                completion(true,CommunityWriteList)
            }
            catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    // MARK: - 내글 보기.
    //DataFormat달라서 또 API만들어 줘야한다....
    func getCommunityMyWriteList(CommunityBoardNumber:Int ,pageCount : Int ,completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityPostListGetURL+"\(CommunityBoardNumber)?"+"page=\(pageCount)") else {
            print("Error : Cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
        else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
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
            do{
                let CommunityWriteList = try JSONDecoder().decode(PostListMyInformation.self, from: data)
                completion(true,CommunityWriteList)
            }catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    
    // MARK: - Hot
    func getCommunityPostListHot(completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityHotPostListGetURL) else {
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
                let CommunityPostListHot = try JSONDecoder().decode(PostListHotInformation.self, from: data)
                completion(true,CommunityPostListHot)
            }
            catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    // MARK: -게시글상세
    func getCommunityTextDetail(CommunityBoardNumber:Int ,PID : Int,completion : @escaping(Bool, Any) -> Void){
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
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityTextDetail+"\(CommunityBoardNumber)/"+"\(PID)") else {
            print("Error : Cannot create URL")
            return
        }
        //        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityTextDetail+"\(CommunityBoardNumber)/"+"\(PID)") else {
        //            print("Error : Cannot create URL")
        //            return
        //        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
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
                if CommunityBoardNumber == 2 {
                    let CommunityTextQnADetail = try JSONDecoder().decode(WriteTextDetailQnAInformation.self, from: data)
                    completion(true,CommunityTextQnADetail)
                }else {
                    let CommunityTextDetail = try JSONDecoder().decode(WriteTextDetailInformation.self, from: data)
                    completion(true,CommunityTextDetail)
                }
                
            }
            catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    // MARK: -Q&A에서 댓글
    func getCommunityQnAComment(CommunityBoardNumber:Int ,PID : Int,completion : @escaping(Bool, Any) -> Void){
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
        let session = URLSession(configuration:.default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.communityQnACommentGetURL+"\(CommunityBoardNumber)/"+"\(PID)") else {
            print("Error : Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else{
                print("Error:error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else{
                print("\(String(describing: error))")
                return
            }
            do {
                let QnACommunityCommentData = try JSONDecoder().decode(QnACommentDataInformation.self, from: data)
                completion(true, QnACommunityCommentData)
            }catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
    func getCommunitySearchPost(searchText:String, completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration:.default)
        let urlString = String(BookkyURL.baseURL+BookkyURL.communitySearchPostURL+"\(searchText)")
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encodedString) else {
            print("Error : Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else{
                print("Error:error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else{
                print("\(String(describing: error))")
                return
            }
            do {
                let SearchPostData = try JSONDecoder().decode(PostSearchModel.self, from: data)
                completion(true, SearchPostData)
            }catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    func getCommunitySearchBook(searchText:String, completion : @escaping(Bool, Any) -> Void){
        let session = URLSession(configuration:.default)
        let urlString = String(BookkyURL.baseURL+BookkyURL.communitySearchBookURL+"\(searchText)")
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encodedString) else {
            print("Error : Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else{
                print("Error:error.")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode else{
                print("\(String(describing: error))")
                return
            }
            do {
                let SearchBookData = try JSONDecoder().decode(BookSearchInformation.self, from: data)
                completion(true, SearchBookData)
            }catch(let err){
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
        
    }
}



