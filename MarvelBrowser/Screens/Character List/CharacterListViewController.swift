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

protocol CharacterListDelegate: class {
    func selectCharacter(_ viewController: CharacterListViewController)
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

// MARK: - UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectCharacter(self)
    }
}

// MARK: - UITableViewDataSource

extension CharacterListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.pagination?.total ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CharacterTableViewCell
        
        
        
        if isLoadingCell(for: indexPath) {
            
        } else {
            let character = viewModel.characters[indexPath.row]
            cell.characterImage.kf.setImage(with: character.thumbnail.url)
            cell.nameLabel.text = character.name
            cell.indexLabel.text = "#\(indexPath.row)"
        }
        
        return cell
    }
    
}

// MARK: - UITableViewSourcePrefetching

extension CharacterListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.request()
        }
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentPosition
    }
    
    private func visibleIndexPathToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        
        return Array(indexPathsIntersection)
    }
    
}

// MARK: - StoryboardInstantiable

extension CharacterListViewController: StoryboardInstantiable {
    public class func instantiate(delegate: CharacterListDelegate) -> CharacterListViewController {
        let viewController = instanceFromStoryboard()
        viewController.delegate = delegate
        return viewController
    }
}
