//
//  PostModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import Foundation

/// 나중에 데이터 받아오면 구조 바꿔야 함~,~
struct PostModel {
    let title: String
    let description: String
    let like: Int
    let comment: Int
}
let myPost: [PostModel] = [
    PostModel(title: "첫번째 글", description: "1여러분 이거보세요 ㄹㅇ 개쩜....ㅋㅋㅋㅋㅋ 짱이죠 ㄹㅇ ㅋㅋㅋ 신기하지않나요.. 이정도면 ㄹㅇ ㅋㅋㅋ. 이게 ㄹㅇ 말이되.   . . . .", like: 12, comment: 10),
    PostModel(title: "두번째 글입니둥둥", description: "2여러분 이거보세요 ㄹㅇ 개쩜....ㅋㅋㅋㅋㅋ 짱이죠 ㄹㅇ ㅋㅋㅋ 신기하지않나요.. 이정도면 ㄹㅇ ㅋㅋㅋ. 이게 ㄹㅇ 말이되.   . . . .", like: 3, comment: 5)
]
