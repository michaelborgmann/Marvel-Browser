//
//  ViewController.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit

// MARK: - CharacterListDelegate

public protocol CharacterListDelegate: class {
    //func homeViewControllerDidPressScheduleAppointment(_ viewController: HomeViewController)
}

// MARK: - CharacterListViewController

class CharacterListViewController: UIViewController {
    
    public weak var delegate: CharacterListDelegate?
    
    let viewModel = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.request()
    }

    // MARK: - Actions

}

extension CharacterListViewController: StoryboardInstantiable {
    public class func instantiate(delegate: CharacterListDelegate) -> CharacterListViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
    }
}
