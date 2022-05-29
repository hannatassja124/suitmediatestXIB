//
//  WebviewVC.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 28/05/22.
//

import Foundation
import UIKit
import WebKit

class WebviewVC: UIViewController, UIWebViewDelegate, WKUIDelegate {
    
    //MARK: - Variable
    lazy var webView: WKWebView = {
            let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
            webView.uiDelegate = self
            webView.translatesAutoresizingMaskIntoConstraints = false
            return webView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyBackground()
        setup()
        setSubview()
        setAutoLayout()

    }
    
    //MARK: - Function
    func setup(){
        guard let url = URL(string: "https://suitmedia.com/") else {
            fatalError("No url found")
        }
        let req = URLRequest(url: url)
        webView.load(req)
    }
    
    func setSubview(){
        self.view.addSubview(webView)
    }
    
    func setAutoLayout(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 11).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 13).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -14).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -90).isActive = true
    }
    
}
