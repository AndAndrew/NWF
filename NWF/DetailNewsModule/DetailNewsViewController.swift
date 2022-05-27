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
        
        newsTextView = UITextView()
        newsTextView.backgroundColor = .clear
        newsTextView.translatesAutoresizingMaskIntoConstraints = false
        newsTextView.font = UIFont(name: "Rockwell", size: 17)
        view.addSubview(newsTextView)
    }
    
    private func setupConstrainst() {
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            
            newsTextView.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailNewsViewController: DetailNewsViewProtocol {
    func setNews(news: News?, index: Int) {
        guard let news = news else { return }
        
        guard let urlToImage = news.articles[index].urlToImage else { return }
        if let url = URL(string: urlToImage) {
            guard let data = try? Data(contentsOf: url) else { return }
            newsImage.image = UIImage(data: data)
        }
        newsTextView.text = news.articles[index].content
    }
}
