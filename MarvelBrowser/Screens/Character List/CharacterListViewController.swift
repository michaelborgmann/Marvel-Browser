//
//  ViewController.swift
//  MarvelBrowser
//
//  Created by Michael Borgmann on 12.03.20.
//  Copyright © 2020 Michael Borgmann. All rights reserved.
//

import UIKit
import Kingfisher

// MARK: - CharacterListDelegate

public protocol CharacterListDelegate: class {
    //func homeViewControllerDidPressScheduleAppointment(_ viewController: HomeViewController)
}

// MARK: - CharacterListViewController

class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public weak var delegate: CharacterListDelegate?
    private let viewModel = CharacterListViewModel()
    private let cellID = "character"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "character")
        
        viewModel.request()
    }
    
    private func bindUI() {
        _ = viewModel.state.subscribe(onNext: { _ in
            self.tableView.reloadData()
        })
    }

    // MARK: - Actions

}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CharacterTableViewCell
        
        let character = viewModel.characters[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.characterImage.kf.setImage(with: character.thumbnail.url)
        
        print(character.name, character.thumbnail.url)
        
        return cell
    }
    
    
}

extension CharacterListViewController: StoryboardInstantiable {
    public class func instantiate(delegate: CharacterListDelegate) -> CharacterListViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
    }
}
