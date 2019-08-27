
//
//  LoginViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 18/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    var header = UIView()
    var footer = UIView()
    var viewModel = MainViewModel()
    var tfName = UITextField()
    var tfPassword = UITextField()
    var input = UIButton()
    var register = UIButton()
    var lb = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupUI()
        bindUI()
        constrains()
    }
    
    
    func addSubview(){
        view.addSubviews([header,footer])
        header.addSubviews([tfName,tfPassword,lb])
        footer.addSubviews([register, input])
    }
    
    func setupUI(){
        view.backgroundColor = .white
        
        self.title = "Login"
        
        input.personalize(titleColor:.white , backgroundColor: .black, title: "Entrar")
        
        register.personalize(titleColor: .white, backgroundColor: .blue, title: "Cadastrar")

        tfName.personalize(placeholder: "Nome", secure: false, keybordType: .default)

        tfPassword.personalize(placeholder: "Senha", secure: true, keybordType: .default)
        
        lb.personalize(text: "Usuario ou senha digitados incorretamente", textColor: .red, font: UIFont.boldSystemFont(ofSize: 15), isHideen: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func dismissKeybord() {
        tfPassword.resignFirstResponder()
        tfName.resignFirstResponder()
    }
    
    func bindUI(){
        input.rx.tap.bind{
            if let name  = self.tfName.text{
                if let password = self.tfPassword.text{
                    if self.viewModel.login(name: name, password: password) == .logged{
                       let vc = MyViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        self.lb.isHidden = false
                    }
                }
            }
        }
        register.rx.tap.bind{
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func constrains(){
        
        
        header.anchor(top: (view.topAnchor, 0),
                      left: (view.leftAnchor, 0),
                      right: (view.rightAnchor, 0))
        
        
        tfName.anchor(top: (header.safeAreaLayoutGuide.topAnchor, 40),
                      left: (view.leftAnchor, 25),
                      right: (view.rightAnchor, 25),
                      height: 40)
        
        tfPassword.anchor(top: (tfName.bottomAnchor, 30),
                          left: (view.leftAnchor, 25),
                          right: (view.rightAnchor, 25),
                          height: 40)
        
        lb.anchor(top: (tfPassword.bottomAnchor, 10),
                  left: (view.leftAnchor, 25),
                  right: (view.rightAnchor, 25),
                  height: 20)
        
        
        footer.anchor(top: (header.bottomAnchor, 0),
                      left: (view.leftAnchor, 0),
                      right: (view.rightAnchor, 0),
                      bottom: (view.bottomAnchor, 0),
                      height: view.frame.size.height / 4)
        
        
        input.anchor(top: (footer.topAnchor, 0),
                     left: (view.leftAnchor, 25),
                     right: (view.rightAnchor, 25),
                     height: 50)
        
        register.anchor(top: (input.bottomAnchor, 20),
                        left: (view.leftAnchor, 25),
                        right: (view.rightAnchor, 25),
                        height: 50)
    }
}
