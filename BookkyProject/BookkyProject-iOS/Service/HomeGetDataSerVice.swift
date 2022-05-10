//
//  GetDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import Foundation
import UIKit
let accessTokenHome = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzX3Rva2VuIiwiZXhwIjoxNjUyMTk2MzMyLCJVSUQiOjcwfQ.BxKDD0LsAmVE_q7eeWp1-hJhTus4N34fO0D-oCRD0aM"
class GetBookData {
    static var shared = GetBookData()
    //메인화면 API
    func getBookData(completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.HomeURL) else{
            print("Error: Cannot Create URL")
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
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.bookDetailReview+"\(BID)") else {
            print("Error: Cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("\(accessTokenHome)", forHTTPHeaderField: "access-token")
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
    
}

