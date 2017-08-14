//
//  InStoreTableViewCell.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class InStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func addQuantity(_ sender: Any) {
//        numberLabel.text = String(Int(numberLabel.text!)! + 1)
//    }
//    
//    
//    @IBAction func reduceQuantity(_ sender: Any) {
//        numberLabel.text = String(Int(numberLabel.text!)! - 1)
//
//    }

}
