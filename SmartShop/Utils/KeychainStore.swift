//
//  KeychainStore.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import Foundation
import Security

struct KeychainStore<T: Codable> {
    private init() {}

    static func set(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data,
            ]

            SecItemDelete(query as CFDictionary)

            let status = SecItemAdd(query as CFDictionary, nil)

            if status != errSecSuccess {
                print("DEBUG: Error storing item to keychain \(status)")
            }
        } catch {
            print("DEBUG: Failed to store item to keychain with error \(error)")
        }
    }

    static func get(_ key: String) -> T? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne,
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess, let data = item as? Data {
            return try? JSONDecoder().decode(T.self, from: data)
        }

        return nil
    }

    static func delete(_ key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
        ]

        let status = SecItemDelete(query as CFDictionary)

        return status == errSecSuccess
    }
}
