//
//  PostsViewController.swift
//  PostsLoader
//
//  Created by Jan Bjelicic on 24/02/2021.
//

import UIKit

class PostsViewController: UITableViewController {
    
    private var networkManager: NetworkManager!
    
    private var dataSource: [Post] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadPosts()
    }
    
    // MARK: - Navigation
    private func showErrorAlert() {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.loadPosts()
        }
        let alert = UIAlertController(title: "Error", message: "Error occured, please try again!", preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(tryAgainAction)
        present(alert, animated: false)
    }
    
    // MARK: - Setup
    private func setup() {
        networkManager = NetworkManager()
    }
    
    private func loadPosts() {
        networkManager.getPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.showErrorAlert()
                }
            case .success(let posts):
                self.dataSource = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Would use R.swift for resources.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.update(with: dataSource[indexPath.row])
        return cell
    }
    
    /// I'm gonna use this method to reload any images that weren't loaded properly.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cell = tableView.cellForRow(at: indexPath) as? PostCell else { return }
        cell.reloadImage()
    }
    
}
