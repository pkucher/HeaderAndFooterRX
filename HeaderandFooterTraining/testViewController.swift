//
//  testViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 29/08/2019.
//  Copyright © 2019 brq. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    
    var bt = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        bt.setTitle("Teste", for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        bt.backgroundColor = .red
        bt.translatesAutoresizingMaskIntoConstraints = false
        guard let heightLabel = bt.titleLabel?.frame.size.height else { return }
        bt.heightAnchor.constraint(equalToConstant: heightLabel).isActive = true
}
}
