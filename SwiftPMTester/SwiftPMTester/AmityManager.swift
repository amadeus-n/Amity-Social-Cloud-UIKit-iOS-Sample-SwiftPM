//
//  AmityManager.swift
//  SwiftPMTester
//
//  Created by Nontapat Siengsanor on 26/11/2564 BE.
//

import AmitySDK
import AmityUIKit

class AmityManager {
    
    enum Credential {
        static let apiKey = "YOUR_API_KEY"
        static let userId = "YOUR_USER_ID"
        static let displayName = "YOUR_DISPLAY_NAME"
        static let endpoint = AmityRegionalEndpoint.EU
    }
    
    static let shared = AmityManager()
    private init() { }
    
    var isLogin: Bool {
        return UserDefaults.standard.value(forKey: "userId") != nil
    }
    
    func setup() {
        AmityUIKitManager.setup(apiKey: Credential.apiKey, httpUrl: Credential.endpoint, socketUrl: Credential.endpoint)
        
        print("-> setup \(UserDefaults.standard.value(forKey: "userId") ?? "-")")
        if let currentUserId = UserDefaults.standard.value(forKey: "userId") as? String {
            login()
        }
    }
    
    func login(block: (() -> Void)? = nil) {
        
        AmityUIKitManager.registerDevice(withUserId: Credential.userId, displayName: Credential.displayName, authToken: nil) { (success, error) in
            if success {
                print("-> login successfully")
                UserDefaults.standard.setValue(Credential.userId, forKey: "userId")
                block?()
            } else {
                print("-> error")
            }
        }
        
    }
    
    func logout() {
        AmityUIKitManager.unregisterDevice()
        UserDefaults.standard.setValue(nil, forKey: "userId")
        UserDefaults.standard.synchronize()
    }
    
    var currentVC: UIViewController {
        if isLogin {
            return TabBarViewController()
        } else {
            return LoginViewController()
        }
    }

}

