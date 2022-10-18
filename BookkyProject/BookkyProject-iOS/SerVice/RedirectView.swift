//
//  RedirectLoginView.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/11.
//

import Foundation
import UIKit

class RedirectView {
    
    static func loginView(previousView: UIViewController) {
        //스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        DispatchQueue.main.async {
            guard let vc = storyboard?.instantiateViewController(identifier: "LoginNavigation") else {
                return
            }
            // 화면 전환방식 선택 (default : .modal)
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            

            // 화면 전환!
            previousView.present(vc, animated: true)
        }
    }
    
    static func initialResearchView(presentView: UIViewController) {
        // 스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "InitialResearch", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        DispatchQueue.main.async {
            guard let vc = storyboard?.instantiateViewController(identifier: "Research") as? InitialResearchViewController else {
                return
            }
            vc.isFirstLogin = true
            // 화면 전환방식 선택 (default : .modal)
            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

            // 화면 전환!
            presentView.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
