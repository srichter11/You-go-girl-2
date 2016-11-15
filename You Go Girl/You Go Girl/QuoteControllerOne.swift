//
//  QuoteControllerOne.swift
//  You Go Girl
//
//  Created by Sophia Richter on 11/12/16.
//  Copyright © 2016 Sophia Richter. All rights reserved.
//

import Foundation
import UIKit

class QuoteControllerOne: UIViewController {
    
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var quoteAuthorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quoteArray = ["\"No one can make you feel inferior without your consent\"", "\"Never stop believing that fighting for what's right is worth it. It is.\"", "\"When you've worked hard, and done well, and walked through that doorway of opportunity, you do not slam it shut behind you. You reach back.\""]
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        label.center.x = self.view.center.x
        label.center.y = self.view.center.y
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 9
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor = UIColor(red: 0.014, green: 0.043, blue: 0.051, alpha: 0.7)
        label.font = UIFont(name: "Futura", size: CGFloat(30))
        label.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        label.text = quoteArray[Int(arc4random_uniform(UInt32(quoteArray.count)))]
        self.view.addSubview(label)

       
      //  quoteLabel.text = quoteArray[Int(arc4random_uniform(UInt32(quoteArray.count)))]
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}