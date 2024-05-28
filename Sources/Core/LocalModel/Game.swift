//
//  File.swift
//  
//
//  Created by Enrico Maricar on 27/05/24.
//

import Foundation
import SwiftData

@Model
public class Game {
    public var id: Int
    public var name : String
    public var desc: String
    public var released: String
    public let background_image: String?
    public let rating: Double
    public let rating_top: Int
    public var genre: [GameGenre]?
    
    init(id: Int, name: String, desc: String, released: String, background_image: String?, rating: Double, rating_top: Int) {
        self.id = id
        self.name = name
        self.desc = desc
        self.released = released
        self.background_image = background_image
        self.rating = rating
        self.rating_top = rating_top
    }
    
}
