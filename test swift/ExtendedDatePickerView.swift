//
//  ExtendedDatePickerView.swift
//  test swift
//
//  Created by Aman Arora on 09/06/16.
//  Copyright © 2016 Aman Arora. All rights reserved.
//

import UIKit

protocol ExtendedDatePickerViewDelegate{
    func extendedDatePickerViewDidValueSelected(selectedDate:NSDate,obj:ExtendedDatePickerView)
    func extendedDatePickerViewDidCancel(obj:ExtendedDatePickerView)
}

class ExtendedDatePickerView: UIView{
    static let sharedInstance = ExtendedPickerView()
    
    var options     =   NSArray()
    var valueHolder :   ExtendedTextField!
    var datePicker  :   UIDatePicker = UIDatePicker()
    
    var delegate    :   ExtendedDatePickerViewDelegate! = nil
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        //Do whatever you want here
        super.init(frame: frame)
    }
    
    func addDatePicker(){
        
        // setting properties of the datePicker
        self.datePicker.frame = CoreGraphics.CGRect(x: 0, y: 44, width: self.frame.width, height: 216)
        self.datePicker.timeZone = NSTimeZone.local
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.layer.cornerRadius = 5.0
        self.datePicker.layer.shadowOpacity = 0.5
        
        // add DataPicker to the view
        self.addSubview(self.datePicker)
    }
    
    func addToolBar(){
        let toolbar     =   UIToolbar()
        toolbar.frame   =   CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44)
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.red
        self.addSubview(toolbar)
        
        let cancelButton    =   UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelClicked))
        
        let flexBarButton   =   UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let doneButton      =   UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneClicked))
        
        var items = [UIBarButtonItem]()
        items.append(cancelButton)
        items.append(flexBarButton)
        items.append(doneButton)
        
        toolbar.items = items
    }
    
    @objc func cancelClicked(){
        self.delegate?.extendedDatePickerViewDidCancel(obj: self)
    }
    
    @objc func doneClicked(){
        self.delegate?.extendedDatePickerViewDidValueSelected(selectedDate: self.datePicker.date as NSDate, obj: self)
    }    
}

extension ExtendedDatePickerView {
    func showDatePickerOnViewWithOptions(onView:UIViewController, forField:AnyObject){
        forField.resignFirstResponder()
        self.frame = CGRect(x: 0, y: onView.view.frame.size.height, width: onView.view.frame.size.width, height: 260)
        
        self.addDatePicker()
        self.addToolBar()
        
        let options: UIView.AnimationOptions = [.curveEaseIn, .curveEaseOut]
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: options, animations: { () -> Void in
            
            self.frame = CGRect(x: 0, y: onView.view.frame.size.height - 260, width: onView.view.frame.size.width, height: 260)
            
            }, completion: nil)
        
        
        onView.view.addSubview(self)
    }
}

