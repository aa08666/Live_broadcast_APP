//
//  addNewItems.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/13.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation
import Alamofire




var userDefault = UserDefaults.standard

struct Url {
    var url:String?
    init(url:String = "") {
        self.url = url
    }
}

struct AddNewItem {
    
    func uploadProduct(_ image: UIImage, _ productName: String, _ productDescription: String, _ productStock: String, productCost: String, _ productPrice: String, _ callBack: @escaping (Data) -> Void) {
        
        guard let token = UserDefaults.standard.value(forKeyPath: UserDefaultKeys.token) as? String else { return }
        
       
        
        let boundary = "Boundary+(\(arc4random())\(arc4random()))"
        let imageData = image.jpegData(compressionQuality: 0.2)
        let header:HTTPHeaders = [
            "Content-Type":"multipart/form-data; boundary=\(boundary)",
            "X-Requested-With": "XMLHttpRequest",
            "Authorization": "Bearer \(token)"
        ]
        
        let body: [String:String] = [
            "name": productName,
            "description": productDescription,
            "stock": productStock,
            "cost": productCost,
            "unit_price": productPrice
        ]
        
        AF.upload(multipartFormData: { (multipart) in
            multipart.append(imageData!, withName: "images", fileName: productName, mimeType: "image/jpeg")
            for (key, value) in body {
                multipart.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },usingThreshold: UInt64.init(), to: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api/items" , method: .post, headers: header).responseJSON { (reponse) in
            if reponse.result.isSuccess {
                if let data = reponse.data {
                    callBack(data)
                }
            }
        }
    }
   
    

}
