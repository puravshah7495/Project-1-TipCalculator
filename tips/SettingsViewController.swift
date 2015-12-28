//
//  SettingsViewController.swift
//  tips
//
//  Created by Purav Shah on 12/28/15.
//  Copyright © 2015 Purav Shah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var percentageController: UISegmentedControl!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultIndex = defaults.integerForKey("default_index")
        percentageController.selectedSegmentIndex = defaultIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onPercentageChanged(sender: AnyObject) {
        var index = percentageController.selectedSegmentIndex
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "default_index")
        defaults.synchronize()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
