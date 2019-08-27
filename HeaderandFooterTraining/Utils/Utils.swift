//
//  Utils.swift
//  HeaderandFooterTraining
//
//  Created by brq on 07/01/2019.
//  Copyright © 2019 brq. All rights reserved.
//

import Foundation

public enum typeResponse {
    case ok
    case error
    case removed
    case logged
    case nameOrPasswordErro
}

class Utils{
    
    
    func emailValid(email:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"//regex do email
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let isValid = emailPredicate.evaluate(with: email)
        if(!isValid){
            return false
        }
        return true
    }
 
    func phoneNumberMask(phone:String)-> String{
        var fullNumber = ""
        switch phone.count {
        case 2:
            if !phone.contains("("){
                fullNumber = "(\(String(phone.prefix(2))))"
                return fullNumber
            }else{
                fullNumber = phone
                return String(fullNumber.removeLast())
            }
        case 9...10:
            if !phone.contains("-"){
                fullNumber = "\(phone)-"
                return fullNumber
            }else{
                fullNumber =  phone.replacingOccurrences(of: "-", with: "")
                return fullNumber
            }
        case 14...:
            return String(phone.prefix(14))
        default:
            return phone
        }
    }
    
    func nameLimiter(name:String)->String{
        if name.count >= 30{
            return String(name.prefix(30))
        }
        return name
    }
    
    func cpfMask(cpf:String)-> String{//xxx.xxx.xxx-xx
        //TO DO
        var finalCpf = ""
        switch cpf.count {
        case 3, 7:
            return "\(cpf)."
        case 4,8:
            finalCpf = cpf
            finalCpf.removeLast(1)
            return finalCpf
        case 11:
            if cpf.contains("-"){
                return cpf
            }else{
                return "\(cpf)-"
            }
        case 12:
            return cpf.replacingOccurrences(of: "-", with: "")
        default:
            return String(cpf.prefix(14))
        }
    }
    
    func cpfValidation(cpf:String)->Bool{//xxx.xxx.xxx-xx
        if cpf.count == 14{
            let ab = cpf.replacingOccurrences(of: ".", with: "")
            let c = ab.replacingOccurrences(of: "-", with: "")
            var number = (c.prefix(9).flatMap({Int(String($0))}))
            var b = 10
            var a = 0
            for i in stride(from: 0, through: number.count-1, by: 1) {
                a = a + (number[i] * b)
                b = b - 1
            }
            a = a % 11
            if a < 2{
                a = 0
            }else{
                a = 11 - a
            }
            number.append(a)
            a = 0
            b = 11
            for i in stride(from: 0, through: number.count-1, by: 1) {
                a = a + (number[i] * b)
                b = b - 1
            }
            a = a % 11
            if a < 2{
                a = 0
            }else if a >= 2{
                a = 11 - a
            }
            number.append(a)
            var cpfFinal = ""
            for i in 0...number.count - 1 {
                cpfFinal.append("\(number[i])")
            }
            if cpf.suffix(2) == cpfFinal.suffix(2){
                return true
            }
        }
        return false
    }
}

