//
//  GameResultViewController.swift
//  BubblePop_assignment
//
//  Created by Yongee on 5/17/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit
import SpriteKit

class GameResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        let scene = GameResult(size:CGSize(width: 1080, height: 1920))
        scene.scaleMode = SKSceneScaleMode.aspectFill
        
        let skView = self.view as! SKView
        skView.presentScene(scene)
    }

}
