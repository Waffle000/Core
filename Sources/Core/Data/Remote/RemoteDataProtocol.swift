//
//  File.swift
//  
//
//  Created by Enrico Maricar on 26/05/24.
//

import Foundation
import RxSwift

public protocol RemoteDataProtocol {
    func fetchGames() -> Observable<Games>
    func fetchGameDetail(id: Int) -> Observable<GameDetail>
}
