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
        
        let defaultLight = defaults.boolForKey("lightChoice")
        if defaultLight{
            greenView.backgroundColor = UIColor.whiteColor()
        } else { greenView.backgroundColor = UIColor(red:0.69, green:0.89, blue:0.46, alpha:1.0)
        } // loads the default background color based on your settings
        
        //load old numbers if the app was killed in the last 30 seconds
        let oldTime = defaults.objectForKey("lastTime") ?? NSDate()
        let futureTime = oldTime.dateByAddingTimeInterval(30)
        if futureTime.timeIntervalSinceNow > 0 {
            billField.text = defaults.stringForKey("bill")
            tipLabel.text = defaults.stringForKey("tip")
            totalLabel.text = defaults.stringForKey("total")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Gets rid of keyboard when a user taps outside an entry field
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    
    /* calcTip function calculates the total amount to pay
    based on the tip that was chosen by the user and the number of people
    splitting the bill */
    @IBAction func calcTip(sender: AnyObject) {
        
        //calculate total
        let tipPerc = [0.15, 0.18, 0.20]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPerc[tipControl.selectedSegmentIndex]
        var total = bill + tip
        
        //split total by number of people
        let numPeeps = splitter.selectedSegmentIndex + 1
        total = total/Double (numPeeps)
        
        //figure out the intl currency symbol
        let locale = NSLocale.currentLocale()
        let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol)!
        
        //format and display tip and total, including thousands separator
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        //tip
        let tipStr = numberFormatter.stringFromNumber(tip)
        tipLabel.text = String(currencySymbol) + tipStr!
        
        
        //total
        let totalStr = numberFormatter.stringFromNumber(total)
        totalLabel.text = String(currencySymbol) + totalStr!
        
        //store this info in user defaults and save the time
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(NSDate(), forKey:"lastTime")
        defaults.setObject(billField.text, forKey: "bill")
        defaults.setObject(tipLabel.text, forKey: "tip")
        defaults.setObject(totalLabel.text, forKey: "total")
        
        defaults.synchronize()
    }
    
    
    /* function reads the correct background color to show based on saved Setting */
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

