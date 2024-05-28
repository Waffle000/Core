//
//  File.swift
//  
//
//  Created by Enrico Maricar on 26/05/24.
//

import Foundation
import RxSwift
import Alamofire

public class RemoteDataSource: RemoteDataProtocol {
    private let baseURL = "https://api.rawg.io/api"
    private let apiKey = "6b43bac89d574dcebba53d86e622af06"
    
    @MainActor
    public static let shared = RemoteDataSource()
    
    func fetchData<T: Codable>(from endpoint: String) -> Observable<T> {
        let url = "\(baseURL)/\(endpoint)?key=\(apiKey)"
        return Observable.create { observer in
            AF.request(url, method: .get).validate().responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
   public func fetchGames() -> Observable<Games> {
        return fetchData(from: "games")
    }
    
   public func fetchGameDetail(id: Int) -> Observable<GameDetail> {
        return fetchData(from: "games/\(id)")
    }
    
    
}
