//
//  ViewController.swift
//  IPAddressing
//
//  Created by Viral Thakkar on 3/29/17.
//  Copyright © 2017 WCL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var octet1: UITextField!
    @IBOutlet weak var octet2: UITextField!
    @IBOutlet weak var octet3: UITextField!
    @IBOutlet weak var octet4: UITextField!
    @IBOutlet weak var resultbtn: UIButton!
    @IBOutlet weak var netBits: UITextField!
    @IBOutlet weak var incdecnetbits: UIStepper!
    
    var firstAddress: String = ""
    var lastAddress: String = ""
    var subnetMask: String = ""
    
    var calc: Calculation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        octet1.tag = 0
        octet2.tag = 1
        octet3.tag = 2
        octet4.tag = 3
        netBits.tag = 4
        
        octet1.delegate = self
        octet2.delegate = self
        octet3.delegate = self
        octet4.delegate = self
        netBits.delegate = self
        
        incdecnetbits.autorepeat = true
        incdecnetbits.maximumValue = 32.0
        incdecnetbits.minimumValue = 22.0
        netBits.text = "\(Int(incdecnetbits.value))"
        incdecnetbits.addTarget(self, action: #selector(ViewController.stepperValueDidChange(_:)), for: .valueChanged)
    }
    
    
    @IBAction func stepperValueDidChange(_ sender: UIStepper) {
        let stepperMapping: [UIStepper: UITextField] = [incdecnetbits: netBits]
        stepperMapping[incdecnetbits]!.text = "\(Int(incdecnetbits.value))"
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        resultbtn.isEnabled = false
        resultbtn.alpha  = 0.5;
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { // do stuff
        
        switch (textField.tag) {
        case 0:
            if (octet1.text) == "" {
                return true
            }

            if Int(octet1.text!)! < 0 || Int(octet1.text!)! > 255   {
                let alert = UIAlertController(title: "Error", message: "It should be between 0 to 255", preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            break
        case 1:
            if (octet2.text) == "" {
                return true
            }

            
            if Int(octet2.text!)! < 0 || Int(octet2.text!)! > 255 {
                let alert = UIAlertController(title: "Error", message: "It should be between 0 to 255", preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            break
            
        case 2:
            if (octet3.text) == "" {
                return true
            }

            if Int(octet3.text!)! < 0 || Int(octet3.text!)! > 255 {
                let alert = UIAlertController(title: "Error", message: "It should be between 0 to 255", preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            break
            
        case 3:
            if (octet4.text) == "" {
                return true
            }

            if Int(octet4.text!)! < 0 || Int(octet4.text!)! > 255 {
                let alert = UIAlertController(title: "Error", message: "It should be between 0 to 255", preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            break
        
        case 4:
            if (netBits.text) == "" {
                return true
            }

            
            if Int(netBits.text!)! < 22 || Int(netBits.text!)! > 32 {
                let alert = UIAlertController(title: "Error", message: "It should be between 22 to 32", preferredStyle:UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            break
            
        default:
            break
        }
        
        return true
    }


    
    @IBAction func showResult(_ sender: Any) {
        let inputvalid = checkInput()
        
        if inputvalid {
            let result = "First Address: \(firstAddress)\nLast Address: \(lastAddress)\nSubnet Mask: \(subnetMask)"
            let alert = UIAlertController(title: "Result", message: result, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    
    func checkInput() -> Bool {
        let part1 = octet1.text!
        let part2 = octet2.text!
        let part3 = octet3.text!
        let part4 = octet4.text!
        let netmask = netBits.text!
    
        if !part1.isEmpty && !part2.isEmpty && !part3.isEmpty && !part4.isEmpty && !netmask.isEmpty {
            calc = Calculation(o1: bin_octet1(), o2: bin_octet2(), o3: bin_octet3(), o4: bin_octet4(), n: netmask)
            firstAddress = calc.first_address()
            lastAddress = calc.last_address()
            subnetMask = calc.subnet_mask()
            print(calc.last_address())
            return true
        }
        return false
    }
    
    
    func bin_octet1() -> String {
        let num = Int(octet1.text!)!
        let bin = String(num, radix: 2)
        return String(format: "%08ld", Int(bin)!)
    }
    
    func bin_octet2() -> String {
        let num = Int(octet2.text!)!
        let bin = String(num, radix: 2)
        return String(format: "%08ld", Int(bin)!)
    }
    
    func bin_octet3() -> String {
        let num = Int(octet3.text!)!
        let bin = String(num, radix: 2)
        return String(format: "%08ld", Int(bin)!)
    }
    
    func bin_octet4() -> String {
        let num = Int(octet4.text!)!
        let bin = String(num, radix: 2)
        return String(format: "%08ld", Int(bin)!)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let inputvalid = checkInput()
        if (segue.identifier == "IPList" && inputvalid) {
            let svc = segue.destination as! IPListingViewController;
            svc.firstAddress = firstAddress
            svc.lastAddress = lastAddress
        }
    }
    
    @IBAction func buttonAction(segue: UIStoryboardSegue){
        if segue.identifier == "ResetData"{
            octet4.text = ""
            octet2.text = ""
            octet1.text = ""
            netBits.text = "22"
            octet3.text = ""
        }
    }
       
}

