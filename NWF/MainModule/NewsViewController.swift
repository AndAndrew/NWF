//
//  NewsViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsTable: UITableView!
    let cellId = "Cell"
    var presenter: NewsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        newsTable.dataSource = self
        newsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupConstraints()
        presenter.showString()
    }
    
    private func setupViews() {
        tabBarController?.tabBar.tintColor = .systemRed
        
        newsTable = UITableView()
        newsTable.backgroundColor = .clear
        newsTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newsTable)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsTable.topAnchor.constraint(equalTo: view.topAnchor),
            newsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "news"
        cell.backgroundColor = .clear
        return cell
    }
}

extension NewsViewController: NewsViewProtocol {
    func setString(string: String) {
    }
}
