//
//  GetDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import Foundation
import UIKit
let Homeurl = "http://app.bookky.org:8002/v1/home"
class GetBookData {
    static var shared = GetBookData()
    func getBookData(completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: Homeurl) else{
            print("Error: Cannot Create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
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
}

