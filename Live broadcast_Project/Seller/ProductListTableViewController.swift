//
//  ProductListTableViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/16.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import SwiftyJSON

// 建立商品的Model
struct ItemsModel {
    let id: Int
    let name: String
    let description: String
    let stock: Int
    let cost: Int
    let price: Int
    let image: UIImage
}


class ProductListTableViewController: UITableViewController {
    
    var items = [ItemsModel]()
    
    // call fucn 要帶的 header 參數
    let header = Headers.init(token: UserDefaults.standard.value(forKey: UserDefaultKeys.token) as! String).header
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        // 清空再上一筆的資料，後面再去 append 才不會內容疊加
        items.removeAll()
        // 在 viewWillAppear 裡面 call API
        getApi(header)
    }
    
    func getApi(_ header: [String: String]){
        Request.getRequest(api: "/items", header: header) { (data, statusCode) in
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["response"].array else { return }
                    var itemDescription: String
                    var itemImage: UIImage
                    for item in response {
                        guard let id = item["id"].int else { return }
                        guard let name = item["name"].string else { return }
                        guard let stock = item["stock"].int else { return }
                        guard let cost = item["cost"].int else { return }
                        guard let price = item["unit_price"].int else { return }
                        if let description = item["description"].string {
                            itemDescription = description
                        } else {
                            itemDescription = ""
                        }
                        
                        if let imageURL = item["images"].string {
                            if let downloadImage = imageURL.downloadImage() {
                                itemImage = downloadImage
                            } else {
                                itemImage = UIImage(named: "icons8-camera")!
                            }
                        } else {
                            itemImage = UIImage(named: "icons8-camera")!
                        }
                        self.items.append(ItemsModel.init(id: id, name: name, description: itemDescription, stock: stock, cost: cost, price: price, image: itemImage))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            } else {
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ProductListTableViewCell
        
        cell.ProductListName.text = items[indexPath.row].name
        cell.ProductListCost.text =  String(items[indexPath.row].cost)
        cell.ProductListPrice.text = String(items[indexPath.row].price)
        cell.ProductListStock.text = String(items[indexPath.row].stock)
        cell.ProductListDescription.text = items[indexPath.row].description
        cell.ProductListImageView.image = items[indexPath.row].image
        
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, sourceView, completionHandler) in
            
            self.deleteProductList(self.header, indexPath.row, { (statusCode) in
                switch statusCode {
                case 200:
                    DispatchQueue.main.async {
                        self.items.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
//                        self.tableView.reloadData()
                    }
                    print("success")
                case 400:
                        print("Invalid parameters")
                case 401:
                        print("The token is required.")
                default:
                    break
                }
            })
            
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActionConfiguration
        
    }
    
    func deleteProductList (_ header:[String:String], _ row: Int, _ callBack: @escaping (Int) -> Void) {
        // 把 body 處理成後端開的格式
        let body: [String: Any] = ["items": [items[row].id]]
        Request.deleteRequest(api: "/items", header: header, body: body ) { (data, statusCode) in
            callBack(statusCode)
        }
    }
    //TODOLIS： 1. 查 escaping 用法 2.查 callBack 用法 3. URLRequest 深入了解

}

extension String {
    func downloadImage() -> UIImage? {
        guard let imageUrl = URL(string: self) else { return nil }
        do {
            let imageData = try Data(contentsOf: imageUrl)
            guard let image = UIImage(data: imageData) else { return nil }
            return image
        } catch {
            return nil
        }
    }
}
