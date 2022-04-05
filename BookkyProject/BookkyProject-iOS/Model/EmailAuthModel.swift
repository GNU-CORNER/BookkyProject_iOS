//
//  EmailAuthModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/05.
//

import Foundation

// MARK: - EmailAuthModel
struct EmailAuthModel: Codable {
    let success: Bool
    let result: Result
    let errorMessage: String
}

// MARK: - EmailAuthCheckModel
struct EmailAuthCheckModel: Codable {
    let success: Bool
//    let result: Result
    let errorMessage: String
}

// MARK: - Result
struct Result: Codable {
    let email: String
}


