//
//  AddRecipientAddressViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/20.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddRecipientAddressViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var postCodeTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var othersTextField: UITextField!
    
    

    
    
    
    
    let header = Headers.init(token: UserDefaults.standard.value(forKey: UserDefaultKeys.token) as! String).header
    
    
    @IBAction func addAddressButton(_ sender: UIButton) {
        
        guard let name = nameTextField.text else { return }
        guard let phoneCode = phoneCodeTextField.text else { return  }
        guard let phoneNumber = phoneNumberTextField.text else { return  }
        guard let countryCode = countryCodeTextField.text else { return  }
        guard let postCode = postCodeTextField.text else { return  }
        guard let city = cityTextField.text else { return  }
        guard let district = districtTextField.text else { return  }
        guard let others = othersTextField.text else { return  }
        guard let postCodeInt = Int(postCode) else { return  }
        let alert = UIAlertController(title: "新增商品", message: "你已新增成功", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        
        
        let body: [String:Any] = [
            "name":name,
            "phone":
                ["phone_code":phoneCode,"phone_number":phoneNumber],
            "address":["country_code":countryCode,"post_code":postCodeInt,"city":city,"district":district,"others":others]
        ]
        
        self.addRecipientAddressRequest(api: "/recipients", header: header, body: body) { (data, statusCode) in
            do{
                let json = try JSON(data: data)
                switch statusCode {
                case 200:
                    guard let result = json["result"].bool else {return}
                    self.present(alert, animated: true, completion: nil)
                case 400:
                    print(statusCode)
                case 401:
                    print(statusCode)
                default:
                    print(statusCode)
                }
                
            } catch {
                
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    
    func addRecipientAddressRequest(api:String, header:[String:String], body: [String: Any], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        
        do {
            // 這邊要處理的是：
            //   把 body 處理成後端要的格式，然後編碼成DATA，在利用 URLSession (通道) 發送 request過去，後端把 DATA 解碼後就會是以我們處理好的格式呈現。
            let body = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = body
            urlRequest.httpMethod = "POST"
            
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else { return }
                guard let httpUrlResponse = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                
                
                callBack(data, httpUrlResponse.statusCode)
            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }

    

    }
}
