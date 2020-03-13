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

    private var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = character {
            characterImage.kf.setImage(with: character.thumbnail.url)
            nameLabel.text = character.name
            detailsLabel.text = character.description
        }
    }
    
}

// MARK: - StoryboardInstantiable

extension CharacterDetailViewController: StoryboardInstantiable {
    public class func instantiate(for character: Character) -> CharacterDetailViewController {
        let viewController = instanceFromStoryboard()
        viewController.character = character
        return viewController
    }
}
