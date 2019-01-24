//
//  ViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/1/24.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
  
    @IBAction func LoginButton(_ sender: UIButton) {
        let manger = LoginManager()
        manger.logIn(readPermissions: [.publicProfile], viewController: self) { (result) in
            if let accessToken = AccessToken.current {
                print("access Token :\(accessToken)")
            }
            switch result {
            case .cancelled:
                print("cancel")
            case .failed(let error):
                print(error.localizedDescription)
            case .success(grantedPermissions: let grantedPermissions , declinedPermissions: let declinedPermissions, token: let token):
                print(grantedPermissions)
                print(declinedPermissions)
                print(token)
                print("Login in !!!!")
            }
            
        }
    }
        
}
    



