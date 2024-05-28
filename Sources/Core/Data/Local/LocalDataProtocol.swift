//
//  File.swift
//  
//
//  Created by Enrico Maricar on 26/05/24.
//

import Foundation
import RxSwift

public protocol LocalDatasourceProtocol {
    func fetchAllGame() -> Observable<[Game]>
    func fetchGameDetail(id: Int) -> Observable<Game?>
    func insertGame(gameDetails: Game, gameGenre: [GameGenre]) -> Observable<Game>
    func deleteGame(gameDetails: Game) -> Observable<Void>
    func checkingFavorite(id: Int) -> Observable<Bool>
}

