//
//  CharacterDetailViewController.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 13.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit

// MARK: - CharacterDetailDelegate

public protocol CharacterDetailDelegate: class {
    func backButtonPressed()
}

// MARK: - CharacterDetailViewController

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    public weak var delegate: CharacterDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
        delegate?.backButtonPressed()
    }
    
}

// MARK: - StoryboardInstantiable

extension CharacterDetailViewController: StoryboardInstantiable {
    public class func instantiate(delegate: CharacterDetailDelegate) -> CharacterDetailViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
    }
}
