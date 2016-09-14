//
//  ViewController.swift
//  Calco
//
//  Created by Prachie Banthia on 9/5/16.
//  Copyright © 2016 Prachie Banthia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var splitter: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billField.becomeFirstResponder()
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipDefault = defaults.integerForKey("defaultTipKey")
        self.tipControl.selectedSegmentIndex = tipDefault //loads the default tip amount based on your settings
        defaults.setBool(true, forKey: "lightChoice")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calcTip(sender: AnyObject) {
        
        
        let tipPerc = [0.15, 0.18, 0.20]
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPerc[tipControl.selectedSegmentIndex]
        
        var total = bill + tip
        
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)!
    //    let currencyCode = locale.objectForKey(NSLocaleCurrencyCode)!
        
        tipLabel.text = String(format: String(currencySymbol) + "%.2f", tip)
        
        
        let numPeeps = splitter.selectedSegmentIndex + 1
        
        total = total/Double (numPeeps)
        
        
        totalLabel.text = String(format: String(currencySymbol) + "%.2f", total)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let lightSetting = defaults.boolForKey("lightChoice")
        if !lightSetting{
            greenView.backgroundColor = UIColor.whiteColor()
        } else { greenView.backgroundColor = UIColor(red:0.69, green:0.89, blue:0.46, alpha:1.0)
        }
        
        
    }
}

