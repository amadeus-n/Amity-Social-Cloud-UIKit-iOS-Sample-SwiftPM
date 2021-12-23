//
//  ViewController.swift
//  SwiftPMTester
//
//  Created by Nontapat Siengsanor on 2/8/2564 BE.
//

import AmitySDK
import UIKit
import AmityUIKit

class LoginViewController: UIViewController {
    
    let loginButton = UIButton()
    let warninglabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login as \"\(AmityManager.Credential.userId)\"", for: .normal)
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 12
        loginButton.clipsToBounds = true
        loginButton.setTitleColor(.white, for: .normal)
        view.addSubview(loginButton)
        
        warninglabel.translatesAutoresizingMaskIntoConstraints = false
        warninglabel.numberOfLines = 0
        warninglabel.textAlignment = .center
        warninglabel.text = "This is production env. Please do not create any posts or communities."
        warninglabel.textColor = .black
        warninglabel.font = .boldSystemFont(ofSize: 18)
        view.addSubview(warninglabel)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: warninglabel.topAnchor, constant: -60),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            warninglabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warninglabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            warninglabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warninglabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func buttonTapped() {
        if AmityManager.shared.isLogin {
            AmityManager.shared.logout()
        } else {
            AmityManager.shared.login() { 
                
                UIApplication.shared.windows.first?.rootViewController = AmityManager.shared.currentVC
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            
        }
    }

}
