//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Joseph  Davidson on 2/4/19.
//  Copyright © 2019 Joseph  Davidson. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        // get the hour component of the current time
        let calendar = Calendar(identifier: Calendar.Identifier.iso8601)
        let currentHour = calendar.component(.hour, from: Date())
        
        
        
        // Define my colors, including the random color generator at dusk
        let darkColor = UIColor(red: 13/255.0, green: 61/255.0, blue: 91/255.0, alpha: 1.0)
        let morningColor = UIColor(red: 250/255.0, green: 150/255.0, blue: 12/255.0, alpha: 0.6)
        let dayColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 150/255.0, alpha: 1.0)
        
        // Switch colors based on the hour of the day
        switch currentHour {
        case 7...10:
            view.backgroundColor = morningColor
        case 11...16:
            view.backgroundColor = dayColor
        default:
            view.backgroundColor = darkColor
        }
        
    }
    
    
    
    
    
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    
    
    
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{updateCelsiusLabel()}
        }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    
    
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }

    }
    
}
