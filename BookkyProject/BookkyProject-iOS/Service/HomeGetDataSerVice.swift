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
   
}

