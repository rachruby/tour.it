//
//  UIView+Extension.swift
//  Tour.it
//
//  Created by Swift Admin on 2022-07-27.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
