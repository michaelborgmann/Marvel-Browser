//
//  DetailCoordinator.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 13.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import Foundation

public class DetailCoordinator: Coordinator {
    
    public var children: [Coordinator] = []
    public var router: Router
        
    public init(router: Router) {
        self.router = router
    }
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        let viewController = CharacterDetailViewController.instantiate(delegate: self)
        router.present(viewController, animated: animated, onDismissed: onDismissed)
    }
    
}

extension DetailCoordinator: CharacterDetailDelegate {
    public func backButtonPressed() {
        //<#code#>
    }
}
