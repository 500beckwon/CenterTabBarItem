//
//  ViewController.swift
//  CenterTabBarItem
//
//  Created by GNComms on 2022/02/02.
//

/// 자료 출처
/// 참고 사이트 :  https://equaleyes.com/blog/2017/09/04/the-common-raised-center-button-problems-in-tabbar/
/// 전체 코드   :  https://github.com/equaleyes/raised-center-button-ios/blob/master/TabBarSolution/MainTabBar.swift

import UIKit

class ViewController: UIViewController {
    var nextButton = UIButton(type: .system)
    var hideButtoon = UIButton(type: .system)
    var tabHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(nextButton)
        view.addSubview(hideButtoon)
        
        nextButton.setTitle("Next VC", for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
       
        hideButtoon.translatesAutoresizingMaskIntoConstraints = false
        hideButtoon.setTitle("TabbarHidden", for: . normal)
        hideButtoon.setTitleColor(.blue, for: .normal)
        hideButtoon.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100 )
        ])
        
        NSLayoutConstraint.activate([
            hideButtoon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hideButtoon.heightAnchor.constraint(equalToConstant: 50),
            hideButtoon.widthAnchor.constraint(equalToConstant: 100),
            hideButtoon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabHidden = false
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.layer.zPosition = 0
    }

    @objc func nextButtonTapped() {
        let vc = SampleViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    @objc func hideButtonTapped() {
        tabHidden = !tabHidden
        tabBarController?.tabBar.layer.zPosition = tabHidden ? -1: 0
        tabBarController?.tabBar.isHidden = tabHidden
    }
}

