//
//  SettingsViewController.swift
//  Calco
//
//  Created by Prachie Banthia on 9/5/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip: UISegmentedControl!
    @IBOutlet weak var lightSetting: UISwitch!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipDefault = defaults.integerForKey("defaultTipKey")
        
        self.defaultTip.selectedSegmentIndex = tipDefault
        
        let lightSet = defaults.boolForKey("lightChoice")
        self.lightSetting.setOn(lightSet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeUI(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(lightSetting.on, forKey: "lightChoice")
        print(lightSetting.on)
        defaults.synchronize()
    }

    @IBAction func changeDefault(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTip.selectedSegmentIndex, forKey: "defaultTipKey")
        defaults.synchronize()
        
   //     print(defaults.doubleForKey("defaultTipKey"))
        

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
