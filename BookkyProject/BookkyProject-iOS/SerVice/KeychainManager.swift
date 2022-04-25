//
//  KeychainManager.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/12.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()
    let dot = "."
    
    func create(_ userData: String, userEmail: String, itemLabel: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword, /*필수*/
            kSecAttrLabel: itemLabel,
            kSecAttrAccount: userEmail+itemLabel, /*필수*/
            kSecValueData: userData.data(using: .utf8)! /*필수*/
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
//        print(status)
//        print( status == errSecSuccess )
        return status == errSecSuccess
    }
    
    func read(userEmail: String, itemLabel: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrLabel: itemLabel,
            kSecAttrAccount: userEmail+itemLabel, /*필수*/
            kSecReturnAttributes: true, /*필수*/
            kSecReturnData: true /*필수*/
        ]
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
//        print(status)
//        print(status == errSecSuccess)
        guard status == errSecSuccess else {
            print("KeychainManager: status code -> \(status)")
            return nil
        }
        guard let existingItem = item as? [String: Any],
              let data = existingItem[kSecValueData as String] as? Data else {
            print("KeychainManager: Data Read Error.")
            return nil
        }
        guard let result = String(data: data, encoding: .utf8) else { return nil }
        print(itemLabel)
        print(result)
        return result
    }
    
    func update(_ userData: String, userEmail: String, itemLabel: String) -> Bool {
        let previousQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword, /*필수*/
            kSecAttrLabel: itemLabel,
            kSecAttrAccount: userEmail+itemLabel /*필수*/
        ]
        let updateFields: [CFString: Any] = [
            kSecValueData: userData.data(using: .utf8)!
        ]
        print("없뎃")
        let status = SecItemUpdate(previousQuery as CFDictionary, updateFields as CFDictionary)
        return status == errSecSuccess
    }
    
    func delete(userEmail: String, itemLabel: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrLabel: itemLabel,
            kSecAttrAccount: userEmail+itemLabel
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
