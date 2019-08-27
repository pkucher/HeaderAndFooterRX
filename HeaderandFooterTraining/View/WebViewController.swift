//
//  WebViewController.swift
//  
//
//  Created by brq on 18/03/2019.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        if let url = URL(string: "https://www.google.com"){
        webView.load(URLRequest(url:url))
        }
        webView.backgroundColor = .green
        view.backgroundColor = .red
    }
}
