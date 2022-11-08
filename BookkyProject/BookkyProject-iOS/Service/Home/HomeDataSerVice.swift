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
    func getBookData(accessToken: String,view: UIViewController, completion: @escaping(Bool,Any,Int)->Void){
        print("token:\n\(accessToken)")
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.HomeURL) else{
            print("Error: Cannot Create URL")
            return
        }
                var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("\(accessToken)", forHTTPHeaderField: "access-token")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let  data = data , let response = response as? HTTPURLResponse else {
                print("\(String(describing: error))")
                return
            }
            do {
                let bookData : BookInformation = try JSONDecoder().decode(BookInformation.self, from: data)
                completion(bookData.success,bookData,response.statusCode)
            }catch{
                print("Decoding Error")
                print("\(String(describing: error.localizedDescription))")
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
            
            guard let  data = data , let response = response as? HTTPURLResponse else {
                print("\(String(describing: error))")
                return
            }
            do {
                let tagBookData = try JSONDecoder().decode(TagInformation.self, from: data)
                completion(true,tagBookData)
            }
            catch(let err) {
                print("\(response.statusCode)statusCode")
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
    // 책 클릭시 책상세정보 API
    func getDetailBookData(BID:Int,accessToken: String,completion: @escaping(Bool,Any,Int)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.bookDetatilURL+"\(BID)")else{
            
            print("Error : Can not Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("\(accessToken)", forHTTPHeaderField: "access-token")
        
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            
            guard let  data = data , let response = response as? HTTPURLResponse else {
                print("\(String(describing: error))")
                return
            }
            do {
                let DetailBookData = try JSONDecoder().decode(BookDetailInformation.self, from: data)
                completion(DetailBookData.success,DetailBookData,response.statusCode)
            }
            catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
                
            }
        }.resume()
    }
    //책상세 정보 리뷰 API
    func getBookDetailReviewData(BID : Int ,accessToken:String,completion : @escaping(Bool,Any,Int) -> Void){
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.bookDetailReview+"\(BID)") else {
            print("Error: Cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(accessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            guard let  data = data , let response = response as? HTTPURLResponse else {
                print("\(String(describing: error))")
                return
            }
            do {
                let detailBookReviewData = try JSONDecoder().decode(BookDetailReviewInformation.self, from: data)
                completion(detailBookReviewData.success,detailBookReviewData,response.statusCode)
            }
            catch{
                if response.statusCode == 204 {
                }else {
                    print("Decoding Error")
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    // tagMoreView Api
    func getTagMoreViewBookData(accessToken:String,completion: @escaping(Bool,Any,Int)->Void){
      
        let session = URLSession(configuration: .default)
        guard let url = URL(string: BookkyURL.baseURL+BookkyURL.tagMoreViewURL) else{
            print("Error: Cannot Create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(accessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        session.dataTask(with: request) { (data,response,error) in
            guard error == nil else {
                print("Error: error.")
                return
            }
            //            print("\(error)")
            guard let  data = data , let response = response as? HTTPURLResponse else {
                print("\(String(describing: error))")
                return
            }
            do {
                let bookData = try JSONDecoder().decode(TagMoreViewBookInformation.self, from: data)
                completion(bookData.success,bookData,response.statusCode)
                //                debugPrint("\(bookData)")
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
}



