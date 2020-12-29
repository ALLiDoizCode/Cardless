//
//  Photos.swift
//  Cardless
//
//  Created by Jonathan Green on 12/28/20.
//

import Foundation

struct Photos: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Photo]?
}

struct Photo: Decodable, Identifiable, Hashable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }

    let id: String
    let created_at: String
    let updated_at: String
    let promoted_at: String?
    let width: Int
    let height: Int
    let color: String
    let blur_hash: String
    let description: String?
    let alt_description: String?
    let urls: ImageURL
}

struct ImageURL: Decodable, Hashable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
