//
//  CharacterListViewModel.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation
import Moya
import RxRelay

extension CharacterListViewModel {
    enum State {
        case loading
        case ready([Character])
        case error
  }
}

class CharacterListViewModel {
        
    let state = BehaviorRelay<State>(value: .ready([]))
    
    private let provider = MoyaProvider<MarvelAPI>()
    //private let provider = MoyaProvider<MarvelAPI>(stubClosure: MoyaProvider.immediatelyStub)
    
    var characters = [Character]()
    var pagination: Pagination?
    var currentPosition = 0
    
    func request() {
        
        switch state.value {
        case .loading: return
        default: break
        }
        
        state.accept(.loading)
                
        provider.request(.characters(currentPosition)) { [weak self] result in
          
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    self.pagination = try response.map(PaginationResult<Pagination>.self).data
                    self.characters += try response.map(CharacterResponse<Character>.self).data.results
                    self.state.accept(.ready(self.characters))
                    
                    self.currentPosition += self.pagination!.count
                } catch {
                    self.state.accept(.error)
                }
                
            case .failure:
                self.state.accept(.error)
            }
        }
        
    }
    
}


