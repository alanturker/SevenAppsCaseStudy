//
//  ViewController.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import UIKit

final class UserViewController: UIViewController {
    
    private var viewModel: UserViewModelProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        tableView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User List"
        setupTableView()
        setupRefreshControl()
        setupViewModel()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor)
    }
    
    private func setupViewModel() {
        viewModel = UsersViewModel(delegate: self)
        viewModel?.getUsers()
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshUsers), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshUsers() {
        viewModel?.getUsers()
    }
}

// MARK: - TableView Delegate & DataSource Methods
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.users.count else { return 0 }
            
        count == 0 ? tableView.showEmptyState(message: "There are no Users :(") : tableView.hideEmptyState()
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell,
              let user = viewModel?.users[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = viewModel?.users[indexPath.row] {
            let detailVC = UserDetailViewController(user: user)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

// MARK: - UserDelegate
extension UserViewController: UserDelegate {
    func notify(_ output: UserViewModelOutput) {
        switch output {
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        case .fail(let errorText):
            DispatchQueue.main.async { [weak self] in
                self?.tableView.refreshControl?.endRefreshing()
                self?.showAlert(title: "Error", message: errorText)
            }
        case .loading(let isLoading):
            DispatchQueue.main.async { [weak self] in
                isLoading ? self?.showLoading() : self?.hideLoading()
            }
        }
    }
}
