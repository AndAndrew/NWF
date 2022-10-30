//
//  NewsTableViewCell.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 17.07.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let newsImageView : UIImageView = {
        let img = UIImageView()
        img.tintColor = .systemGray4
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let articleLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Rockwell", size: 13)
        lb.textAlignment = .left
        lb.numberOfLines = 3
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.lineBreakMode = .byWordWrapping
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let dateLabel : UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "Rockwell", size: 9)
        lb.textAlignment = .left
        lb.textColor = .gray
        lb.numberOfLines = 1
        lb.adjustsFontSizeToFitWidth = true
        lb.minimumScaleFactor = 0.5
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        newsImageView.layer.cornerRadius = 2
        newsImageView.clipsToBounds = true
        
        contentView.addSubview(articleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(newsImageView)
        
        let cellHeight = (contentView.frame.size.width / 4)
        NSLayoutConstraint.activate([
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            newsImageView.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width - 10) / 3),
            newsImageView.heightAnchor.constraint(equalToConstant: cellHeight),
            
            articleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            articleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 5),
            articleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            articleLabel.heightAnchor.constraint(equalToConstant: (cellHeight / 3) * 2),
            
            dateLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
