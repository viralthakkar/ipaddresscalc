//
//  IPListingViewController.swift
//  IPAddressing
//
//  Created by Viral Thakkar on 3/30/17.
//  Copyright © 2017 WCL. All rights reserved.
//

import UIKit

class IPListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
   
    let cellIdentifier = "iplist"
    
    var addr: IPGenerator!
    var addresses: [String] = []
    
    
    var firstAddress: String!
    var lastAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addr = IPGenerator(f: firstAddress, l: lastAddress)
        addresses = addr.generate_addresses()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        let data = addresses[indexPath.row]
        cell.textLabel?.text = data
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "IPView":
                if let svc = segue.destination as? IPDetailViewController {
                    let SelectRow = self.tableView.indexPathForSelectedRow?.row
                    svc.ip = addresses[SelectRow!]
                    let arArray =  addresses[SelectRow!].components(separatedBy: ".")
                    if Int(arArray[0])! >= 0 && Int(arArray[0])! < 128   {
                        svc.classofIP = "A"
                    } else if Int(arArray[0])! >= 128 && Int(arArray[0])! < 192   {
                        svc.classofIP = "B"
                    } else if Int(arArray[0])! >= 192 && Int(arArray[0])! < 224   {
                        svc.classofIP = "C"
                    } else if Int(arArray[0])! >= 224 && Int(arArray[0])! < 239   {
                        svc.classofIP = "D"
                    } else {
                        svc.classofIP = "E"
                    }
                }
            default:
                break
            }
        }
    }
    
}
