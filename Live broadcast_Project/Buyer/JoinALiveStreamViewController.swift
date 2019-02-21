//
//  JoinALiveStreamViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/20.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import SwiftyJSON

class JoinALiveStreamViewController: UIViewController {

    
    @IBOutlet weak var joinALiveStreamTextField: UITextField!
    
    let header = Headers.init(token: UserDefaults.standard.value(forKey: UserDefaultKeys.token) as! String).header
    
    
    @IBAction func endALiveStreamButton(_ sender: UIButton) {
        
        Request.putRequest(api: "/user-channel-id", header: header) { (data, statusCode) in
            do{
                let json = try JSON(data: data)
                switch statusCode {
                case 200:
                    guard let result = json["result"].bool else {return}
                    guard let reponse = json["response"].string else {return}
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
    
    @IBAction func joinALiveSteamButton(_ sender: UIButton) {
        guard let joinTextField = joinALiveStreamTextField.text else {return}
        let body: [String:Any] = [
            "channel_token":joinTextField
        ]
        joinLiveStreamRequest(api: "/user-channel-id", header: header, body: body) { (data, statusCode) in
            do{
                let json = try JSON(data: data)
                switch statusCode {
                case 200:
                    guard let result = json["result"].bool else {return}
                    guard let reponse = json["response"].string else {return}
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
    
    
    func joinLiveStreamRequest(api:String, header:[String:String], body: [String: Any], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
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
            urlRequest.httpMethod = "PATCH"
            
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    

}
