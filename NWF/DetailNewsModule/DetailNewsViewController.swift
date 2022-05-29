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
    var labelsStack: UIStackView!
    var sourceStack: TwoLabelStack!
    var authorStack: TwoLabelStack!
    var publishedAtStack: TwoLabelStack!

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
        titleLabel.font = UIFont(name: "Rockwell", size: 30)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        newsTextView = UITextView()
        newsTextView.backgroundColor = .clear
        newsTextView.translatesAutoresizingMaskIntoConstraints = false
        newsTextView.font = UIFont(name: "Rockwell", size: 20)
        view.addSubview(newsTextView)
        
        sourceStack = TwoLabelStack()
        sourceStack.titleLabel.text = "Source:"
        sourceStack.titleLabel.textAlignment = .left
        sourceStack.contentLabel.textAlignment = .left
        
        authorStack = TwoLabelStack()
        authorStack.titleLabel.text = "Author:"
        authorStack.titleLabel.textAlignment = .left
        authorStack.contentLabel.textAlignment = .left
        
        publishedAtStack = TwoLabelStack()
        publishedAtStack.titleLabel.text = "Published at:"
        publishedAtStack.titleLabel.textAlignment = .left
        publishedAtStack.contentLabel.textAlignment = .left
        
        labelsStack = UIStackView()
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.distribution = .fillEqually
        labelsStack.axis = .vertical
        labelsStack.spacing = 5
        labelsStack.addArrangedSubview(sourceStack)
        labelsStack.addArrangedSubview(authorStack)
        labelsStack.addArrangedSubview(publishedAtStack)
        view.addSubview(labelsStack)
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
            newsTextView.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            
            labelsStack.topAnchor.constraint(equalTo: newsTextView.bottomAnchor, constant: 20),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelsStack.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2)
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
        sourceStack.contentLabel.text = article.source.name
        authorStack.contentLabel.text = article.author
        publishedAtStack.contentLabel.text = article.publishedAt
    }
}
