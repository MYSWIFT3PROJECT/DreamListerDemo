//
//  ItemViewCell.swift
//  DreamListerDemo
//
//  Created by macOSX on 2/12/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var thumb:UIImageView!
    @IBOutlet weak var carTitle:UILabel!
    @IBOutlet weak var carPrice:UILabel!
    @IBOutlet weak var carDecritption:UILabel!
    func configureCell(item:Item){
        carTitle.text = item.title
        carPrice.text = "\(item.price)"
        carDecritption.text = item.detail
    }
}
