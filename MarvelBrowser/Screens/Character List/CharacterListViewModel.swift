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
        
    let state = PublishRelay<State>()
    
    /*
    {
        didSet {
            switch state {
            case .ready:
                viewMessage.isHidden = true
                tblComics.isHidden = false
                tblComics.reloadData()
            case .loading:
                tblComics.isHidden = true
                viewMessage.isHidden = false
                lblMessage.text = "Getting comics ..."
                imgMeessage.image = #imageLiteral(resourceName: "Loading")
            case .error:
                tblComics.isHidden = true
                viewMessage.isHidden = false
                lblMessage.text = """
                              Something went wrong!
                              Try again later.
                            """
                imgMeessage.image = #imageLiteral(resourceName: "Error")
            }
        }
    }
    */
    
    private let provider = MoyaProvider<MarvelAPI>()
    //private let provider = MoyaProvider<MarvelAPI>(stubClosure: MoyaProvider.immediatelyStub)

    
    var characters = [Character]()
    
    func request() {
        
        provider.request(.characters) { [weak self] result in
          
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    self.characters = try response.map(CharacterResponse<Character>.self).data.results
                    self.state.accept(.ready(self.characters))
                } catch {
                    self.state.accept(.error)
                }
                
            case .failure:
                self.state.accept(.error)
            }
        }
        
    }
    
}


