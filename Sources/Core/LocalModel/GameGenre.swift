//
//  File.swift
//  
//
//  Created by Enrico Maricar on 27/05/24.
//

import Foundation
import SwiftData

@Model
public class GameGenre {
    public var id: Int
    public var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    public var idGame: Game?
}
