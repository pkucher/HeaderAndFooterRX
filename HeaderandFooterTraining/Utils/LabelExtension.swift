//
//  LabelExtension.swift
//  HeaderandFooterTraining
//
//  Created by brq on 20/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    func personalize(text: String, textColor:UIColor?, font:UIFont?, isHideen:Bool){
    self.text = text
    self.textColor = textColor
    self.font = font
    self.isHidden = isHideen
    self.textAlignment = .center
    }
}
