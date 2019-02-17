//
//  ProductListTableViewCell.swift
//  Live broadcast_Project
//
//  Created by 柏呈 on 2019/2/16.
//  Copyright © 2019 柏呈. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var ProductListImageView: UIImageView!
    
    @IBOutlet weak var ProductListDescription: UILabel!
    
    @IBOutlet weak var ProductListName: UILabel!
    
    @IBOutlet weak var ProductListStock: UILabel!
    
    @IBOutlet weak var ProductListCost: UILabel!
    
    @IBOutlet weak var ProductListPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
