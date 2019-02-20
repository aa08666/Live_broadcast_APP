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
    
    
    @IBAction func placeAnOrderButton(_ sender: UIButton) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        analysis(header)
    }
    
    @IBAction func getItemInformationButton(_ sender: UIButton) {
            analysis(header)
        
        
    }
    
    var showImage = UIImage()
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
                if let imageUrl = json["response"]["image"].string {
                    if let image = imageUrl.downloadImage() {
                        self.showImage = image
                    } else {
                        self.showImage =  UIImage(named: "icons8-camera")!
                    }
                }
                
                DispatchQueue.main.async {
                    self.getItemNameLabel.text = name
                    self.getItemDescription.text = description
                    self.getItemUnitPrice.text = String(unitPrice)
                    self.getItemRemaningQuantityLabel.text = String(remaningQuantity)
                    self.getItemSoldQuantityLabel.text = String(soldQuantity)
                    self.getitemImageView.image = self.showImage
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



