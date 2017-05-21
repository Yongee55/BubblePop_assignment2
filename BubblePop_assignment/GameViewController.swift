//
//  GameViewController.swift
//  BubblePop
//
//  Created by Yongee on 4/28/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var currentGame: GameScene!
  
    
    @IBOutlet weak var bubbleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    override func viewDidLayoutSubviews() {
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        let scene = GameScene(size: CGSize(width: 1080, height: 1920))
        scene.scaleMode = SKSceneScaleMode.aspectFill
        skView.presentScene(scene)
        
        currentGame = scene
        currentGame.viewController = self
    }
    
    
    
    override var shouldAutorotate: Bool {
        return false;
        //        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
            //            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
  
}
