//
//  MyProfileUpdateModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/01.
//

import Foundation

struct MyProfileUpdateModel: Codable {
    let success: Bool
    let result: MyProfileUpdateResult?
    let errorMessage: String?
}

struct MyProfileUpdateResult: Codable {
    let userData: MyProfileUpdateUserData
}

struct MyProfileUpdateUserData: Codable {
    let route: String
    let nickname: String
}
