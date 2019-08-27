//
//  textFieldExtension.swift
//  HeaderandFooterTraining
//
//  Created by brq on 20/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func personalize(placeholder:String, secure: Bool, keybordType: UIKeyboardType){
        
    self.placeholder = placeholder
    self.borderStyle = .roundedRect
    self.isSecureTextEntry = secure
    self.keyboardType = keybordType
    self.resignFirstResponder()
        
    }
    
}

