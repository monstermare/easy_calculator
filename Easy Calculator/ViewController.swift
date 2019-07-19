//
//  ViewController.swift
//  Easy Calculator
//
//  Created by TaeYoun Kim on 7/9/19.
//  Copyright © 2019 TaeYoun Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    var stage:Int = 0;
    var currNumber:Double? = 0
    var prevNumber:Double?
    var ansNumber:Double?
    var opButton:UIButton?
    
    @IBAction func numbers(_ sender: UIButton) {
        print(sender.tag)
        let num:Int = sender.tag%10
        switch stage {
        case 1:
            if !(label.text == "0" && num == 0){
                label.text = label.text! + String(num)
                currNumber = Double(label.text!)!
            }
        case 2:
            label.text = String(num)
            currNumber = Double(num)
            stage = 3
        case 3:
            if !(label.text == "0" && num == 0){
                label.text = label.text! + String(num)
                currNumber = Double(label.text!)!
            }
        case 4:
            label.text = String(num)
            currNumber = Double(num)
            stage = 1
        case 6:
            label.text = String(num)
            currNumber = Double(num)
            stage = 8
        case 7:
            label.text = String(num)
            currNumber = Double(num)
            stage = 1
        case 8:
            if !(label.text == "0" && num == 0){
                label.text = label.text! + String(num)
                currNumber = Double(label.text!)!
            }
        default:
            label.text = String(num)
            currNumber = Double(num)
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            stage = 1
            clearButton.titleLabel!.text = "C"
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        let tag = sender.tag
        if(tag != 11 && tag != 16){ // operators
            operators(sender)
        }else if(tag == 16){ // calculation
            enter()
        }else if(tag == 11){ // clear
            clear()
        }
    }
    
    func operators(_ sender: UIButton) {
        let tag = sender.tag
        switch stage {
        case 1:
            prevNumber = currNumber
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
            stage = 2
        case 2:
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
        case 3:
            opButton!.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton!.setTitleColor(UIColor.white, for: .normal)
            ansNumber = calculation(opButton!.tag, prevNumber, currNumber)
            if(ansNumber == nil){
                label.text = "Undef."
                stage = 0
            }else{ // stage 5 begins
                label.text = String(ansNumber!)
                opButton = sender
                opButton!.backgroundColor = UIColor.white
                opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
                prevNumber = nil
                currNumber = nil
                stage = 6
            }
        case 4:
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
            stage = 6
        case 6:
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
        case 7:
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
            stage = 6
        case 8:
            opButton!.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton!.setTitleColor(UIColor.white, for: .normal)
            ansNumber = calculation(opButton!.tag, ansNumber, currNumber)
            if(ansNumber == nil){
                label.text = "Undef."
                stage = 0
            }else{ // stage 5 begins
                label.text = String(ansNumber!)
                opButton = sender
                opButton!.backgroundColor = UIColor.white
                opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
                prevNumber = nil
                currNumber = nil
                stage = 6
            }
        default:
            label.text = "0"
            currNumber = 0
            prevNumber = 0
            ansNumber = nil
            opButton = sender
            opButton!.backgroundColor = UIColor.white
            opButton!.setTitleColor(UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1), for: .normal)
            stage = 2
            clearButton.titleLabel!.text = "C"
        }
    }
    
    func enter(){
        switch stage {
        case 1:
            ansNumber = currNumber
            stage = 4
        //case 2:
        case 3:
            opButton!.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton!.setTitleColor(UIColor.white, for: .normal)
            ansNumber = calculation(opButton!.tag, prevNumber, currNumber)
            if(ansNumber == nil){
                label.text = "Undef."
                stage = 0
            }else{
                label.text = String(ansNumber!)
                opButton = nil
                stage = 4
            }
        //case 4: // TODO::do the same calculation recursively
        //case 6:
        //case 7:
        case 8:
            opButton!.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton!.setTitleColor(UIColor.white, for: .normal)
            ansNumber = calculation(opButton!.tag, ansNumber, currNumber)
            if(ansNumber == nil){
                label.text = "Undef."
                stage = 0
            }else{
                label.text = String(ansNumber!)
                opButton = nil
                stage = 4
            }
        default:
            label.text = "0"
            currNumber = nil
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            clearButton.titleLabel!.text = "AC"
        }
    }
    
    func clear(){
        let clearLabel = clearButton.titleLabel!
        switch stage {
        case 1:
            label.text = "0"
            currNumber = nil
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            clearLabel.text = "AC"
            stage = 0
        case 2:
            label.text = "0"
            currNumber = nil
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            clearLabel.text = "AC"
            stage = 0
        case 3:
            label.text = "0"
            currNumber = nil
            stage = 2
        case 4:
            label.text = "0"
            stage = 7
        case 6:
            label.text = "0"
            stage = 7
        case 7:
            label.text = "0"
            currNumber = nil
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            clearLabel.text = "AC"
            stage = 0
        case 8:
            label.text = "0"
            currNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            stage = 6
        default:
            label.text = "0"
            currNumber = nil
            prevNumber = nil
            ansNumber = nil
            opButton?.backgroundColor = UIColor(red: 255/255, green: 147/255, blue: 0, alpha: 1)
            opButton?.setTitleColor(UIColor.white, for: .normal)
            opButton = nil
            clearLabel.text = "AC"
        }
    }
    
    func calculation(_ op: Int, _ first: Double?, _ second: Double?) -> Double?{
        if(first == nil || second == nil){
            return nil
        }
        let left = first!
        let right = second!
        switch op {
        case 12:
            if(right == 0){
                return nil
            }
            return left / right
        case 13:
            return left * right
        case 14:
            return left - right
        case 15:
            return left + right
        default:
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

