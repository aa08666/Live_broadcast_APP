//
//  StartLiveViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/18.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import SwiftyJSON
var isStream = Bool()

class StartLiveViewController: UIViewController {
    
    let header = Headers.init(token: UserDefaults.standard.value(forKey: UserDefaultKeys.token) as! String).header

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var endButton: UIButton!
    
    // 結束直播
    @IBAction func turnOffStream(_ sender: UIButton){
        putRequest(api: "/users-channel-id", header: header) { (data, statusCode) in
            if statusCode == 200 {
                print(statusCode)
                DispatchQueue.main.async {
                    self.title = nil
                }
//                self.endButton.changeButtonStatus(&self.startButton)
            } else {
                do {
                    let json = try JSON(data: data)
                    print(json)
                    guard let response = json["response"].string else { return }
                    print(response)
                } catch {
                    print(error.localizedDescription)
                }
                
                
                print(statusCode)
            }
        }
    }
    
    // PUT
    func putRequest(api:String, header:[String:String], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for (key, value) in header {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        urlRequest.httpMethod = "PUT"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return }
            guard let httpUrlResponse = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            
            callBack(data, httpUrlResponse.statusCode)
        }
        task.resume()
    }
    
    @IBAction func startLiveButton(_ sender: UIButton) {
       let alert = UIAlertController(title: "Start your Channel ID", message: "Please type your Channel ID and TOKEN", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Channel ID"
        }
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Chanel token"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
        let iFrameTextField = alert.textFields![0] as! UITextField
        let chanelTextField = alert.textFields![1] as! UITextField
            guard let iframeText = iFrameTextField.text else { return }
            guard let chanelDescription = chanelTextField.text else { return }
            let body:[String:Any] =
                ["iFrame": iframeText,"channel_description": chanelDescription]
            self.startLive(self.header, body, callback: { (result, chanelToken) in
                if result {
                    DispatchQueue.main.async {
                        self.title = chanelToken
                    }
                    
                }
//                isStream = true
//                self.startButton.changeButtonStatus(&self.endButton)
//            self.title = chanelToken
                
            })
            
            
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func startLive( _ header: [String:String], _ body : [String:Any], callback: @escaping(_ result: Bool, _ chanelToken: String)->Void) {
        
        StartLiveStreamRequest(api: "/channel", header: header, body: body) { (data, statusCode) in
            print(statusCode)
            if statusCode == 200 {

                do{
                    let json = try JSON.init(data: data)
                    guard let result = json["result"].bool else { return }
                    guard let jsonResponse = json["response"].dictionary else { return }
                    guard let channelId = jsonResponse["channel_id"]?.int else { return }
                    guard let channelToken = jsonResponse["channel_token"]?.string else { return }
                  
                    
                    callback(result, channelToken)
                }catch{
                    print(error.localizedDescription)
                }
            }else{
                print(statusCode)
                let json = try! JSON(data: data)
                print(json)
            }
            
            
        }
    }
    

    func StartLiveStreamRequest(api:String, header:[String:String], body:[String:Any], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void) {
        
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        urlRequest.httpMethod = "POST"
        do {
            let bodys = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
            urlRequest.httpBody = bodys
            
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
// 讓開始直播時，使用者不能點再次點選，結束直播也是。
extension UIButton {
    func changeButtonStatus( _ button: inout UIButton) {
        self.isEnabled = false
        self.alpha = 0.5
        button.isEnabled = true
        button.alpha = 1.0
    }
    
}

