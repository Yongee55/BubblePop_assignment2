//
//  InputUserName.swift
//  BubblePop_assignment
//
//  Created by Yongee on 5/15/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit

class InputUserName: UIViewController {
   


    @IBOutlet weak var userName: UITextField!
    
    var thisUsername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userName.text = UserDefaults.standard.object(forKey: "username") as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setName(_ sender: UITextField) {

        
    }
    override func viewDidAppear(_ animated: Bool) {
        userName.resignFirstResponder()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UserDefaults.standard.set(userName.text, forKey: "username")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
