//
//  TagsModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/01.
//

import Foundation

// MARK: - TagModel
struct TagsModel: Codable {
    let success: Bool
    let result: TagsResult
    let errorMessage: String
}

// MARK: - Result
struct TagsResult: Codable {
    let tag: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    let tmid: Int
    let nameTag, searchName: String

    enum CodingKeys: String, CodingKey {
        case tmid = "TMID"
        case nameTag, searchName
    }
}
