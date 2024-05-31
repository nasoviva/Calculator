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
        label.text = ""
        firstOperand = 0
        numberIsTyping = 0
        operationTag = 0
        operationSign = false
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
            printResult(firstOperand / numberIsTyping)
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
        if operationSign == true {
            label.text = String(sender.tag)
            operationSign = false
        }
        else if operationSign == false && firstOperand != 0 {
            label.text = label.text! + String(sender.tag)
        } else {
            label.text = String(sender.tag)
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

