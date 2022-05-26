//
//  DetailNewsViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 26.05.2022.
//

import UIKit

class DetailNewsViewController: UIViewController {
    
    var presenter: DetailNewsViewPresenterProtocol!
    
    var newsTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray4
        setupViews()
        presenter.setNews()
        setupConstrainst()
    }
    
    private func setupViews() {
        
        newsTextView = UITextView()
        newsTextView.backgroundColor = .clear
        newsTextView.translatesAutoresizingMaskIntoConstraints = false
        newsTextView.font = UIFont(name: "Rockwell", size: 17)
        view.addSubview(newsTextView)
    }
    
    private func setupConstrainst() {
        
        NSLayoutConstraint.activate([
            
            newsTextView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailNewsViewController: DetailNewsViewProtocol {
    func setNews(news: News?, index: Int) {
        guard let news = news else { return }
        
        newsTextView.text = news.articles[index].content
    }
}
