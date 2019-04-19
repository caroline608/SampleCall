//
//  APIClient.swift
//  SampleAPICall
//
//  Created by Caroline Cruz on 4/19/19.
//  Copyright © 2019 Caroline Cruz. All rights reserved.
//

import Foundation
import RxSwift



class APIClient {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create{ [unowned self] observer in
            let request = apiRequest.request(with: self.baseURL)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let pokemons: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(pokemons)
                }catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
            
        }
    }
}
