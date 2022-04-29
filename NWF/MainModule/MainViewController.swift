//
//  MainViewController.swift
//  NWF
//
//  Created by Andrey Krivokhizhin on 29.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var label: UILabel!
    var presenter: MainViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: view.topAnchor),
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: MainViewProtocol {
    func setString(string: String) {
        label.text = string
    }
}
