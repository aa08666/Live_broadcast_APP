//
//  SellerAddProductTableViewController.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/11.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit

class SellerAddProductTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var productPhoto: UIImageView!
    
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
        let image = info[.originalImage] as! UIImage
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let imagePickerVC = UIImagePickerController()
            
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
    
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
//}
}
