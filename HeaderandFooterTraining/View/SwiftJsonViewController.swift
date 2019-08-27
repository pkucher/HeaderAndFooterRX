//
//  SwiftJsonViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 11/01/2019.
//  Copyright © 2019 brq. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxCocoa
import RxSwift

class SwiftJsonViewController: UIViewController {
    
    //MARK:Components
    var viewModel = SwiftJsonViewModel()
    var header = UIView()
    var footer = UIView()
    var bt = UIButton()
    var lb = UILabel()
    var utils = Utils()
    var tfName = UITextField()
    var tfAge = UITextField()
    var tfPassword = UITextField()
    var tfPhone = UITextField()
    var tfEmail = UITextField()
    var tfCpf = UITextField()
    
    //MARK:Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        costumize()
        loadData()
        constrains()
        bindUI()
    }
    
    
    //MARK: Custom Methods
    func addSubviews(){
        view.addSubviews([header,footer])
        header.addSubviews([tfName,tfAge,tfCpf,tfEmail,tfPhone,tfPassword])
        footer.addSubviews([lb,bt])
    }
    
    func costumize(){
        view.backgroundColor = .white
        
        tfName.personalize(placeholder: "Nome", secure: false, keybordType: .default)
        tfPassword.personalize(placeholder: "Password", secure: true, keybordType: .decimalPad)
        tfPhone.personalize(placeholder: "Telefone", secure: false, keybordType: .decimalPad)
        tfEmail.personalize(placeholder: "Email", secure: false, keybordType: .default)
        tfCpf.personalize(placeholder: "CPF", secure: false, keybordType: .default)
        tfAge.personalize(placeholder: "Idade", secure: false, keybordType: .decimalPad)
        
        
        bt.personalize(titleColor: .white, backgroundColor: .black, title: "Gerar Json")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func constrains(){
        header.anchor(
            top: (view.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0)
        )
        
        
        tfName.anchor(
            top: (header.safeAreaLayoutGuide.topAnchor, 35),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        tfAge.anchor(
            top: (tfName.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        tfPassword.anchor(
            top: (tfAge.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        tfPhone.anchor(
            top: (tfPassword.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        tfCpf.anchor(
            top: (tfPhone.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        tfEmail.anchor(
            top: (tfCpf.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 40
        )
        
        lb.anchor(
            top: (tfEmail.bottomAnchor, 20),
            left: (view.leftAnchor, 25),
            right:(view.rightAnchor, 10),
            height: 30
        )
        
        
        footer.anchor(
            top: (header.bottomAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0),
            height: view.frame.size.height / 4
        )
        
        bt.anchor(top: (footer.topAnchor, 20),
                  left: (view.leftAnchor, 25),
                  right: (view.rightAnchor, 25),
                  height: 50)
    }
    
    func bindUI(){
        bt.rx.tap.bind{
            let json =
                JSON(["name": self.tfName.text,
                      "idade": self.tfAge.text,
                      "senha": self.tfPassword.text,
                      "email": self.tfEmail.text,
                      "cpf": self.tfCpf.text,
                      "telefone":self.tfCpf.text
                    ])
            self.viewModel.createJson(json: json)
            print(json)
        }
    }
    
    func loadData(){
        let user :User = viewModel.getData
        tfPhone.text = user.phone
        tfName.text = user.name
        tfPassword.text = user.password
        tfCpf.text = user.cpf
        tfEmail.text = user.email
        tfAge.text = "\(user.age)"
    }
}
