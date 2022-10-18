//
//  ReportPostAPI.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/10/18.
//

import Foundation
import Alamofire
class ReportPostAPi{
    static let shared = ReportPostAPi()
    func postReportAPI(CID : Int , PID :Int ,communityType : Int ,completionHandler : @escaping(Bool, Any) -> Void){
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return
        }
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
         else {
            print("Launch: 토큰을 불러올 수 없음.")
            return
        }
        
        var reportType : Int = -1
        if CID == 0 {
            reportType = 0
        }else if PID == 0{
            reportType = 1
        }
        let httpBody : [String:Any] = ["reportType":communityType,"TYPE":reportType]
        let session = URLSession(configuration: .default)
        guard let url = URL(string:BookkyURL.baseURL + BookkyURL.reportPostURL+"CID=\(CID)&"+"PID=\(PID)"+"&communityType=\(communityType)") else {
            print("Error: Cannot create URL")
            return
        }
        print("\(url)url")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("\(previousAccessToken)", forHTTPHeaderField: "access-token")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: httpBody, options: [])
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error:  \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("result: \(outputStr!)")

            }
        }.resume()
    }
}
