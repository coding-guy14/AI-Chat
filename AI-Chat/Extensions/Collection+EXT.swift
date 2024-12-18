//
//  Collection+EXT.swift
//  AI-Chat
//
//  Created by Soham Divekar on 19/12/2024.
//

import Foundation

extension Collection {
    func first(upto value: Int) -> [Element]? {
        guard !isEmpty else { return nil }
        
        let maxItems = Swift.min(count, value)
        return Array(prefix(maxItems))
    }
    
    func last(upto value: Int) -> [Element]? {
        guard !isEmpty else { return nil }
        
        let maxItems = Swift.min(count, value)
        return Array(suffix(maxItems))
    }
}
