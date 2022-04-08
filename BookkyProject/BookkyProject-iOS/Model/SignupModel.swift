//
//  SignupModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/06.
//

import Foundation

// MARK: - SignupModel
struct SignupModel: Codable {
    let success: Bool
    let result: Result
    let errorMessage: String
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case success, result, errorMessage
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// MARK: - Result
struct Result: Codable {
    let email: String?
    let nickname: String?
    let pushToken: String?
    let pushNoti: Bool?
    let thumbnail: String?
    let loginMethod: Int?
}
