//
//  GetDataSerVice.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import Foundation
let url = "http://app.bookky.org:8002/v1/home"
class GetBookData {
    static var shared = GetBookData()
    func getBookData(completion: @escaping(Bool,Any)->Void){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: url) else{
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
       
            guard let  data = data , let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("\(String(describing: error))")
           
                return
            }
            do {
                let bookData = try JSONDecoder().decode(BookInformation.self, from: data)
                completion(true,bookData)
          
            }catch(let err) {
                print("Decoding Error")
                print(err.localizedDescription)
            }
        }.resume()
    }
}
//func getBookData(){
//   let session = URLSession.shared
//   guard let  requestURL = URL(string: url) else {return}
//   session.dataTask(with: requestURL) { data, response, error in
//               guard error == nil else {
//                   //error 가 nil 이면 데이터가 받아와지는것
////                        debugPrint(error?.localizedDescription)
//                   //경고 떠서 주석처리해놓음  경고 제거 필요 error 발생시 print
//                   return
//               }
//                print("\(error)")
//               if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
//                   do {
//                       let bookData = try JSONDecoder().decode(BookInformation.self, from: data)    //BookInformation 은 서버에서 받아오는 데이터의 구조체
//
//                       self.bookList = bookData.result.bookList
//                       print("\(self.bookList)")
//                       DispatchQueue.main.async {
//                           self.bookCollectionView.reloadData()
//                       }
//                   } catch(let err) {
//                       print("Decoding Error")
//                       print(err.localizedDescription)
//                   }
//               }
//           }.resume()
//   }
