//
//  TabBarViewController.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureController()
    }
    
    private func configureController() {
        let storyBoard = UIStoryboard(name: UBStoryBoard.Home, bundle: .main)
        let homeViewController = storyBoard
            .instantiateViewController(withIdentifier: HomeViewController.className)
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.title = "Home"
        
        self.viewControllers = [homeNavigationController]
    }

}
