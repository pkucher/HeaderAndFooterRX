//
//  UserModel.swift
//  HeaderandFooterTraining
//
//  Created by brq on 13/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    @objc dynamic var id = 0
    @objc dynamic var name = "" //limitar a quantidade de caractereres para 30 -ok
    @objc dynamic var age  = 0
    @objc dynamic var password = ""
    @objc dynamic var phone = ""
    @objc dynamic var cpf = "" // criar uma mascara para o cpf que nem a do telefone - ok
    @objc dynamic var email = "" // criar uma validacao do email - analisar o regex e entender como ele funciona
    
    override static func primaryKey() -> String?{
        return "id"
    }
}
