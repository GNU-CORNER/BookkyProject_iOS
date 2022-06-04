//
//  SearchMode.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/18.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    static var didSearch: Bool = false
    let success: Bool
    let result: SearchResult?
    let errorMessage: String
}

// MARK: - Result
struct SearchResult: Codable {
    let searchData: [SearchDatum]
    let total: Int
}

// MARK: - SearchDatum
struct SearchDatum: Codable {
    let tbid: Int
    let title, author: String
    let thumbnailImage: String
    let rating: Double
    let bookIntroduction, publishDate, publisher: String
    let tagData: [TagDatum]

    enum CodingKeys: String, CodingKey {
        case tbid = "TBID"
        case title = "TITLE"
        case author = "AUTHOR"
        case thumbnailImage
        case rating = "RATING"
        case bookIntroduction = "BOOK_INTRODUCTION"
        case publishDate = "PUBLISH_DATE"
        case publisher = "PUBLISHER"
        case tagData
    }
}

// MARK: - TagDatum
struct TagDatum: Codable {
    let tag: String
    let tmid: Int

    enum CodingKeys: String, CodingKey {
        case tag
        case tmid = "TMID"
    }
}
