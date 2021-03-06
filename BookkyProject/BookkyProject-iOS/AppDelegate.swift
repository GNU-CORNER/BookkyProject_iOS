//
//  AppDelegate.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Launch")
        // - [x] UserDefaults에 저장되어 있는 사용자 이메일 가져오기
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            // - [ ] 예외처리 할 것
            print("Launch: 사용자 이메일을 불러올 수 없음.")
            return true
        }
        print(userEmail)
        // - [x] 사용자 이메일로 KeyChain에 저장되어 있는 AT, RT를 가져오기
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
              let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
            // - [ ] 예외처리 할 것
            print("Launch: 토큰을 불러올 수 없음.")
            return true
        }
        // - [x] 서버에 토큰 갱신 요청
        print("갱신요청")
        Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
            print(success)
            guard let tokens = data as? RefreshModel else { return }
            if success {
                // - [x] 갱신받은 access token 다시 Keychain에 저장
                if let newAccessToken = tokens.result?.accessToken {
                    let statusUpdateAccessToken = KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue)
                    print(statusUpdateAccessToken)
                    print(newAccessToken)
                    if !statusUpdateAccessToken {
                        // - [ ] 예외처리 할 것
                        print("Launch: 새로운 토큰 제대로 저장이 안되었어요~~~~")
                    }
                }
            } else {
                if statuscode == 400 {
                    // 유효한 토큰입니다.
                    print(tokens.errorMessage)
                } else if statuscode == 403 {
                    // 기간이 지난 토큰입니다.
                    print(tokens.errorMessage)
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

    // MARK: - Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        // CoreData로 생성한 모델이름을 적으면 된다.
        let container = NSPersistentContainer(name: "Searches")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()

}

