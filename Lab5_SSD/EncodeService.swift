//
//  EncodeService.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 08.10.2026.
//

import Foundation
import CryptoKit

struct EncryptService {
    
    static let shared = EncryptService()
    
    let messageSymmetricKey = "a1b2c3d4e5f67890a1b2c3d4e5f67890a1b2c3d4e5f67890a1b2c3d4e5f67890"
    
    func encryptMessage(message: String) throws -> AES.GCM.SealedBox {
        guard let dataToEncrypt = message.data(using: .utf8) else {
                throw NSError(
                    domain: "EncryptionError", code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Invalid string conversion"]
                )
            }
        
        let rawDataKey = Data(hexString: messageSymmetricKey)
        let key = SymmetricKey(data: rawDataKey!)
        
        let encryptedMessage = try AES.GCM.seal(dataToEncrypt, using: key)
        
        return encryptedMessage
    }
    
    func decryptMessage(sealedMessage: AES.GCM.SealedBox) throws -> String {
        let rawDataKey = Data(hexString: messageSymmetricKey)
        let key = SymmetricKey(data: rawDataKey!)
        
        let decryptedData = try AES.GCM.open(sealedMessage, using: key)
        return String(data: decryptedData, encoding: .utf8) ?? ""
    }
    
//    func encodeSHA256(input: String) -> Data {
//        let data = Data(input.utf8)
//        return Data(SHA256.hash(data: data))
//    }
    
//    func convertDataToString(data: Data) -> String {
//        let result = data.map {String( format: "%02hhx", $0) }.joined()
//        return result
//    }
    
//    func encode(input: String) -> String {
//        let data = encodeSHA256(input: input)
//        return convertDataToString(data: data)
//    }
    
    func sealedBoxToString(box: AES.GCM.SealedBox) -> String? {
        guard let combinedData = box.combined else { return nil }
        return combinedData.base64EncodedString()
    }
    
    func passwordHashing(input: String) -> SHA256.Digest {
        let data = Data(input.utf8)
        return SHA256.hash(data: data)
    }
    
    func SHA256ToString(digest: SHA256.Digest) -> String {
        digest.description
    }
    
}

extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        var i = hexString.startIndex
        for _ in 0..<len {
            let j = hexString.index(i, offsetBy: 2)
            if let byte = UInt8(hexString[i..<j], radix: 16) {
                data.append(byte)
            } else {
                return nil
            }
            i = j
        }
        self.init(data)
    }
}
