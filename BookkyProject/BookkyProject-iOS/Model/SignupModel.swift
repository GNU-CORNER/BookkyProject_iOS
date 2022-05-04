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
    let result: Result?
    let errorMessage: String
}

// MARK: - Result
struct Result: Codable {
    let userData: UserData?
    let accessToken: String
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case userData
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

// MARK: - UserData
struct UserData: Codable {
    let uid: Int
    let email, nickname: String
    let pushToken: String?
    let pushNoti: Bool
    let thumbnail: String?
    let loginMethod: Int
    let tagArray: String?

    enum CodingKeys: String, CodingKey {
        case uid = "UID"
        case email, nickname, pushToken, pushNoti, thumbnail, loginMethod
        case tagArray = "tag_array"
    }
}

// MARK: - RefreshModel
struct RefreshModel: Codable {
    let success: Bool
    let result: Result?
    let errorMessage: String
//    let accessToken: String?
//
//    enum CodingKeys: String, CodingKey {
//        case success, result, errorMessage
//        case accessToken = "access-token"
//    }
}
