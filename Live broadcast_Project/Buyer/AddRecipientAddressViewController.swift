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
        
        guard let name = nameTextField.text,
            let phoneNumber = phoneNumberTextField.text,
            let phoneCode = phoneCodeTextField.text,
            let countryCode = countryCodeTextField.text,
            let postCode = postCodeTextField.text,
            let city = cityTextField.text,
            let district = districtTextField.text,
            let others = othersTextField.text,
            let postCodeInt = Int(postCode) else { return  }
        
        alertFunc("新增商品", "你已新增成功", "取消", "確認")
        

        
        let body = Body(name: name, phoneCode: phoneCode, phoneNumber: phoneNumber, countryCode: countryCode, postCode: postCode, city: city, district: district, others: others, postCodeInt: postCodeInt)
       
        self.addRecipientAddressRequest(api: "/recipients", headers: header, body: body.myBody) { (data, statusCode) in
            
            
            
            
            do{
                let json = try JSON(data: data)
                switch statusCode {
                case 200:
                    guard let result = json["result"].bool else {return}
                    print(result)
                case 400:
                    print(statusCode)
                case 401:
                    print(statusCode)
                default:
                    print(statusCode)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func alertFunc(_ controllerTitle: String, _ controllermessage: String, _ actionTitle: String, _ secondActionTitle: String) {
        let alertController = UIAlertController(title: controllerTitle, message: controllermessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(secondAlertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func addRecipientAddressRequest(api:String, headers:[String:String], body: [String: Any], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
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

struct Body {
    var myBody: [String:Any] {
        let body: [String:Any] = [
            "name":name,
            "phone":
                ["phone_code":phoneCode,
                 "phone_number":phoneNumber],
                "address":["country_code":countryCode,
                           "post_code":postCodeInt,
                           "city":city,
                           "district":district,
                           "others":others]
        ]
        return body
    }
    var name: String
    var phoneCode: String
    var phoneNumber: String
    var countryCode: String
    var postCode: String
    var city: String
    var district: String
    var others: String
    var postCodeInt: Int
    
   
}
