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
    var newsTextLabel: UILabel!
    var labelsStack: UIStackView!
    var linkButton: UIButton!
    var sourceStack: TwoLabelStack!
    var authorStack: TwoLabelStack!
    var publishedAtStack: TwoLabelStack!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        setupViews()
        presenter.setNews()
        setupConstrainst()
    }
    
    private func setupViews() {
        
        newsImage = UIImageView()
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.contentMode = .scaleAspectFill
        newsImage.clipsToBounds = true
        view.addSubview(newsImage)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Rockwell", size: 30)
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)
        
        newsTextLabel = UILabel()
        newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        newsTextLabel.font = UIFont(name: "Rockwell", size: 20)
        newsTextLabel.sizeToFit()
        newsTextLabel.numberOfLines = 0
        newsTextLabel.textAlignment = .left
        view.addSubview(newsTextLabel)
        
        linkButton = UIButton(type: .system)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.setTitleColor(.black, for: .normal)
        view.addSubview(linkButton)
        
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
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 34),
            
            newsTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            newsTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsTextLabel.heightAnchor.constraint(equalToConstant: thirdOfViewHeight / 2),
            
            linkButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 20),
            linkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            linkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            labelsStack.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 20),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
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
        newsTextLabel.text = article.content
        linkButton.setTitle(article.url, for: .normal)
        sourceStack.contentLabel.text = article.source.name
        authorStack.contentLabel.text = article.author
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let labelDateFormatter = DateFormatter()
        labelDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.date(from: article.publishedAt)
        publishedAtStack.contentLabel.text = labelDateFormatter.string(from: date!)
    }
}
