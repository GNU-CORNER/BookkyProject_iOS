//
//  BooksAPI.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/04.
//

import Foundation

class Books {
    static var shared = Books()
    
    func booksSearch(keyword: String, quantity: Int, page: Int, completionHandler: @escaping(Bool, Any?, Int, Int?) -> Void) {
        let session = URLSession(configuration: .default)
        guard var booksSearchComponents = URLComponents(string: BookkyURL.baseURL + BookkyURL.booksSearchPath) else {
            print("Books Search: Cannot Create URLComponents.")
            return
        }
        booksSearchComponents.queryItems = [
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "quantity", value: String(quantity)),
            URLQueryItem(name: "page", value: String(page))
        ]
        guard let booksSearchURL = booksSearchComponents.url else {
            print("Books Search: Cannot Create URL.")
            return
        }
        
        var request = URLRequest(url: booksSearchURL)
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Books Search: Error. \(error.debugDescription)")
                return
            }
            guard let data = data else {
                print("Books Search: Data Error.")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Books Search: HTTP request failed.")
                return
            }

            do {
                let decodedData: SearchModel = try JSONDecoder().decode(SearchModel.self, from: data)
                completionHandler(decodedData.success, decodedData, response.statusCode, decodedData.result?.total)
            } catch {
                print("Books Search: Decode Error.")
                print(error.localizedDescription)
                completionHandler(false, nil, response.statusCode, nil)
            }
        }.resume()
    }
}
