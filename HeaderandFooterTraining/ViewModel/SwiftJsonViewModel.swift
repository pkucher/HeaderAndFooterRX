//
//  SwiftJsonViewModel.swift
//  HeaderandFooterTraining
//
//  Created by brq on 11/01/2019.
//  Copyright © 2019 brq. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class SwiftJsonViewModel{
    
    private let realm = try! Realm()
    var getData = User()
    
    public func createJson(json:JSON){
            let myJson = json
            try! realm.write {
                realm.add(json.object as! Object)
            }
    }
    
}
