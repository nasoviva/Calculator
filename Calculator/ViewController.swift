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
            numberIsTyping = Double(label.text!) ?? 0
        }
    }

    @IBAction func equalsPressed(_ sender: UIButton) {
        if operationEquels == false {
            operationEquels = true
            if operationSign == true || (label.text == "0" || label.text == "0." || label.text == "" || label.text == "-"){
                numberIsTyping = 0
            }
            result = result + " " + String(numberIsTyping)
            getResult()
            clear()
        }
    }

    @IBAction func numberPressed(_ sender: UIButton) {

        if label.text!.count > 15 {
            label.text = "0"
        }
        if sender.tag == 18 {
            plusMinusPressed()
        }
        if sender.tag == 16 {
            dotPressed(sender.tag)
        }
        else if sender.tag >= 0 && sender.tag <= 9 {
            digitPressed(sender.tag)
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
            addResult(sender.tag)
            operationSign = true
        }
     }
}

extension ViewController {

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

    func getResult() {
        let expressionString = result
        let expression = Expression(expressionString)
        var finalResult: Double = 0
        do {
            finalResult = try expression.evaluate()
            if finalResult.isNormal || finalResult == 0 {
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

    func plusMinusPressed() {
        let minus = Double(label.text!) ?? 0
        if minus > 0 {
            label.text = "-" + label.text!
        }
        else if minus < 0 {
            label.text = label.text!.replacingOccurrences(of: "-", with: "")
        }
    }

    func dotPressed(_ tag: Int) {
        if tag == 16 && label.text!.contains(".") == false && label.text != "Err" {
            if (label.text != "" && label.text != "-" && operationSign == false && operationEquels == false) {
                label.text = label.text! + "."
            }
        }
    }

    func digitPressed(_ tag: Int) {
        if operationEquels == true || operationSign == true {
            label.text = String(tag)
            operationSign = false
            operationEquels = false
        }
        else if operationSign == false && label.text != "0" && label.text != "0." {
            label.text = label.text! + String(tag)
        }
        else if operationSign == false && (label.text == "0" || label.text == "0.") {
            label.text = String(tag)
        }
    }

    func addResult(_ tag: Int) {
        if result == "" {
            result = String(firstOperand)
        } else {
            result = result + " " + String(firstOperand)
        }
        if tag == 11 {
            result = result + " " + "+"
        }
        else if tag == 12 {
            result = result + " " + "-"
        }
        else if tag == 13 {
            result = result + " " + "*"
        }
        else if tag == 14 {
            result = result + " " + "/"
        }
    }
}

