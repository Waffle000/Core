//
//  File.swift
//  
//
//  Created by Enrico Maricar on 26/05/24.
//

import Foundation
import RxSwift
import SwiftData

public class LocalDatasource : LocalDatasourceProtocol {
    
    private let modelContainer: ModelContainer
       private let modelContext: ModelContext

       @MainActor
       public static let shared = LocalDatasource()

       @MainActor
        init() {
           self.modelContainer = try! ModelContainer(for: Game.self, GameGenre.self)
           self.modelContext = modelContainer.mainContext
       }
    
    public func fetchAllGame() -> Observable<[Game]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            let descriptor = FetchDescriptor<Game>()
            do {
                let games = try modelContext.fetch(descriptor)
                observer.onNext(games)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    
    public func fetchGameDetail(id: Int) -> Observable<Game?> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            
            let descriptor = FetchDescriptor<Game>(predicate: #Predicate { game in
                game.id == id
            })
            
            do {
                let games = try modelContext.fetch(descriptor)
                if let game = games.first {
                    observer.onNext(game)
                    observer.onCompleted()
                } else {
                    observer.onError(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "No game found"]))
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    public func insertGame(gameDetails: Game, gameGenre: [GameGenre]) -> Observable<Game> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            self.modelContext.insert(gameDetails)
            gameDetails.genre?.append(contentsOf: gameGenre)
            
            do {
                try self.modelContext.save()
                observer.onNext(gameDetails)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    public func deleteGame(gameDetails: Game) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            let id = gameDetails.id
            let prediction = #Predicate<Game> { $0.id == id }
            do {
                try self.modelContext.delete(model:  Game.self, where: prediction)
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    public func checkingFavorite(id: Int) -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create()
            }
            
            let descriptor = FetchDescriptor<Game>(predicate: #Predicate { game in
                game.id == id
            })
            
            do {
                let games = try modelContext.fetch(descriptor)
                if games != [] {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    
}


public typealias PublicObservable<T> = Observable<T>
