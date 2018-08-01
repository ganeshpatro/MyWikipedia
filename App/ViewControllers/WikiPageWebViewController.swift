//
//  WikiPageWebViewController.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/2/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit
import WebKit

class WikiPageWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if urlString != nil,
            let url = URL.init(string: urlString!) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
