//
//  PokemonRequest.swift
//  SampleAPICall
//
//  Created by Caroline Cruz on 4/19/19.
//  Copyright © 2019 Caroline Cruz. All rights reserved.
//

import Foundation


class PokemonRequest: APIRequest {
    var method: RequestType = RequestType.GET
    var path: String = ""
    var parameters: [String : String] = [String:String]()
    
    init(name: String) {
        parameters["name"] = name
    }
}
