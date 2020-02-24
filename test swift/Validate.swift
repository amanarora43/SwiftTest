//
//  Validate.swift
//  E-Ticketing
//
//  Created by Aman Arora on 2/10/16.
//  Copyright © 2016 Navroz Singh. All rights reserved.
//
import UIKit
import Foundation

class Validate: NSObject {
    
    // validate normal fields
    func validateField(txtField: ExtendedTextField)-> (Bool, NSString)
    {
        if txtField.text?.count == 0{
            highLightTxtField(txtField: txtField)
            return (false,"Empty field");
        }
        if txtField.sizeLimit{
            if txtField.minLength > txtField.text!.count{
                highLightTxtField(txtField: txtField)
                return (false,"Short length text");
            }
            if txtField.maxLength < txtField.text!.count{
                highLightTxtField(txtField: txtField)
                return (false,"Long length text");
            }
        }
        
        txtField.layer.borderColor = UIColor.clear.cgColor
        
        return (true,"");
    }
    
    // validate email type fields
    func validateEmailField(txtField: ExtendedTextField)-> (Bool, NSString)
    {
        if txtField.text?.count == 0{
            return (false,"Empty field");
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: txtField.text)

        if result{
            return(true,"")
        }
        else{
            highLightTxtField(txtField: txtField)
            return(false, "Invalid Email format")
        }
    }
    
    // highlight the text field when validation failed for a text field
    func highLightTxtField(txtField:ExtendedTextField){
        if(txtField.highlightColor != nil){
            txtField.layer.borderWidth = 1.0
            txtField.layer.borderColor = txtField.highlightColor.cgColor
        }
    }
    
    // unhighlight the text field when validation passed in future
    func unhighlighTxtField(txtField:ExtendedTextField){
        txtField.layer.borderWidth = 0.0
            txtField.layer.borderColor = UIColor.clear.cgColor
    }
}

