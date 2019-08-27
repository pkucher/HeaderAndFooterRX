//
//  RxSwiftViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 19/12/2018.
//  Copyright © 2018 brq. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class RxSwiftViewController: UIViewController {

    var bt = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = .white
        let hello = Observable.of("Hellow Swift")
    
        hello.subscribe { (event) in
            print(event)
        }
        
        let subscribe = "teste"
        let bag = DisposeBag()
        hello.subscribe { (event) in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }.disposed(by: bag)
    
        var publishSubject = PublishSubject<String>()
        
        
        let subscription1 = publishSubject.subscribe(onNext: {
            print($0)
        }).disposed(by: bag)
        
        publishSubject.onNext("HELLO")
        publishSubject.onNext("World")
        
        let subscription2 = publishSubject.subscribe(onNext:{
            print(#line, $0)
           self.view.backgroundColor = .red
        })
        
        publishSubject.onNext("Both Subscriptions receive this message")
        
        view.addSubview(bt)
        
        bt.anchor(centerX: (view.centerXAnchor , 10),
                  centerY: (view.centerYAnchor , 10),
                  width: 30,
                  height: 30 )
        
        bt.setTitle("teste", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.rx.tap.bind{
            self.view.backgroundColor = .white
            print("funcionou")
        }
    }


    
}
