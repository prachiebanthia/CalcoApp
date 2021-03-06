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
        
        // show the settings as last saved
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
    
    // changes the background color next time the app's main page is shown
    @IBAction func changeUI(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(lightSetting.on, forKey: "lightChoice")
        defaults.synchronize()
    }

    // changes the default tip amount to be shown next time the app is started
    @IBAction func changeDefault(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTip.selectedSegmentIndex, forKey: "defaultTipKey")
        defaults.synchronize()
    }

}
