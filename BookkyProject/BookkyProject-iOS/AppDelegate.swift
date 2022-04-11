//
//  AppDelegate.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Launch")
        // - [ ] KeyChain에 저장되어 있는 AT, RT를 가져오기
        // - [ ] 
        if let accessToken = UserDefaults.standard.string(forKey: UserDefaultsModel.accessToken.rawValue),
           let refreshToken = UserDefaults.standard.string(forKey: UserDefaultsModel.refreshToken.rawValue)
            {
            print("되고있나")
            Account.shared.refreshAuth(accessToken: accessToken, refreshToken: refreshToken) { (success, data) in
                if success {
                    guard let decodedData = data as? RefreshModel else { return }
                    UserDefaults.standard.set(decodedData.accessToken, forKey: UserDefaultsModel.accessToken.rawValue)
                    UserDefaults.standard.synchronize()
                    print("토큰 갱신, 자동로그인 실행")
                } else {
                    print("RT 만료")
                }
            }
        }
        
        print("런치끝")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

