//
//  String+Extension.swift
//  ppp
//
//  Created by PixelPlex Developer on 5/28/19.
//  Copyright © 2019 PixelPlex. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    func sha1() -> String {
        let data = Data(self.utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, bounds.lowerBound))
        let end = index(startIndex, offsetBy: min(count, min(count, bounds.upperBound)))
        return String(self[start...end])
    }
}
