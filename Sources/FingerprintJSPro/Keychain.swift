/**
 Copyright (c) FingerprintJS, Inc, 2021 (https://fingerprintjs.com)
 */

import Foundation

// MARK: - Keychain

internal func defaultAccount(for key: String) -> String {
    "com.fingerprintjs.keychain.\(key)"
}

// MARK: - Keychain

internal enum Keychain {
    private struct Error: Swift.Error, LosslessStringConvertible {
        // MARK: - Lifecycle

        init(_ description: String) {
            self.description = description
        }

        // MARK: - Public

        public var description: String
    }

    // MARK: - Internal

    static func storeKey(_ key: Data, account: String) throws {
        if try readKey(account: account) != nil {
            try deleteKey(account: account)
        }

        let query = [kSecClass: kSecClassGenericPassword,
                     kSecAttrAccount: account,
                     kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
                     kSecAttrSynchronizable: kSecAttrSynchronizableAny,
                     kSecValueData: key] as [String: Any]

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw Error("Unable to store item: \(status.message)")
        }
    }

    static func readKey(account: String) throws -> Data? {
        let query = [kSecClass: kSecClassGenericPassword,
                     kSecAttrAccount: account,
                     kSecReturnData: true] as [String: Any]

        var item: CFTypeRef?
        switch SecItemCopyMatching(query as CFDictionary, &item) {
        case errSecSuccess:
            guard let data = item as? Data else { return nil }
            return data
        case errSecItemNotFound: return nil
        case let status: throw Error("Read failed: \(status.message)")
        }
    }

    static func deleteKey(account: String) throws {
        let query = [kSecClass: kSecClassGenericPassword,
                     kSecAttrAccount: account] as [String: Any]
        switch SecItemDelete(query as CFDictionary) {
        case errSecItemNotFound, errSecSuccess: break
        case let status:
            throw Error("Unexpected deletion error: \(status.message)")
        }
    }
}

private extension OSStatus {
    var message: String {
        if #available(iOS 11.3, *) {
            return (SecCopyErrorMessageString(self, nil) as String?) ?? String(self)
        } else {
            return String(self)
        }
    }
}
