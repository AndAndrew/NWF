//
//  DetailNewsViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 26.05.2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    var presenter: DetailNewsViewPresenterProtocol!
    
    var newsImage: UIImageView!
    var titleLabel: UILabel!
    var newsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        setupViews()
        presenter.setNews()
        setupConstrainst()
    }
    
    private func setupViews() {
        
        newsImage = UIImageView()
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFit
        view.addSubview(newsImage)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Rockwell", size: 25)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        newsTextView = UITextView()
        newsTextView.backgroundColor = .clear
        newsTextView.translatesAutoresizingMaskIntoConstraints = false
        newsTextView.font = UIFont(name: "Rockwell", size: 20)
        view.addSubview(newsTextView)
    }
    
    private func setupConstrainst() {
        let thirdOfViewHeight = (view.safeAreaLayoutGuide.layoutFrame.size.height - (tabBarController?.tabBar.frame.size.height ?? 0) - (navigationController?.navigationBar.frame.size.height ?? 0)) / 3
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: thirdOfViewHeight),
            
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            newsTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            newsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailNewsViewController: DetailNewsViewProtocol {
    func setNews(news: News?, index: Int) {
        guard let article = news?.articles[index] else { return }
        
        DispatchQueue.main.async { [self] in
            guard let urlToImage = article.urlToImage else { return }
            if let url = URL(string: urlToImage) {
                guard let data = try? Data(contentsOf: url) else { return }
                self.newsImage.image = UIImage(data: data)
            }
        }
        titleLabel.text = article.title
        newsTextView.text = article.content
    }
}
