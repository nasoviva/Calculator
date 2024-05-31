//
//  ViewController.swift
//  Calculator
//
//  Created by Victoria on 26/05/2024.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    var numberIsTyping: Double = 0
    var firstOperand: Double = 0
    var operationSign: Bool = false
    var operationTag: Int = 0
    
    @IBAction func clearPressed(_ sender: UIButton) {
        if sender.tag == 17 {
            label.text = ""
            firstOperand = 0
            numberIsTyping = 0
            operationTag = 0
            operationSign = false
        }
        else if sender.tag == 15 {
            label.text!.removeLast()
        }
    }
    
    @IBAction func equalsPressed(_ sender: UIButton) {
        if operationTag == 11 {
            printResult(firstOperand + numberIsTyping)
        }
        else if operationTag == 12 {
            printResult(firstOperand - numberIsTyping)
        }
        else if operationTag == 13 {
            printResult(firstOperand * numberIsTyping)
        }
        else if operationTag == 14 {
            if numberIsTyping == 0 {
                printResult(0)
            }
            else {
                printResult(firstOperand / numberIsTyping)
            }
        }
        firstOperand = 0
        numberIsTyping = 0
        operationTag = 0
        operationSign = false
    }
    
    func printResult(_ number: Double) {
        if number == floor(number) {
            label.text = String(format: "%.0f", number)
        } else {
            label.text = String(number)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        var num = String(sender.tag)
        if sender.tag == 16 {
            num = "."
        }
        if operationSign == true {
            label.text = num
            operationSign = false
        }
        else if operationSign == false && firstOperand != 0 {
            label.text = label.text! + num
        } else {
            label.text = num
        }
        numberIsTyping = Double(label.text!)!
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        if label.text != "" {
            firstOperand = Double(label.text!)!
            if sender.tag == 11 {
                label.text = "+"
            }
            else if sender.tag == 12 {
                label.text = "-"
            }
            else if sender.tag == 13 {
                label.text = "x"
            }
            else if sender.tag == 14 {
                label.text = "/"
            }
            operationTag = sender.tag
            operationSign = true
        }
     }
}

