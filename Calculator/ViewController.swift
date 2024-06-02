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
    var result: String = ""


    @IBAction func clearPressed(_ sender: UIButton) {
        if sender.tag == 17 {
            clearAll()
        }
        else if sender.tag == 15 && label.text!.isEmpty == false {
            label.text!.removeLast()
        }
    }

    func clear () {
        firstOperand = 0
        numberIsTyping = 0
        operationTag = 0
        operationSign = false
       // result = ""
    }

    func clearAll() {
        clear()
        label.text = "0"
    }

    @IBAction func equalsPressed(_ sender: UIButton) {
      //  print(result)
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
        clear()
    }
    
    func printResult(_ number: Double) {
        if number >= (0 - 99999999999999) && number <= 999999999999999 {
            if number == floor(number) {
                label.text = String(format: "%.0f", number)
            } else {
                label.text = String(number)
            }
        }
        else {
            label.text = "Err"
        }
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if label.text!.count < 15 {
            let num = checkDot(sender.tag)
          //  result = result + num
            if operationSign == true {
                label.text = num
                operationSign = false
            }
            else if operationSign == false && label.text != "0" {
                label.text = label.text! + num
            }
            else  if operationSign == false && label.text == "0" {
                label.text = num
            }
            numberIsTyping = Double(label.text!)!
        }
    }

    func checkDot(_ tag: Int) -> String {
        if (label.text == "0" || label.text == "" || label.text == "+" || label.text == "-" || label.text == "*" || label.text == "/") && tag == 16 {
            return "0."
        } else if label.text!.contains(".") == false && tag == 16 {
           return "."
        } else if tag == 16 {
            return ""
        }
        return String(tag);
    }

    @IBAction func operationPressed(_ sender: UIButton) {
        if operationSign != true && label.text != "-" {
            firstOperand = Double(label.text!)!
            if sender.tag == 11 {
                label.text = "+"
            }
            else if sender.tag == 12 {
                label.text = "-"
            }
            else if sender.tag == 13 {
                label.text = "*"
            }
            else if sender.tag == 14 {
                label.text = "/"
            }
           // result = result + label.text!
            operationTag = sender.tag
            operationSign = true
        }
     }
}

