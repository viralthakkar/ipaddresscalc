//
//  Calculation.swift
//  IPAddressing
//
//  Created by Viral Thakkar on 4/1/17.
//  Copyright © 2017 WCL. All rights reserved.
//

import Foundation

class Calculation {
    
    var part1: String
    var part2: String
    var part3: String
    var part4: String
    var netbits: String
    
    init() {
        part1 = ""
        part2 = ""
        part3 = ""
        part4 = ""
        netbits = ""
    }
    
    init(o1: String, o2: String, o3: String, o4: String, n: String) {
        self.part1 = o1
        self.part2 = o2
        self.part3 = o3
        self.part4 = o4
        self.netbits = n
    }
    
    
    func bin_netbits()-> Array<String> {
        let wholepart = Int(Int(netbits)!/8)
        let remainingpart = Int(netbits)!%8
        var subnet_array: [String] = ["00000000","00000000","00000000","00000000"]
        for i in 0..<wholepart {
            subnet_array[i] = String(repeating: "1", count: 8)
        }
        let remaining_str = String(repeating: "1", count: remainingpart)
        subnet_array[wholepart] = remaining_str.padding(toLength: 8, withPad: "0", startingAt: 0)
        return subnet_array
    }
    
    func complement()->Array<String> {
        let wholepart = Int(Int(netbits)!/8)
        let remainingpart = Int(netbits)!%8
        var complement_array: [String] = ["11111111","11111111","11111111","11111111"]
        for i in 0..<wholepart {
            complement_array[i] = String(repeating: "0", count: 8)
        }
        let remaining_str = String(repeating: "0", count: remainingpart)
        complement_array[wholepart] = remaining_str.padding(toLength: 8, withPad: "1", startingAt: 0)
        return complement_array
    }

    func subnet_mask() -> String {
        let items = bin_netbits()
        var subnetmask = ""
        for i in 0...3 {
            let num = items[i]
            let bin = Int(num, radix: 2)
            let dot = "."
            
            if(i != 3) {
                subnetmask = subnetmask + String(bin!) + dot
            } else {
                subnetmask = subnetmask + String(bin!)
            }
        }
        return subnetmask
    }
    
    
    func first_address() -> String {
        let subnetarray = bin_netbits()
        let r1 = String(Int(part1, radix: 2)! & Int(subnetarray[0], radix: 2)!)
        let r2 = String(Int(part2, radix: 2)! & Int(subnetarray[1], radix: 2)!)
        let r3 = String(Int(part3, radix: 2)! & Int(subnetarray[2], radix: 2)!)
        let r4 = String(Int(part4, radix: 2)! & Int(subnetarray[3], radix: 2)!)
        let final = r1 + "." + r2 + "." + r3 + "." + r4
        return final
    }
    
    func last_address() -> String {
        let complementarray = complement()
        let r1 = String(Int(part1, radix: 2)! | Int(complementarray[0], radix: 2)!)
        let r2 = String(Int(part2, radix: 2)! | Int(complementarray[1], radix: 2)!)
        let r3 = String(Int(part3, radix: 2)! | Int(complementarray[2], radix: 2)!)
        let r4 = String(Int(part4, radix: 2)! | Int(complementarray[3], radix: 2)!)
        let final = r1 + "." + r2 + "." + r3 + "." + r4
        return final
    }
    
    
    
}
