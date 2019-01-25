//
//  API.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/1/24.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation

struct Headers {
    let header: [String: String]
    
    
    init(token: String) {
        header = [
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer \(token)"
        ]
    }
}


struct Request {
    
    static func getRequest(callURL:String, header:[String:String], callBack: @escaping ([String:Any]) -> Void){
        let url = URL(string: callURL)
        var urlRequest = URLRequest(url: url!)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            guard let data = data, error == nil  else {
                print(error?.localizedDescription)
                return
            }
            let json_Response = try? JSONSerialization.jsonObject(with: data, options: [])
            if let jsonResponse = json_Response as? [String:Any] {
                callBack(jsonResponse)
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    static func postRequest(api:String, header:[String:String], expirationDate:Date,callBack: @escaping (Data) -> Void){
        
        let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)!
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        let body:[String:String] = ["expirationDate":"\(expirationDate)"]
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        urlRequest.httpMethod = "POST"
//        urlRequest.addValue(<#T##value: String##String#>, forHTTPHeaderField: "Content-Type")
//         urlRequest.addValue(<#T##value: String##String#>, forHTTPHeaderField: "X-Requested-With")
//         urlRequest.addValue("asdd \(token)", forHTTPHeaderField: "Authorization")
//  參照上面for in 的寫法

        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            guard let data = data, error == nil  else {
                print(error?.localizedDescription)
                return
            }
            callBack(data)
//            let json_Response = try? JSONSerialization.jsonObject(with: data, options: [])
//            // as?後面可以轉型成為自定義的Model   but!自定義的Model要完全符合
//            if let jsonResponse = json_Response as? [String:Any] {
//                callBack(jsonResponse)
//            }
        }
        task.resume()
    }
}
