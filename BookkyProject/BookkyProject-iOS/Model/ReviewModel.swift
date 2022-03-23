//
//  ReviewModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import Foundation
import UIKit

/// 나중에 데이터 받아오면 구조 바꿔야 함~,~
struct ReviewModel {
    let thumbnail: UIImage?
    let title: String
    let description: String
    let like: Int
    let authorAndPubliser: String
    let bookRateStar: Float
}
let myReview: [ReviewModel] = [
    ReviewModel(thumbnail: UIImage(named: "DeepLearning"), title: "REACT", description: "1여러분 이거보세요 ㄹㅇ 개쩜....ㅋㅋㅋㅋㅋ 짱이죠 ㄹㅇ ㅋㅋㅋ 신기하지않나요.. 이정도면 ㄹㅇ ㅋㅋㅋ. 이게 ㄹㅇ 말이되.   . .냐고옹~~~~~ .", like: 7, authorAndPubliser: "사이토 코기 / 길벗", bookRateStar: 5),
    ReviewModel(thumbnail: UIImage(named: "리액트를다루는기술"), title: "혼자 공부하는 머신러닝+딥러닝", description: "2여러분 이거보세요 ㄹㅇ 개쩜....ㅋㅋㅋㅋㅋ 짱이죠 ㄹㅇ ㅋㅋㅋ 신기하지않나요.. 이정도면 ㄹㅇ ㅋㅋㅋ. 이게 ㄹㅇ 말이되.   . .냐고옹~~~~~ .", like: 14, authorAndPubliser: "사이토 코기 / 길벗", bookRateStar: 4.5)
]
