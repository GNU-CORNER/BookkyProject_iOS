//
//  UIImageExtension.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/01.
//

import Foundation
import UIKit

extension UIImage {
    
    func imageToPNGString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString()
    }
    
    func imageToPngNJPEGString() -> String?{
        guard let imageData = self.jpegData(compressionQuality: 1) ?? self.pngData() else { return nil }
        let data = imageData.base64EncodedString()
        return data
    }
    
}
