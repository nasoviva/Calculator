//
//  ViewController.swift
//  Calculator
//
//  Created by Victoria on 26/05/2024.
//

import UIKit
import Expression
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var numberIsTyping: Double = 0
    var firstOperand: Double = 0
    var operationSign: Bool = false
    var operationEquels: Bool = false
    var result: String = ""


    @IBAction func clearPressed(_ sender: UIButton) {
        if sender.tag == 15 {
            clearAll()
        }
        else if sender.tag == 17 && label.text != "Err" {
            if label.text!.count > 1 {
                label.text!.removeLast()
            }
            else if label.text!.count <= 1 {
                label.text = "0"
            }
        }
    }

    func clear() {
        firstOperand = 0
        numberIsTyping = 0
        operationSign = false
        result = ""
    }

    func clearAll() {
        clear()
        operationEquels = false
        label.text = "0"
    }

    @IBAction func equalsPressed(_ sender: UIButton) {
        operationEquels = true
        if operationSign == true && (label.text == "0" || label.text == "0." || label.text == "" || label.text == "-"){
            numberIsTyping = 0
        }
        result = result + " " + String(numberIsTyping)
        getResult()
        clear()
    }

    func getResult() {
        let expressionString = result
        let expression = Expression(expressionString)
        var finalResult: Double = 0
        do {
            finalResult = try expression.evaluate()
            if finalResult.isNormal {
                printResult(Decimal(finalResult))
            } else {
                label.text = "Err"
            }
        } catch {
           print("Err")
        }
    }

    func printResult(_ number: Decimal) {
        if number >= (0 - 99999999999999) && number <= 999999999999999 {
            formatResult(number)
        }
        else {
            label.text = "Err"
        }
    }

    func formatResult(_ number: Decimal) {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 13 // number of digits after the decimal point
        formatter.decimalSeparator = "." // dot as a separator
        formatter.groupingSeparator = "" // thousands separator

        if let formattedString = formatter.string(from: number as NSDecimalNumber) {
            let truncatedString = String(formattedString.prefix(15))
            label.text = String(truncatedString)
        }
        else {
            label.text = "Err"
        }
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if label.text!.count > 15 {
            label.text = "0"
        }
        if sender.tag == 16 && label.text!.contains(".") == false && label.text != "Err" {
            if (label.text != "" && label.text != "+" && label.text != "-" && label.text != "*" && label.text != "/") {
                label.text = label.text! + "."
            }
        }
        else if sender.tag >= 0 && sender.tag <= 9 {
            if operationEquels == true || operationSign == true {
                label.text = String(sender.tag)
                operationSign = false
                operationEquels = false
            }
            else if operationSign == false && label.text != "0" {
                label.text = label.text! + String(sender.tag)
            }
            else if operationSign == false && label.text == "0" {
                label.text = String(sender.tag)
            }
        }
        numberIsTyping = Double(label.text!) ?? 0
    }

    @IBAction func operationPressed(_ sender: UIButton) {
        if operationSign != true && label.text != "-" {
            if label.text == "0" || label.text == "0." || label.text == "" || label.text == "+" || label.text == "-" || label.text == "*" || label.text == "/" {
                firstOperand = 0
            }
            else {
                firstOperand = Double(label.text!) ?? 0
            }
            if result == "" {
                result = String(firstOperand)
            } else {
                result = result + " " + String(firstOperand)
            }
            if sender.tag == 11 {
                result = result + " " + "+"
            }
            else if sender.tag == 12 {
                result = result + " " + "-"
            }
            else if sender.tag == 13 {
                result = result + " " + "*"
            }
            else if sender.tag == 14 {
                result = result + " " + "/"
            }
            operationSign = true
        }
     }
}

