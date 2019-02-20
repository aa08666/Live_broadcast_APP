//
//  PlaceAnOrder.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/20.
//  Copyright © 2019 柏呈. All rights reserved.
//
// 還沒做
import Foundation
import SwiftyJSON


struct PlaceAnOrd {
    
    func placeAnOrderAnalysis() {
        
    }
    
    
    
    
    
    
    func placeAnOderPostRequest(api:String, header:[String:String], body: [String:String], callBack: @escaping (_ data: Data, _ statusCode: Int) -> Void){
        guard let url = URL(string: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api" + api) else { return }
        var urlRequest = URLRequest(url: url)
        for headers in header {
            urlRequest.addValue(headers.value, forHTTPHeaderField: headers.key)
        }
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        urlRequest.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else { return }
            guard let httpUrlResponse = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            
            callBack(data, httpUrlResponse.statusCode)
        }
        task.resume()
    }
}

