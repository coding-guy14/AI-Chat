//
//  FileManager.EXT.swift
//  AI-Chat
//
//  Created by Soham Divekar on 17/12/2024.
//

import Foundation

extension FileManager {
    
    static func saveDocument<T: Codable>(key: String, value: T?) throws {
        let data = try JSONEncoder().encode(value)
        let url = getDocumentUrl(for: key)
        try data.write(to: url)
    }
    
    static func getDocument<T: Codable>(key: String) throws -> T? {
        let url = getDocumentUrl(for: key)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private static func getDocumentUrl(for key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("\(key).txt")
    }
}
