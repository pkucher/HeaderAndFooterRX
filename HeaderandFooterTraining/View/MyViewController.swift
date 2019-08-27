//
//  TableViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 05/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit
import RealmSwift

protocol ThemeDelegate {
    func changeColor(color:UIColor)
}

class MyViewController:UIViewController{
    
    // MARK: - Components
    enum  typeView {
        case `default`
        case Main
        case Login
    }
    
    var viewModel = MainViewModel()
     var delegate:ThemeDelegate?
    lazy var tableView:UITableView = {
        let tbl = UITableView(frame: .zero, style: .grouped)
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(MainCell.self, forCellReuseIdentifier: "cell")
        
        let headerTbl = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 100))
        
        let footerTbl = UIView(frame:CGRect(x: 0, y: 0, width: 0, height: 50))
        
        let backbt = UIButton()
        footerTbl.addSubview(backbt)
        backbt.setTitle("Voltar", for: .normal)
        backbt.backgroundColor = .black
        backbt.anchor(top: (footerTbl.topAnchor, 0),
                      left: (footerTbl.leftAnchor, 0),
                      right: (footerTbl.rightAnchor, 0),
                      bottom: (footerTbl.bottomAnchor, 0))
        
        backbt.rx.tap.bind {
            self.viewModel.getData = User()
            self.navigationController?.popToRootViewController(animated: true)
        }
        tbl.tableFooterView = footerTbl
        
        return tbl
    }()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        constrains()
        costumize()
        self.tableView.reloadData()
        //tableView.allowsSelection = false
        self.title = "Lista"
        viewModel.getData = User()
    }
    
    // MARK: - Custom Methods
    func addSubView(){
        view.addSubview(tableView)
    }
    
    func costumize(){
        view.backgroundColor = .white
    }
    
    func constrains(){
        tableView.anchor(
            top: (view.topAnchor, 0),
            left: (view.leftAnchor, 0),
            right: (view.rightAnchor, 0),
            bottom: (view.bottomAnchor, 0)
        )
    }

    @objc func backScreen(sender: UIButton){
        self.viewModel.getData = User()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func openView(view:typeView , user:User){
        switch view {
        case .Main:
            let vc = MainViewController()
            vc.viewModel.getData = user
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = WebViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Extensions
extension MyViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
        cell.textLabel?.text = "\(viewModel.getAllUsers()[indexPath.row].name)"
        viewModel.getData = viewModel.getAllUsers()[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfUsers()
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let user = User(value: viewModel.getAllUsers()[indexPath.row])
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") {  indexPath, action in
            self.openView(view: .Main, user: user)
            tableView.reloadData()
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {  indexPath, action in
            self.viewModel.removeUser(id: user.id)
            tableView.reloadData()
        }
        
         return [delete,edit]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = User(value: viewModel.getAllUsers()[indexPath.row])
        delegate?.changeColor(color: .red)
       // openView(view: .default, user: user)
    }
}
