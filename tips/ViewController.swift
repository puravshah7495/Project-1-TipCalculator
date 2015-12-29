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
    @IBOutlet weak var bottomView: UIView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var previousInput:NSString = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bottomView.alpha = 0
        billField.frame.origin.y = billField.frame.height * 1.8
        
        let defaultIndex = defaults.integerForKey("default_index")
        let previousBill = defaults.stringForKey("previous_bill")
        let billTimeout = defaults.objectForKey("bill_timeout")
        
        if (previousBill != nil && previousBill! != "" && billTimeout != nil) {
            let timeout:NSDate = billTimeout as! NSDate
            let dateComparison:NSComparisonResult = NSDate().compare(timeout)
            if (dateComparison == NSComparisonResult.OrderedAscending) {
                print(previousBill)
                billField.text = previousBill
                bottomView.alpha = 1
                billField.frame.origin.y -= billField.frame.height
            } else {
                defaults.setObject(nil, forKey: "previous_bill")
                defaults.synchronize()
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
        let input = billField.text!
        defaults.setObject(input, forKey: "previous_bill")
        defaults.setObject(NSDate(timeIntervalSinceNow: 600), forKey: "bill_timeout")
        defaults.synchronize()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18,0.2,0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let bill = billField.text!
        
        let billAmount = NSString(string: bill).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        if (bill != "" && previousInput == "") {
            UIView.animateWithDuration(0.2, animations: {
                self.bottomView.alpha = 1
                self.billField.frame.origin.y -= self.billField.frame.height
            })
        }
        if (bill == "" && previousInput != "") {
            UIView.animateWithDuration(0.2, animations: {
                self.bottomView.alpha = 0
                self.billField.frame.origin.y += self.billField.frame.height
            })
        }
        
        previousInput = bill
    }
    
}

