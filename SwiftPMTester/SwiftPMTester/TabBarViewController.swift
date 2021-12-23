//
//  TabBarViewController.swift
//  SwiftPMTester
//
//  Created by Nontapat Siengsanor on 17/11/2564 BE.
//

import AmitySDK
import AmityUIKit
import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let newsfeed = UINavigationController(rootViewController: AmityFeedViewController.make(feedType: .globalFeed))
        newsfeed.tabBarItem.title = "Newsfeed"
        
        let global = UINavigationController(rootViewController: AmityCommunityHomePageViewController.make())
        global.tabBarItem.title = "Globalfeed"
        
        let profileVC = ProfileViewController()
        let profile = UINavigationController(rootViewController: profileVC)
        profile.tabBarItem.title = "Profile"
        
        viewControllers = [ global,
                            newsfeed,
                            profile]
    }
    
}

class ProfileViewController: UIViewController {
    
    var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func buttonTapped() {
        AmityManager.shared.logout()
        
        UIApplication.shared.windows.first?.rootViewController = AmityManager.shared.currentVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
