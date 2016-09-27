//
//  ViewController.swift
//  GraphQLConnector
//
//  Created by TW-LostSeaWay on 9/5/16.
//  Copyright © 2016 TW-LostSeaWay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

private extension Client {
    struct TestRequst: RequestConstructable  {
        var baseURL: URL = URL(string: base)!
        var method: Method = .GET
        var queryParam: [String : AnyObject]? = ["query":"" as AnyObject]
     }
}


