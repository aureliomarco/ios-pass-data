//
//  String+extension.swift
//  passData
//
//  Created by Anderson F Carvalho
//  Copyright © 2020 coda. All rights reserved.
//

#if os(iOS)
import UIKit

extension String {
    
    var isValidURL: Bool {
        
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
        
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: endIndex.utf16Offset(in: self))) {
            return match.range.length == endIndex.utf16Offset(in: self)
        }
        
        return false
    }
}

#endif
