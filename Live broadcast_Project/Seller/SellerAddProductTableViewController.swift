//
//  SellerAddProductTableViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/11.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit
import SwiftyJSON

var userDefault1 = UserDefaults.standard

class SellerAddProductTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let imagePickerVC = UIImagePickerController()
   
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productDescription: UITextField!
    
    @IBOutlet weak var productStock: UITextField!
    
    @IBOutlet weak var productCost: UITextField!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    
    
    
    // 設一個 Button 裡面 Call AddNewItem 這個 function (推送商品資料到商品列表中)
    @IBAction func createProductButton(_ sender: UIButton){
        guard let image = productImageView.image else { return }
        guard let name = productName.text else { return }
        guard let description = productDescription.text else { return }
        guard let stock = productStock.text else { return }
        guard let cost = productCost.text else { return }
        guard let price = productPrice.text else { return }
        
        AddNewItem().uploadProduct(image, name, description, stock, productCost: cost, price) { (data) in
            do {
                let json = try JSON(data: data)
                guard let result = json["result"].bool else { return }
                
                if result {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func addProductPhoto(_ sender: UIButton) {
        let imagePickerVC = UIImagePickerController()
        
        // 設定相片的來源為行動裝置的相本
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        
        // 設定顯示模式為 popover
        imagePickerVC.modalPresentationStyle = .popover
        let popover = imagePickerVC.popoverPresentationController
        
        // 設定 popover 視窗與哪一個view 元件有關聯
        popover?.sourceView = sender
        
        // 處理 popover 的箭頭位置
        popover?.sourceRect = sender.bounds
        popover?.permittedArrowDirections = .any
        
        show(imagePickerVC, sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            switch imagePickerVC.sourceType {
            case .camera:
                break
            case .photoLibrary:
                productImageView.image = image
            default:
                break
            }

            dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            
            
            // 設定相片的來源為行動裝置的相本
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.delegate = self
            
            //  設定顯示模式為 popover
            imagePickerVC.modalPresentationStyle = .popover
            let popover = imagePickerVC.popoverPresentationController
            
            // 設定 popover 視窗與哪一個view 元件有關聯
            if let cell = self.tableView.cellForRow(at: indexPath){
                popover?.sourceView = cell
                popover?.sourceRect = cell.bounds
                popover?.permittedArrowDirections = .any
            }
            
            //  popover?.sourceView = sender
            // 處理 popover 的箭頭位置
            //popover?.sourceRect = sender.bounds
            // popover?.permittedArrowDirections = .any

            show(imagePickerVC, sender: self)

        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
