//
//  CharacterDetailViewController.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 13.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit

// MARK: - CharacterDetailViewController

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - StoryboardInstantiable

extension CharacterDetailViewController: StoryboardInstantiable {
    public class func instantiate() -> CharacterDetailViewController {
        let viewController = instanceFromStoryboard()
        return viewController
    }
}
