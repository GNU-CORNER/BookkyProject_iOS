//
//  AppDelegate.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseAuth
import FirebaseAnalytics
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    let aps = "aps"
    let data1Key = "DATA1"
    let data2Key = "DATA2"
    var window: UIWindow?

    override init() {
        super.init()
        UIFont.overrideInitialize()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 0.1)
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            print("가져올 데이터가 있음을 나타내는 원격 알림이 도착했음을 앱에 알림")
            
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            print("userInfo : ", userInfo)
            completionHandler(UIBackgroundFetchResult.newData)
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

extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("파이어베이스 토큰: \(String(describing: fcmToken))")
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("앱이 포그라운드에서 실행되는 동안 도착한 알림을 처리하는 방법")
                let userInfo = notification.request.content.userInfo
                if let messageID = userInfo[gcmMessageIDKey] {
                    print("Message ID: \(messageID)")
                }
                
                if let data1 = userInfo[data1Key] {
                    print("data1: \(data1)")
                }
                
                if let data2 = userInfo[data2Key] {
                    print("data2: \(data2)")
                }
                
                if let apsData = userInfo[aps] {
                    print("apsData : \(apsData)")
                }
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("앱이 APNS에 성공적으로 등록되었음을 대리자에게 알림")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNS가 등록 프로세스를 성공적으로 완료할 수 없어서 대리인에게 전송되었음")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        print("전달된 알림에 대한 사용자의 응답을 처리하도록 대리인에게 요청합니다.")
        let userInfo = response.notification.request.content.userInfo
                
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID)")
        }
        completionHandler()
    }
    
}
