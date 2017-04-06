//
//  IPGenerator.swift
//  IPAddressing
//
//  Created by Viral Thakkar on 4/6/17.
//  Copyright © 2017 WCL. All rights reserved.
//

import Foundation

class IPGenerator {
    
    var firstAddress: String
    var lastAddress: String
    
    init() {
        firstAddress = ""
        lastAddress = ""
    }
    
    init(f: String, l: String) {
        self.firstAddress = f
        self.lastAddress = l
    }
    
    func generate_addresses()-> Array<String>  {
        var cnt = 0;
        
        let f =  firstAddress.components(separatedBy: ".")
        let l =  lastAddress.components(separatedBy: ".")
        
        let first = f.flatMap { Int($0) }
        let last = l.flatMap{ Int($0) }
        
        var address: [String] = []
        let initial = String(first[0]) + "." + String(first[1]) + "."
        
        for i in first[2]...last[2] {
            for j in first[3]...last[3] {
                let str = initial + String(i) + "." + String(j)
                address.insert(str, at: cnt)
                cnt = cnt + 1
            }
        }
        
        return address
    }
    
    
}
