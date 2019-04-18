//
//  PokemonModel.swift
//  SampleAPICall
//
//  Created by Caroline Cruz on 4/16/19.
//  Copyright © 2019 Caroline Cruz. All rights reserved.
//

import Foundation


struct PokemonModel: Codable {
    let count: Int
    let next: String
    let results: [Pokemons]
    
}

struct Pokemons: Codable {
    let name: String?
    let url: URL?
}


