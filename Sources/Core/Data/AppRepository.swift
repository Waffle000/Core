//
//  File.swift
//  
//
//  Created by Enrico Maricar on 26/05/24.
//

import Foundation
import RxSwift

public class AppRepository {
    private final let apiService : RemoteDataProtocol
    private final let localDatasource : LocalDatasourceProtocol
    
    public init(apiService: RemoteDataProtocol, localDatasource: LocalDatasourceProtocol) {
        self.apiService = apiService
        self.localDatasource = localDatasource
    }
    
    public func fetchGames() -> Observable<Games> {
        return apiService.fetchGames()
    }
    
    public func fetchGameDetail(id: Int) -> Observable<GameDetail> {
        return apiService.fetchGameDetail(id: id)
    }
    
    public func fetchGamesLocal() -> Observable<[GameDetail]> {
        return localDatasource.fetchAllGame()
                .map { games in
                    games.map { game in
                        let genres = game.genre?.map { gameGenre in
                            Genre(id: gameGenre.id, name: gameGenre.name)
                        } ?? []

                        return GameDetail(
                            id: game.id,
                            name: game.name,
                            description: game.desc,
                            released: game.released,
                            background_image: game.background_image,
                            rating: game.rating,
                            rating_top: game.rating_top,
                            genres: genres
                        )
                    }
                }
    }
    
    public func fetchGameDetailLocal(id: Int) -> Observable<GameDetail?> {
        return localDatasource.fetchGameDetail(id: id)
            .map { game in
                guard let game = game else { return nil }
                let genres = game.genre?.map { gameGenre in
                    Genre(id: gameGenre.id, name: gameGenre.name)
                } ?? []
                
                return GameDetail(
                    id: game.id,
                    name: game.name,
                    description: game.desc,
                    released: game.released,
                    background_image: game.background_image,
                    rating: game.rating,
                    rating_top: game.rating_top,
                    genres: genres
                )
            }
    }

    public func insertGameLocal(gameDetail: GameDetail) -> Observable<GameDetail> {
        let data = Game(id: gameDetail.id , name: gameDetail.name , desc: gameDetail.description , released: gameDetail.released , background_image: gameDetail.background_image ?? "", rating: gameDetail.rating , rating_top: gameDetail.rating_top )
        let genres = gameDetail.genres.map {gen in
            GameGenre(id: gen.id, name: gen.name)
        }
        return localDatasource.insertGame(gameDetails: data, gameGenre: genres)
            .map { game in
                let genres = game.genre?.map { gameGenre in
                    Genre(id: gameGenre.id, name: gameGenre.name)
                } ?? []
                
                return GameDetail(
                    id: game.id,
                    name: game.name,
                    description: game.desc,
                    released: game.released,
                    background_image: game.background_image,
                    rating: game.rating,
                    rating_top: game.rating_top,
                    genres: genres
                )
            }
    }
    
    public func checkingFavorite(id: Int) -> Observable<Bool> {
        return localDatasource.checkingFavorite(id: id)
    }
    
    public func deleteGameLocal(gameDetail: GameDetail) -> Observable<Void> {
        let data = Game(
            id: gameDetail.id ?? 0,
            name: gameDetail.name ?? "",
            desc: gameDetail.description ?? "",
            released: gameDetail.released ?? "",
            background_image: gameDetail.background_image ?? "",
            rating: gameDetail.rating ?? 0.0,
            rating_top: gameDetail.rating_top ?? 0
            )
        return localDatasource.deleteGame(gameDetails: data)
    }
    
}

