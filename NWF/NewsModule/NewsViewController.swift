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
        
        view.backgroundColor = .systemGray4
        setupViews()
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupConstraints()
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
        presenter.news?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let articleTitle = presenter.news?.articles[indexPath.row].title
        cell.textLabel?.text = articleTitle
        cell.backgroundColor = .clear
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = presenter.news
        let index = indexPath.item
        presenter.tapOnTableCell(navVC: self.navigationController!, news: news, index: index)
    }
}

extension NewsViewController: NewsViewProtocol {
    func success() {
        newsTable.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}
