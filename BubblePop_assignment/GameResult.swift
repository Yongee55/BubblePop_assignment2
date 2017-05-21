//
//  GameResult.swift
//  BubblePop_assignment
//
//  Created by Yongee on 5/17/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit
import SpriteKit


class GameResult: SKScene {
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        
        backgroundColor = SKColor.white
        
        
        let message = "Time's up"
        
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        
        
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        
        
        // 4
        run(SKAction.sequence([
            SKAction.wait(forDuration: 10.0),
            SKAction.run() {
                // 5
             
                let scene = GameResult(size: size)
                self.view?.presentScene(scene)
            }
            ]))
        
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        let touchLocation = touch!.location(in: self)
        
        
    }
}
