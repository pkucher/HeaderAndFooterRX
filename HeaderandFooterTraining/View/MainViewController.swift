//
//  MainViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 05/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class MainViewController: UIViewController {
    // MARK: Components
    
    enum typeUseScreen{
        case edit
        case register
    }
    
    var header = UIView()
    var footer = UIView()
    var bt = UIButton()
    var bt2 = UIButton()
    var nextScreen = UIButton()
    var lb = UILabel()
    var viewModel = MainViewModel()
    var utils = Utils()
    var tfName = UITextField()
    var tfAge = UITextField()
    var tfPassword = UITextField()
    var tfPhone = UITextField()
    var tfEmail = UITextField()
    var tfCpf = UITextField()
    var bag = DisposeBag()
    
    
    // MARK: Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
       // navBarCostumize()
        costumize()
        constrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        receiveData()
        bindUI()
    }
    
//    func navBarCostumize(){
//        navController.navigationBar.backgroundColor = .red
//        let navItem = UINavigationItem()
//        navItem.title = "Teste"
//        let leftButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(openTableView))
//        navItem.leftBarButtonItem = leftButton
//        navController.navigationBar.items? =  [navItem]
//    }
//    
    //MARK: Custom Methods
    func addSubView(){
        view.addSubviews([header,footer])
        header.addSubviews([tfName,tfAge,tfPassword,lb,tfPhone,tfCpf,tfEmail])
        footer.addSubview(nextScreen)
        if viewModel.getData != nil && viewModel.getData.name != ""{
            footer.addSubview(bt)
        }else{
            footer.addSubview(bt2)
        }
    }
    
    func bindUI(){
        if  viewModel.getData.name != "" {
            self.bt.rx.tap.bind{
                self.editData(
                    name: self.tfName.text ?? "",
                    age: Int(self.tfAge.text!) ?? 0 ,
                    password: self.tfPassword.text ?? "",
                    phone: self.tfPhone.text ?? "",
                    cpf: self.tfCpf.text ?? "",
                    email: self.tfEmail.text ?? ""
                )
            }
        } else {
            self.bt2.rx.tap.bind{
                self.saveData(
                    name: self.tfName.text ?? "",
                    age: Int(self.tfAge.text!) ?? 0 ,
                    password: self.tfPassword.text ?? "",
                    phone: self.tfPhone.text ?? "",
                    cpf: self.tfCpf.text ?? "",
                    email: self.tfEmail.text ?? ""
                )
            }
        }
        
        nextScreen.rx.tap.bind{
            self.openTableView()
        }
        
        tfEmail.rx.controlEvent(.editingDidEnd).subscribe({_ in
            self.emailValidation(email: self.tfEmail.text ?? "")
        })
        
        tfCpf.rx.controlEvent(.editingChanged).subscribe({_ in
            self.tfCpf.text = self.utils.cpfMask(cpf: self.tfCpf.text ?? "")
        })
        
        tfCpf.rx.controlEvent(.editingDidEnd).subscribe({_ in
            if self.utils.cpfValidation(cpf: self.tfCpf.text ?? ""){
                self.lb.text = "CPF Valido"
                self.lb.textColor = .green
                self.lb.isHidden = false
            } else {
                self.lb.text = "CPF Invalido"
                self.lb.textColor = .red
                self.lb.isHidden = false
            }
        })
        
        tfName.rx.controlEvent([.editingChanged]).asObservable().subscribe({_ in
            self.tfName.text = self.utils.nameLimiter(name: self.tfName.text ?? "")
        })
        
        self.tfPhone.rx.controlEvent([.editingChanged]).asObservable().subscribe({_ in
            self.tfPhone.text = self.utils.phoneNumberMask(phone: self.tfPhone.text ?? "")
        })
    }
    
    func costumize(){
        view.backgroundColor = .white
        tfName.personalize(placeholder: "Nome", secure: false, keybordType: .default)
        
        tfAge.personalize(placeholder: "Idade", secure: false, keybordType: .decimalPad)
        
        tfPassword.personalize(placeholder: "Senha", secure: true, keybordType: .default)
        
        tfPhone.personalize(placeholder: "Telefone", secure: false, keybordType: .decimalPad)
        
        tfCpf.personalize(placeholder: "CPF", secure: false, keybordType: .decimalPad)
        
        tfEmail.personalize(placeholder: "Email", secure: false, keybordType: .default)
        
        nextScreen.personalize(titleColor: nil, backgroundColor: .black, title: "Lista")
        
        bt.personalize(titleColor:.white , backgroundColor: .black, title: "Editar")
        
        bt2.personalize(titleColor: .white, backgroundColor: .black, title: "Confirmar")
        
        lb.personalize(
            text: "Não é possivel entrar pois nao tem ninguem cadastrado",
            textColor: .red,
            font: UIFont.boldSystemFont(ofSize: 12),
            isHideen: true
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func constrain(){
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
        
        
        nextScreen.anchor(
            top: (footer.topAnchor, 20),
            left: (view.leftAnchor, 25),
            right: (view.rightAnchor, 25),
            height: 50
        )
        
        if viewModel.getData.name != ""{
            bt.anchor(
                top: (nextScreen.bottomAnchor, 20),
                left: (view.leftAnchor, 25),
                right: (view.rightAnchor, 25),
                height: 50
            )
        }else{
            bt2.anchor(
                top: (nextScreen.bottomAnchor, 20),
                left: (view.leftAnchor, 25),
                right: (view.rightAnchor, 25),
                height: 50
            )
        }
    }
    
    func editData(name:String,age:Int, password:String,phone:String,cpf:String,email:String){
        self.viewModel.edit(
            name: name,
            age: age,
            password: password,
            phone: phone,
            cpf: cpf,
            email: email)
        self.viewModel.getData = User()
        self.openTableView()
    }
    
    func saveData(name:String,age:Int, password:String,phone:String,cpf:String,email:String){
        if self.viewModel.createUser(name: name, age: age, password: password, phone: phone, cpf: cpf, email: email) == .ok{
            self.openTableView()
        }else{
            lb.text = "Dados invalidos"
            lb.textColor = .red
            lb.isHidden = false
        }
    }
    
    func emailValidation(email:String){
        if self.utils.emailValid(email: email) {
            self.lb.personalize(text: "Email valido", textColor: .green, font: UIFont.systemFont(ofSize: 16), isHideen: false)
        }else{
            self.lb.personalize(text: "Email invalido", textColor: .red, font: UIFont.systemFont(ofSize: 16) , isHideen: false)
        }
    }
    
    @objc func openTableView(){
        if viewModel.getNumberOfUsers() != 0{
            let vc = MyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            lb.text = "Não é possivel entrar pois nao tem ninguem cadastrado"
            lb.textColor  = .red
            lb.isHidden = false
        }
    }
    
    func receiveData(){
        let data = viewModel.getData
        if  data.id != 0 || data.name != ""{
            self.title = "Editar"
            tfName.text = data.name
            tfAge.text = "\(data.age)"
            tfPassword.text = data.password
            tfPassword.isSecureTextEntry = false
            tfPhone.text = data.phone
            tfEmail.text = data.email
            tfCpf.text = data.cpf
        }else{
            self.title = "Cadastrar"
            tfName.text = ""
            tfAge.text = ""
            tfPassword.text = ""
            tfPhone.text = ""
            tfEmail.text = ""
            tfCpf.text = ""
        }
    }
}
