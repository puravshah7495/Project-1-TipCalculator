//
//  ViewController.swift
//  tips
//
//  Created by Purav Shah on 12/27/15.
//  Copyright © 2015 Purav Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaultIndex = defaults.integerForKey("default_index")
        var previousBill = defaults.stringForKey("previous_bill")
        var billTimeout = defaults.objectForKey("bill_timeout")
        
        if (previousBill != nil && billTimeout != nil) {
            var timeout:NSDate = billTimeout as! NSDate
            var dateComparison:NSComparisonResult = NSDate().compare(timeout)
            if (dateComparison == NSComparisonResult.OrderedAscending) {
                billField.text = previousBill
            } else {
                defaults.setNilValueForKey("previous_bill")
            }
        }
        
        tipControl.selectedSegmentIndex = defaultIndex
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        self.title = "Tip Calculator"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        var input = billField.text!
        defaults.setObject(input, forKey: "previous_bill")
        defaults.setObject(NSDate(timeIntervalSinceNow: 600), forKey: "bill_timeout")
        defaults.synchronize()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18,0.2,0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
    
    /*@IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }*/
}

