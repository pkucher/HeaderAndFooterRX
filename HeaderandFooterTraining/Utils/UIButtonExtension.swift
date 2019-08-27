//
//  UIButtonExtension.swift
//  HeaderandFooterTraining
//
//  Created by brq on 18/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func personalize(titleColor: UIColor?, backgroundColor: UIColor?, title: String?){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }
}
