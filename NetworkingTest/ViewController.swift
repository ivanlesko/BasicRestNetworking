//
//  ViewController.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let viewModel = ViewModel(provider: DataProvider())
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupObservers()
        setupUI()
        fetchUserList(forPage: 1)
    }
    
    private func setupObservers() {
        viewModel.$userList
            .receive(on: RunLoop.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func fetchUserList(forPage page: Int) {
        viewModel.fetchUserList(forPage: page)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let user = viewModel.userList.data[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = user.firstName + " " + user.lastName
        content.secondaryText = user.email
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList.data.count
    }
}

