//
//  APIRequest.swift
//  SampleAPICall
//
//  Created by Caroline Cruz on 4/19/19.
//  Copyright © 2019 Caroline Cruz. All rights reserved.
//

import Foundation


//improve declaring httpMethod
enum RequestType: String {
    case GET, POST
}

//this protcol defines the necessary properties
protocol APIRequest {
    var method: RequestType {get}
    var path: String {get}
    var parameters: [String:String] {get}
}

//Protocol extension that will create URLRequest from instance of APIRequest
extension APIRequest {
    func request(with baseURL: URL) -> URLRequest {
        guard
            var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                           resolvingAgainstBaseURL: false)
            else {
                fatalError("Unable to create URL compnents")
        }
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        guard let url = components.url else {
            fatalError("could not get url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
