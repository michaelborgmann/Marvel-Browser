//
//  MasterCoordinator.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit

public class MasterCoordinator: Coordinator {
    
    public var children: [Coordinator] = []
    public var router: Router
        
    public init(router: Router) {
        self.router = router
    }
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = CharacterListViewController.instantiate(delegate: self)
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
    
}

// MARK: - CharacterListDelegate

extension MasterCoordinator: CharacterListDelegate {
    
    func selectCharacter(_ viewController: CharacterListViewController) {
        let viewController = CharacterDetailViewController.instantiate(delegate: self)
        router.present(viewController, animated: true)
    }
    
}

// MARK: - CharacterDetailDelegate

extension MasterCoordinator: CharacterDetailDelegate {}
