//
//  API.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/1/24.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation

struct UserDefaultKeys {
    static let token = "TokenKey"
}

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
    
    // GET
    static func getRequest(api:String, header:[String:String], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return }
            guard let httpUrlResponse = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
           
                callBack(data, httpUrlResponse.statusCode)
            }
        task.resume()
        }
    

    static func postRequest(api:String, header:[String:String], expirationDate:Date,callBack: @escaping (Data) -> Void){
        
        let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api)!
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
            //        urlRequest.addValue(<#T##value: String##String#>, forHTTPHeaderField: "Content-Type")
            //         urlRequest.addValue(<#T##value: String##String#>, forHTTPHeaderField: "X-Requested-With")
            //         urlRequest.addValue("asdd \(token)", forHTTPHeaderField: "Authorization")
            //  參照上面for in 的寫法
        }
        
        
        let body:[String:String] = ["expirationDate":"\(expirationDate)"]
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        urlRequest.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            guard let data = data, error == nil  else {
                print(error?.localizedDescription)
                return
            }
            callBack(data)
        }
        task.resume()
    }
    
    // DELETE
    static func deleteRequest(api:String, header:[String:String], body: [String: Any], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
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
            urlRequest.httpMethod = "DELETE"
            
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
    
    //PUT
    static func putRequest(api:String, header:[String:String], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
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
}

