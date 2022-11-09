//
//  PhotoAuth.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/11/09.
//

import Foundation
import UIKit
import Photos

// MARK: - 사진 권한 물어보기
private func photoAuth(isCamera: Bool, viewController: UIViewController, completion: @escaping () -> ()) {
    
    // 경고 메시지 작성
    let sourceName = isCamera ? "카메라" : "사진 라이브러리"
    
    let notDeterminedAlertTitle = "No Permission Status"
    let notDeterminedMsg = "\(sourceName)의 권한 설정을 변경하시겠습니까?"
    
    let restrictedMsg = "시스템에 의해 거부되었습니다."
    
    let deniedAlertTitle = "Permission Denied"
    let deniedMsg = "\(sourceName)의 사용 권한이 거부되었기 때문에 사용할 수 없습니다. \(sourceName)의 권한 설정을 변경하시겠습니까?"
    
    let unknownMsg = "unknown"
    
    // 카메라인 경우와 사진 라이브러리인 경우를 구분해서 권한 status의 원시값(Int)을 저장
    let status: Int = isCamera
    ? AVCaptureDevice.authorizationStatus(for: AVMediaType.video).rawValue
    : PHPhotoLibrary.authorizationStatus().rawValue
    
    // PHAuthorizationStatus, AVAuthorizationStatus의 status의 원시값은 공유되므로 같은 switch문에서 사용
    switch status {
    case 0:
        // .notDetermined - 사용자가 아직 권한에 대한 설정을 하지 않았을 때
        simpleDestructiveYesAndNo(viewController, message: notDeterminedMsg, title: notDeterminedAlertTitle, yesHandler: openSettings)
        print("CALLBACK FAILED: \(sourceName) is .notDetermined")
    case 1:
        // .restricted - 시스템에 의해 앨범에 접근 불가능하고, 권한 변경이 불가능한 상태
        simpleAlert(viewController, message: restrictedMsg)
        print("CALLBACK FAILED: \(sourceName) is .restricted")
    case 2:
        // .denied - 접근이 거부된 경우
        simpleDestructiveYesAndNo(viewController, message: deniedMsg, title: deniedAlertTitle, yesHandler: openSettings)
        print("CALLBACK FAILED: \(sourceName) is .denied")
    case 3:
        // .authorized - 권한 허용된 상태
        print("CALLBACK SUCCESS: \(sourceName) is .authorized")
        completion()
    case 4:
        // .limited (iOS 14 이상 사진 라이브러리 전용) - 갤러리의 접근이 선택한 사진만 허용된 경우
        print("CALLBACK SUCCESS: \(sourceName) is .limited")
        completion()
    default:
        // 그 외의 경우 - 미래에 새로운 권한 추가에 대비
        simpleAlert(viewController, message: unknownMsg)
        print("CALLBACK FAILED: \(sourceName) is unknwon state.")
    }
}

// MARK: - 설정 앱 열기
private func openSettings(action: UIAlertAction) -> Void {
    
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
            print("Settings opened: \(success)") // Prints true
        })
    }
}

// MARK: - photoAuth 함수를 main 스레드에서 실행 (UI 관련 문제 방지)
private func photoAuthInMainAsync(isCamera: Bool, viewController: UIViewController, completion: @escaping () -> ()) {
    
    DispatchQueue.main.async {
        photoAuth(isCamera: isCamera, viewController: viewController, completion: completion)
    }
    
}

// MARK: - 사진 라이브러리의 권한을 묻고, 이후 () -> () 클로저를 실행하는 함수
func authPhotoLibrary(_ viewController: UIViewController, completion: @escaping () -> ()) {
    
    if #available(iOS 14, *) {
        // iOS 14의 경우 사진 라이브러리를 읽기전용 또는 쓰기가능 형태로 설정해야 함
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            photoAuthInMainAsync(isCamera: false, viewController: viewController, completion: completion)
        }
    } else {
        // Fallback on earlier versions
        PHPhotoLibrary.requestAuthorization { status in
            photoAuthInMainAsync(isCamera: false, viewController: viewController, completion: completion)
        }
    }
}

// MARK: - 카메라의 권한을 묻고, 이후 () -> () 클로저를 실행하는 함수
func authDeviceCamera(_ viewController: UIViewController, completion: @escaping () -> ()) {
    
    let notAvailableMsg = "카메라를 사용할 수 없습니다."
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
        AVCaptureDevice.requestAccess(for: .video) { status in
            photoAuthInMainAsync(isCamera: true, viewController: viewController, completion: completion)
        }
    } else {
        // 시뮬레이터 등에서 카메라를 사용할 수 없는 경우
        DispatchQueue.main.async {
            simpleAlert(viewController, message: notAvailableMsg)
        }
    }
    
}
func simpleDestructiveYesAndNo(_ controller: UIViewController, message: String, title: String, yesHandler: ((UIAlertAction) -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertActionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
    let alertActionYes = UIAlertAction(title: "Yes", style: .destructive, handler: yesHandler)
    alertController.addAction(alertActionNo)
    alertController.addAction(alertActionYes)
    controller.present(alertController, animated: true, completion: nil)
}
func simpleAlert(_ controller: UIViewController, message: String) {
    let alertController = UIAlertController(title: "Caution", message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(alertAction)
    controller.present(alertController, animated: true, completion: nil)
}
