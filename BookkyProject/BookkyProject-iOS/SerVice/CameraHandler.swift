//
//  CameraHandler.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/31.
//

import Foundation
import UIKit
import PhotosUI

class CameraHandler: NSObject {
    static let shared = CameraHandler()
    
    fileprivate var currentViewController: UIViewController!
    
    // MARK: Internal Properties
    var imagePickerBlock: ((UIImage) -> Void)?
    
    func actionSheetAlert(vc: UIViewController) {
        currentViewController = vc
        let actionSheet = UIAlertController(title: "사진을 가져올 곳을 선택하세요.", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let cameraAction = UIAlertAction(title: "카메라", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.cameraWillPresent()
        })
        let photoLibraryAction = UIAlertAction(title: "앨범", style: .default, handler: { (alert:UIAlertAction) -> Void in
            self.photoLibraryWillPresent()
        })
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    func cameraWillPresent() {
//        if #available(iOS 14, *) {
//            let myProfileUpdatePickerController = PHPickerViewController(configuration: PHPickerConfiguration())
//        } else {
            let myProfileUpdatePickerController = UIImagePickerController()
            myProfileUpdatePickerController.delegate = self
            myProfileUpdatePickerController.sourceType = .camera
            currentViewController.present(myProfileUpdatePickerController, animated: true, completion: nil)
//        }
    }
    
    func photoLibraryWillPresent() {
//        if #available(iOS 14, *) {
            
//        } else {
            let myProfileUpdatePickerController = UIImagePickerController()
            myProfileUpdatePickerController.delegate = self
            myProfileUpdatePickerController.sourceType = .photoLibrary
            currentViewController.present(myProfileUpdatePickerController, animated: true, completion: nil)
//        }
    }
}

extension CameraHandler: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imagePickerBlock?(image)
        } else {
            // alert 창으로 알림창 띄우기
            print("이미지 안된다.")
        }
        currentViewController.dismiss(animated: true, completion: nil)
    }
}
