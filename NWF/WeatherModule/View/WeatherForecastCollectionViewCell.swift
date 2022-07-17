//
//  WeatherForecastCollectionViewCell.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 13.05.2022.
//

import UIKit

class WeatherForecastCollectionViewCell: UICollectionViewCell {
    
    let stackview: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .vertical
        
        return sv
    }()
    
    let dateLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textAlignment = .center
        
        return date
    }()
    
    let temperatureLabel: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.textAlignment = .center
        
        return temperature
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 7
        contentView.backgroundColor = .systemGray5
        
        contentView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackview.addArrangedSubview(dateLabel)
        stackview.addArrangedSubview(temperatureLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
