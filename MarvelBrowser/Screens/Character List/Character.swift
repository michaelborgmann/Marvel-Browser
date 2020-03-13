//
//  Character.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation

struct Pagination: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
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

struct PaginationResult<T: Codable>: Codable {
    let data : T
}
