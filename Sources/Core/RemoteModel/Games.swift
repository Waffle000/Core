//
//  File.swift
//  
//
//  Created by Enrico Maricar on 27/05/24.
//

import Foundation

public struct Games : Codable {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [ResultData]
}

public struct ResultData : Codable{
    public let id: Int
    public let slug, name, released: String?
    public let tba: Bool
    public let background_image: String?
    public let rating: Double?
    public let ratingTop: Int?
}
