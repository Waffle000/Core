//
//  File.swift
//  
//
//  Created by Enrico Maricar on 27/05/24.
//

import Foundation

public struct GameDetail: Codable {
    public let id: Int
    public let name, description: String
    public let released: String
    public let background_image: String?
    public let rating: Double
    public let rating_top: Int
    public let genres: [Genre]
}

public struct Genre : Codable {
    public let id: Int
    public let name : String
}
