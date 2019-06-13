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
let apiString = "https://facebookoptimizedlivestreamsellingsystem.rayoutstanding.space/api"

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
    static func getRequest(api: String, header:[String:String], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: apiString + api) else { return }
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
    
    // POST
    static func postRequest(api:String, header:[String:String], expirationDate:Date,callBack: @escaping (Data) -> Void){
        
        let url = URL(string: apiString + api)!
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
          
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
        guard let url = URL(string: apiString + api) else { return }
        var urlRequest = URLRequest(url: url)
        
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        
        do {
        
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
        guard let url = URL(string: apiString + api) else { return }
        var urlRequest = URLRequest(url: url)
        
//        for headers in header {
//            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
//        }
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
}

