//
//  GetStreamingItemsInformation .swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/19.
//  Copyright © 2019 柏呈. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class GetStreamingItemsInformation: UIViewController {
    
    @IBOutlet weak var getItemNameLabel: UILabel!
    @IBOutlet weak var getItemDescription: UILabel!
    @IBOutlet weak var getItemRemaningQuantityLabel: UILabel!
    @IBOutlet weak var getItemSoldQuantityLabel: UILabel!
    @IBOutlet weak var getItemUnitPrice: UILabel!
    @IBOutlet weak var getitemImageView: UIImageView!
    let header = Headers.init(token: UserDefaults.standard.value(forKey: UserDefaultKeys.token) as! String).header
    
    @IBAction func getItemInformationButton(_ sender: UIButton) {
            analysis(header)
        
        
    }
    
    func analysis( _ header: [String:String]) {
        
        Request.getRequest(api: "/streaming-items", header: header) { (data, statusCode) in
            do {
                let json = try JSON(data: data)
                guard let result = json["result"].bool else { return }
                guard let name = json["response"]["name"].string else { return }
                guard let description = json["response"]["description"].string else { return }
                guard let unitPrice = json["response"]["unit_price"].int else { return }
                guard let remaningQuantity = json["response"]["remaining_quantity"].int else { return }
                guard let soldQuantity = json["response"]["sold_quantity"].int else { return }
                guard let image = json["response"]["image"].string else { return }
                guard let itemImage = image.downloadImage() else { return }
                
                DispatchQueue.main.async {
                    self.getItemNameLabel.text = name
                    self.getItemDescription.text = description
                    self.getItemUnitPrice.text = String(unitPrice)
                    self.getItemRemaningQuantityLabel.text = String(remaningQuantity)
                    self.getItemSoldQuantityLabel.text = String(soldQuantity)
                }
               
                
                
                
                
                
                
                if result {
                    DispatchQueue.main.async {

                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
        
    }
}




//struct GetItemInformation {
//
//    func uploadProduct(_ itemImage: UIImage, _ name: String, _ description: String, _ remaningQuantity: String, soldQuantity: String, _ unitPrice: String, _ callBack: @escaping (Data) -> Void) {
//
//        guard let token = UserDefaults.standard.value(forKeyPath: UserDefaultKeys.token) as? String else { return }
//
//
//
////        let boundary = "Boundary+(\(arc4random())\(arc4random()))"
//        let imageData = itemImage.jpegData(compressionQuality: 0.2)
//
//
//
//        let body: [String:Any] = [
//            "name": name,
//            "description": description,
//            "remaining_quantity": remaningQuantity,
//            "sold_quantity": soldQuantity,
//            "unit_price": unitPrice,
//            "image": itemImage
//        ]
//
//        AF.upload(multipartFormData: { (multipart) in
//            multipart.append(imageData!, withName: "image", fileName: name, mimeType: "image/jpeg")
//            for (key, value) in body {
//                multipart.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
//        },usingThreshold: UInt64.init(), to: "https://facebookoptimizedlivestreamsellingsystem.rayawesomespace.space/api/items" , method: .post, headers: header).responseJSON { (reponse) in
//            if reponse.result.isSuccess {
//                if let data = reponse.data {
//                    callBack(data)
//                }
//            }
//        }
//    }
//
//
//
//}
