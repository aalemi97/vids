//
//  VideoEntity.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import Foundation

struct VideoEntity: Codable, Identifiable {
    let id: String
    let title: String
    let hlsURL: String
    let fullURL: String
    let description: String
    let publishedAt: String
    let author: Author
    
    func convertDateToString() -> String {
        let date = generateDate()
        if let date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: date)
        }
        return publishedAt
    }
    
    private func generateDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: publishedAt)
        return date
    }
}
