//
//  TwoLabelStack.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 19.05.2022.
//

import UIKit

class TwoLabelStack: UIStackView {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 20)
        title.minimumScaleFactor = 0.3
        title.adjustsFontSizeToFitWidth = true
        title.textAlignment = .center
        title.contentMode = .center
        
        return title
    }()
    
    let contentLabel: UILabel = {
        let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.font = UIFont.systemFont(ofSize: 20)
        content.minimumScaleFactor = 0.3
        content.adjustsFontSizeToFitWidth = true
        content.textAlignment = .center
        content.contentMode = .center
        
        return content
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        distribution = .fillEqually
        axis = .vertical
        spacing = 5
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(contentLabel)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
