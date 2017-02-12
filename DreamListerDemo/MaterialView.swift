//
//  MaterialView.swift
//  DreamListerDemo
//
//  Created by macOSX on 2/12/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit
private var materialkey = false
extension UIView {
    @IBInspectable var materailDesign:Bool{
        get{
            return materialkey
        }
        set{
            materialkey = newValue
            if materialkey{
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green:157/255, blue: 157/255, alpha: 1.0).cgColor
            }else{
                self.layer.cornerRadius = 0
                self.layer.shadowRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
