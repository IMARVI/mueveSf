//
//  TodayViewController.swift
//  widgetSF
//
//  Created by Marvi on 21/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var time: UILabel!
    
    var appGroupDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        appGroupDefaults=UserDefaults(suiteName:"group.MueveSF")!
        let timer = appGroupDefaults.value(forKey: "timer")! as! String
        time.text = timer
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
