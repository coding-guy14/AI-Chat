//
//  FirebaseImageUploadService.swift
//  AI-Chat
//
//  Created by Soham Divekar on 18/12/2024.
//

import SwiftUI
import FirebaseStorage

protocol ImageUploadService {
    
    func uploadImage(path: String, image: UIImage) async throws -> URL 
}

struct FirebaseImageUploadService {
    
    func uploadImage(path: String, image: UIImage) async throws -> URL {
        guard let data = image.jpegData(compressionQuality: 1) else { throw URLError(.dataNotAllowed) }
        
        _ = try await saveImage(data: data, path: path)
        
        return  try await imageReference(path: path).downloadURL()
    }
    
    private func imageReference(path: String) -> StorageReference {
        let name = "\(path).jpg"
        return Storage.storage().reference(withPath: name)
    }
    
    private func saveImage(data: Data, path: String) async throws -> URL {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let returnedMeta = try await imageReference(path: path).putDataAsync(data, metadata: meta)
        guard let returnedPath = returnedMeta.path, let url = URL(string: returnedPath) else { throw URLError(.badServerResponse) }
        return url
    }
}
