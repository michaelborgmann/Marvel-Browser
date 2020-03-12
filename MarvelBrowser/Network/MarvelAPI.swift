//
//  MarvelAPI.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

public enum MarvelAPI {
    
    // NOTE: https://developer.marvel.com/account
    static private let publicKey = "c5d728c1fa69f60cf903606b4ce84200"
    static private let privateKey = "67aa4fd792c95c8d67fcf2945b489edc1323a01d"
    
    case characters
}

extension MarvelAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .characters: return "/characters"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .characters: return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .characters:
            
            guard let url = Bundle.main.url(forResource: "Characters", withExtension: "json"),
                let data = try? Data(contentsOf: url)
            else {
                return Data()
            }
            
            return data
        }
    }
    
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + MarvelAPI.privateKey + MarvelAPI.publicKey).md5()
        let authParams: [String: Any] = ["apikey": MarvelAPI.publicKey, "ts": ts, "hash": hash]
                        
        switch self {
        case .characters:
            return .requestParameters(parameters: ["limit": 10] + authParams, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
      return .successCodes
    }
    
    
}
