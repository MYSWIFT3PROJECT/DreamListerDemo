//
//  ItemDetailVC.swift
//  DreamListerDemo
//
//  Created by macOSX on 2/12/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }

    
}
