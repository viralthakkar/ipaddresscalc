//
//  IPDetailViewController.swift
//  IPAddressing
//
//  Created by Viral Thakkar on 4/3/17.
//  Copyright © 2017 WCL. All rights reserved.
//

import UIKit

class IPDetailViewController: UIViewController {

   
    @IBOutlet weak var IPShow: UILabel!
    @IBOutlet weak var classType: UILabel!
    
    var ip: String!
    var classofIP: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.IPShow.text = ip
        self.classType.text = classofIP
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
