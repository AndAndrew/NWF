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
        
        view.backgroundColor = .systemGray6
        setupViews()
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.register(NewsTableViewCell.self, forCellReuseIdentifier: cellId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsTableViewCell
        let newsImage = UIImage(systemName: "doc.text.image")
        cell.newsImageView.image = newsImage
        cell.newsImageView.contentMode = .scaleAspectFill
        
        guard let article = presenter.news?.articles[indexPath.row] else { return cell }
        
        DispatchQueue.global().async {
            guard let urlToImage = article.urlToImage else { return }
            if let url = URL(string: urlToImage) {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    cell.newsImageView.image = UIImage(data: data)
                }
            }
        }
        cell.articleLabel.text = article.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let labelDateFormatter = DateFormatter()
        labelDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: article.publishedAt)
        if Calendar.current.isDateInToday(date!) {
            cell.dateLabel.text = "today"
        } else {
            cell.dateLabel.text = labelDateFormatter.string(from: date!)
        }
        
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
