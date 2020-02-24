//
//  ViewController.swift
//  test swift
//
//  Created by Aman Arora on 06/06/16.
//  Copyright © 2016 Aman Arora. All rights reserved.
//

import UIKit


class ViewController: UIViewController,ExtendedDatePickerViewDelegate,ExtendedPickerViewDelegate {

    @IBOutlet var txt1: ExtendedTextField?
    @IBOutlet var txt2: ExtendedTextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let array = [["1","2","3","5","7","13","17","23"],["11","22","33","55","77","133","177","233"]]
        txt2?.options = array as NSArray
    }

    @IBAction func btnClicked(){
        
        let obj = Validate();
        
        let (txtCompanyNumberStatus, txtCompanyNumberMsg) = obj.validateField(txtField: txt1!)
        if !txtCompanyNumberStatus{
            
            switch txtCompanyNumberMsg {
                case "Empty field":
                    print("Empty field")
                    break
                case "Short length text":
                    print("Short length text")
                    break
                default: break
            }
        }
        
        let (txtPhoneNumberStatus, txtPhoneNumberMsg) = obj.validateField(txtField: txt2!)
        if !txtPhoneNumberStatus{
            
            switch txtPhoneNumberMsg {
                case "Empty field":
                    print("Empty field")
                    break
                case "Short length text":
                    print("Short length text")
                    break
                default: break
            }
        }
    }
    
    func extendedDatePickerViewDidValueSelected(selectedDate:NSDate,obj:ExtendedDatePickerView){
        print("selectedDate ==== \(selectedDate)")
        obj.removeFromSuperview()
    }
    
    func extendedDatePickerViewDidCancel(obj:ExtendedDatePickerView){
        obj.removeFromSuperview()
    }
    
    func extendedPickerViewDidValueSelected(selectedValue:NSMutableArray,obj:ExtendedPickerView){
        print("selectedValue ==== \(selectedValue)")
        obj.removeFromSuperview()
    }
    
    func extendedPickerViewDidCancel(obj:ExtendedPickerView){
        obj.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

