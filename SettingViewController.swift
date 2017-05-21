//
//  SettingViewController.swift
//  BubblePop_assignment
//
//  Created by Yongee on 5/15/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var timeSetting: UISlider!
    @IBOutlet weak var bubbleSetting: UISlider!
   
////    let step: Float = 1
//    
//    
    @IBOutlet weak var bubbleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentBubbleValue = 15 as Float //default
     var currentTimeValue = 60 as Float//default
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func sliderBubbleValueChanged(_ sender: UISlider){
        
        
        currentBubbleValue = sender.value
        
        bubbleLabel.text = "\(Int(currentBubbleValue))"
        
        
        
        UserDefaults.standard.set(sender.value, forKey: "bubbleNumberFromSlider")
        print(Array(UserDefaults.standard.dictionaryRepresentation()))
        
        
    }
    

    
    @IBAction func sliderTimeValueChanged(_ sender: UISlider) {

    
        
        currentTimeValue = sender.value
        
        timeLabel.text = "\(Int(currentTimeValue))"
        
        UserDefaults.standard.set(sender.value, forKey: "timeNumberFromSlider")

        
        
    }
    

    func getBubbleNumber() -> Float {
        let bubbleNumbber = currentBubbleValue
        
        return bubbleNumbber
    }
    
    func getTimeNumber() -> Float {
        let timeNumbber = currentTimeValue
        
        return timeNumbber
    }



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
