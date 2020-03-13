//
//  DetailCoordinator.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 13.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation

class DetailCoordinator: Coordinator {
    
    public var children: [Coordinator] = []
    public var router: Router
    private let character: Character
        
    init(router: Router, character: Character) {
        self.router = router
        self.character = character
    }
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = CharacterDetailViewController.instantiate(for: character)
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
    
}
