//
//  ViewController.swift
//  Habify
//
//  Created by Александр Эм on 22.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: PresenterProtocol?
    
    private lazy var introView: IntroductionView = {
        var view = IntroductionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.presenter = self.presenter
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(introView)
        setupContraints()
        self.view.backgroundColor = UIColor(named: "ButtonColor")
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            introView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            introView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            introView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }

}

