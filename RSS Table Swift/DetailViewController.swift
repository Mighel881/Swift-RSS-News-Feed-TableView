//
//  DetailViewController.swift
//  RSS Table Swift
//
//  Created by Aland Kawa on 8/10/16.
//  Copyright © 2016 Aland Kawa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var customNav: UINavigationBar!
    var url = ""
    var titleString = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customNav.topItem?.title = titleString
        
        let myURL = NSURL(string: url .stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        let request = NSURLRequest(URL: myURL!)
        
        self.webView.loadRequest(request)
        self.webView.delegate = self
    }
    @IBAction func closeBarButtonAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
