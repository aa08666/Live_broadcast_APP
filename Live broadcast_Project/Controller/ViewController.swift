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
import SwiftyJSON
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {
    let myLoadingAnimation = MyNVActivityIndicator()
    var userDefault = UserDefaults.standard
    
    let idvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IDViewController")

    override func viewDidLoad() {
        super.viewDidLoad()
        myLoadingAnimation.startAnimating()
        reuseConfirm()
        //start animation
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
                print(token.authenticationToken)
                print(token.expirationDate)
               
                F
                self.userDefault.setValue(token.authenticationToken, forKey: UserDefaultKeys.token)
                
                Request.postRequest(api: "/token", header: Headers.init(token: token.authenticationToken).header, expirationDate: token.expirationDate, callBack: { (callBack) in
                    DispatchQueue.main.async {
                       
                        let json = try? JSON(data: callBack)
                        if let jsonResult = json!["result"].bool {
                            if jsonResult {
//                               self.myLoadingAnimation.stopAnimating()
//                                self.navigationController?.pushViewController(self.idvc, animated: true)
                                self.reuseConfirm()
                            }
                        }
                        print(json!["response"].string)
                    }
                    print(callBack)
                })
                
            }
            
        }
        
    }
    
    func reuseConfirm(){
        
        guard let userToken = userDefault.value(forKey: UserDefaultKeys.token) as? String  else {
            print("animation stop")
            myLoadingAnimation.stopAnimation()
            return
        }
        
        Request.getRequest(api: "/users", header: Headers.init(token: userToken).header) { (callBack) in
            
            DispatchQueue.main.async {
                do {
                    let json = try JSON(data: callBack)
                    
                    
//                    json["result"].bool! ? self.navigationController?.pushViewController(self.idvc, animated: true) : self.errorAlert()
                    
                    guard json["result"].bool! else {
                        //stop animation
                        self.stopAnimating()
                        self.errorAlert()
                        return
                    }
                    //start snimation
                    
                    self.myLoadingAnimation.stopAnimating()
                    self.navigationController?.pushViewController(self.idvc, animated: true)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            
        }
        
        
    }
        
}

extension ViewController {
    
    func errorAlert(){
        let alertC = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
        let alertA = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertC.addAction(alertA)
        present(alertC, animated: true, completion: nil)
    }
}
    




