//
//  CharacterListViewModel.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation

import Moya

class CharacterListViewModel {
    
    //private let provider = MoyaProvider<MarvelAPI>()
    private let provider = MoyaProvider<MarvelAPI>(stubClosure: MoyaProvider.immediatelyStub)

    
    private var characters = [Character]()
    
    func request() {
        
        provider.request(.characters) { [weak self] result in
          
            guard let self = self else { return }

            switch result {
            case .success(let response):
            
                self.characters = try! response.map(CharacterResponse<Character>.self).data.results
                print(self.characters)
                
            case .failure:
                //self.state = .error
                print("ERROR", result)
            }
        }
        
    }
    
}

struct Character: Codable {
    
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    struct Thumbnail:Codable {
        let path:String
        let `extension`:String
        var url:URL {
            return URL(string: path + "." + `extension`)!
        }
    }
    
}

struct CharacterResponse<T: Codable>: Codable {
    let data: CharacterResults<T>
}

struct CharacterResults<T: Codable>: Codable {
    let results : [T]
}
