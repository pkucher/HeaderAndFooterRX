//
//  MainViewModel.swift
//  HeaderandFooterTraining
//
//  Created by brq on 13/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import Foundation
import RealmSwift

class MainViewModel{
    
    public enum typeResponse {
        case ok
        case error
        case removed
        case logged
        case loginError
    }
    
    private let realm = try! Realm()
    var getData = User()
    
    public func getNumberOfUsers()-> Int{
        let realmObject = realm.objects(User.self)
            if realmObject != nil{
                return realmObject.count
            }else{
                return 0
            }
        }
    
    public func createUser(name:String, age:Int, password: String, phone:String, cpf:String, email:String)-> typeResponse{
        if !repeatUser(name: name, age: age){
            let myUser = User()
            myUser.name = name.trimmingCharacters(in: .whitespaces)
            myUser.age = age
            myUser.password = password.trimmingCharacters(in: .whitespaces)
            myUser.phone = phone.trimmingCharacters(in: .whitespaces)
            myUser.cpf = cpf.trimmingCharacters(in: .whitespaces)
            myUser.email = email.trimmingCharacters(in: .whitespaces)
            if (realm.objects(User.self).last?.id) != nil{
                myUser.id = (realm.objects(User.self).last?.id)!+1
            }
            try! realm.write {
                realm.add(myUser)
            }
            return .ok
        } else {
            return .error
        }
    }
    
    public func readLastUserData()-> User?{
        if let user = realm.object(ofType: User.self, forPrimaryKey: (realm.objects(User.self).last?.id)){
            return user
        } else {
            return nil
        }
    }
    
    func repeatUser(name: String, age: Int)-> Bool{
        let users = realm.objects(User.self)
        for user in users {
            if user.name == name && user.age == age{
                return true
            }
        }
        return false
    }
    
    public func getAllUsers()-> Results<User>{
        let usersArray = realm.objects(User.self)
        return usersArray
    }
    
    public func removeUser(id: Int)-> typeResponse{
        if let users:Results<User> = realm.objects(User.self) {
            for user in users{
                if user.id == id {
                    try! realm.write {
                        realm.delete(user)
                    }
                    return .removed
                }
            }
        }
        return .error
    }
    
    
    public func login(name:String, password: String)-> typeResponse{
        let users = realm.objects(User.self)
        for user in users{
            if user.name == name && user.password == password {
                return .logged
            }
        }
        return .loginError
    }
    
    
    public func edit(name: String, age: Int, password: String, phone: String, cpf:String, email:String){
         let name = name.trimmingCharacters(in: .whitespaces)
         let password = password.trimmingCharacters(in: .whitespaces)
         let phone = phone.trimmingCharacters(in: .whitespaces)
         let cpf = cpf.trimmingCharacters(in: .whitespaces)
         let email = email.trimmingCharacters(in: .whitespaces)
        try! realm.write{
            realm.create(
                User.self,
                value: [
                    "id":getData.id,
                    "name":name,
                    "age":age,
                    "password":password,
                    "phone":phone,
                    "cpf":cpf,
                    "email":email
                ],
                update: true
            )
        }
    }
}

