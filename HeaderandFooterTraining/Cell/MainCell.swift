//
//  MainCell.swift
//  HeaderandFooterTraining
//
//  Created by brq on 05/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    var myText:String!{
        didSet{
            selectionStyle = .none
            textLabel?.text = myText
            backgroundColor = .green
        }
    }
}
