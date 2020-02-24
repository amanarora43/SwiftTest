//
//  ExtendedPickerView.swift
//  E-Ticketing
//
//  Created by Aman Arora on 2/19/16.
//  Copyright © 2016 Navroz Singh. All rights reserved.
//

import UIKit

protocol ExtendedPickerViewDelegate{
    func extendedPickerViewDidValueSelected(selectedValue:NSMutableArray,obj:ExtendedPickerView)
    func extendedPickerViewDidCancel(obj:ExtendedPickerView)
}

class ExtendedPickerView: UIView , UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    static let sharedInstance = ExtendedPickerView()
    
    var options     =   NSArray()
    var valueHolder :   ExtendedTextField!
    var picker      :   UIPickerView!
    
    var delegate    :   ExtendedPickerViewDelegate! = nil

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override init(frame: CGRect) {
        //Do whatever you want here
        super.init(frame: frame)
    }
    
    func addPicker(values: NSArray){
        picker                  =   UIPickerView()
        picker.frame            =   CGRect(x: 0, y: 44, width: self.frame.size.width, height: 216)
        picker.delegate         =   self
        picker.dataSource       =   self
        picker.backgroundColor  =   UIColor.white
        self.addSubview(picker)
        
        self.options = values
    }
    
    func addToolBar(){
        let toolbar     =   UIToolbar()
        toolbar.frame   =   CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44)
        toolbar.sizeToFit()
        toolbar.backgroundColor = UIColor.red
        self.addSubview(toolbar)
        
        let cancelButton    =   UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelClicked))
        
        let flexBarButton   =   UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let doneButton      =   UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.doneClicked))
        
        var items = [UIBarButtonItem]()
        items.append(cancelButton)
        items.append(flexBarButton)
        items.append(doneButton)
                
        toolbar.items = items
    }
    
    @objc func cancelClicked(){
        self.delegate?.extendedPickerViewDidCancel(obj: self)
    }
    
    @objc func doneClicked(){
        let selectedComponentValues = NSMutableArray()
        for i in 0 ..< self.options.count  {
            let currentComponteValues = self.options[i] as! NSArray
            let selectedValue = currentComponteValues[picker.selectedRow(inComponent: i)]
            selectedComponentValues.add(selectedValue)
        }
        
        self.delegate?.extendedPickerViewDidValueSelected(selectedValue: selectedComponentValues,obj: self)
    }
    
    func numberOfComponentsInPickerView(colorPicker: UIPickerView) -> Int {
        return self.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.options[component] as AnyObject).count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.options[row] as? String
    }
}

extension ExtendedPickerView {
    func showPickerOnViewWithOptions(values:NSArray, onView:UIViewController, forField:AnyObject){
        forField.resignFirstResponder()
        self.frame = CGRect(x: 0, y: onView.view.frame.size.height, width: onView.view.frame.size.width, height: 260)
        
        self.addPicker(values: values)
        self.addToolBar()
        
        let options: UIViewAnimationOptions = [.curveEaseInOut]
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: options, animations: { () -> Void in
            
            self.frame = CGRect(x: 0, y: onView.view.frame.size.height - 260, width: onView.view.frame.size.width, height: 260)
            
            }, completion: nil)
        
        
        onView.view.addSubview(self)
    }
}


