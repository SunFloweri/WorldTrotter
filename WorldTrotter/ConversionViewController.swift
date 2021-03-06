//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Irina Kalashnikova on 8/1/16.
//  Copyright © 2016 Irina Kalashnikova. All rights reserved.
//

import UIKit

class ConversionViewController:UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let color = getNextColor()
        UIView.animateWithDuration(2, animations: {
            self.view.backgroundColor = color
            }, completion: nil)
    }
    
    func getNextColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32)*(5/9)
        } else {
            return nil
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dissmissKeyboard(sender: AnyObject){
        textField.resignFirstResponder()
    }

    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }

    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool {
        
        let newCharacters = NSCharacterSet(charactersInString: string)
        let boolIsNumber = NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(newCharacters)
        if boolIsNumber == true {
            return true
        } else if string == "." || string == "," {
            
            let currentLocation = NSLocale.currentLocale()
            let decimalSeparator = currentLocation.objectForKey(NSLocaleDecimalSeparator) as! String
            let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
            let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
            
            if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }

        } else {
            return false
        }
    }
}