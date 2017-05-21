//
//  GameScene.swift
//  BubblePop
//
//  Created by Yongee on 4/28/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import SpriteKit
import GameplayKit




class GameScene: SKScene {
    
    weak var viewController: GameViewController!
    
    
    
    
    let BubbleCategoryName = ["redbubble150","pinkbubble150","greenbubble150","bluebubble150","blackbubble150"]
    
    var isTheBubbleTouched = false
    var isTouchedSameColor = false
    var whatColorisTouch = [String]()
    var numberOfTouch = 0
    var labelScore = SKLabelNode()
    var labelTime = SKLabelNode()
    var labelUpdateTime = SKLabelNode()
    var labelHighScore = SKLabelNode()
    let scoreLabelName = "scoreLabel"
    var score = 0
    
    var groupBubble = [String]()
    var groupSkBubble = [SKSpriteNode]()
    
    
    var newUsr = UserDefaults.standard.object(forKey: "username") as? String ?? "Anonymous"
    var userList: [Any] = UserDefaults.standard.array(forKey: "userList") ?? []
    var scoreList: [Any] = UserDefaults.standard.array(forKey: "scoreList") as? [Int] ?? []
    
    
    
    var bubbleValue = UserDefaults.standard.integer(forKey: "bubbleNumberFromSlider")
 
    
    var timeValue = UserDefaults.standard.integer(forKey: "timeNumberFromSlider") //{

    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        if bubbleValue == 0 && timeValue == 0 {
            bubbleValue = 15
            timeValue = 60
        }
        
        
        
        
        
        
        
        labelScore = SKLabelNode(fontNamed: "Chalkduster")
//        labelScore.name = scoreLabelName
        labelScore.text = "Score: 0"
        labelScore.fontSize = 40
        labelScore.fontColor = SKColor.black
        labelScore.position = CGPoint(x: frame.size.width - frame.size.width / 3 , y: frame.size.height - frame.size.height / 20)
        labelScore.horizontalAlignmentMode = .left
        
        
        labelTime = SKLabelNode(fontNamed: "Chalkduster")
//        labelTime.name = scoreLabelName
        
        labelTime.text = "Time: \(timeValue)"
        labelTime.fontSize = 40
        labelTime.fontColor = SKColor.black
        labelTime.position = CGPoint(x:frame.size.width / 4, y: frame.size.height - frame.size.height / 20)
        labelScore.horizontalAlignmentMode = .left
        
        
        labelHighScore = SKLabelNode(fontNamed: "Chalkduster")
//        labelHighScore.name = scoreLabelName
        
        labelHighScore.text = "High Score:\(score)"
        labelHighScore.fontSize = 40
        labelHighScore.fontColor = SKColor.black
        labelHighScore.position = CGPoint(x:frame.size.width / 2, y: frame.size.height - frame.size.height / 20)
        labelHighScore.horizontalAlignmentMode = .center
        
        addChild(labelScore)
        addChild(labelTime)
        addChild(labelHighScore)
        
//        self.reloadInputViews()
        
        run(SKAction.run(checkHighScore))
        
        run(SKAction.repeat(
            SKAction.sequence([
                SKAction.run({
                    self.refreshScreen(array: self.groupSkBubble)
                }),
                SKAction.run(addBubble),
                SKAction.wait(forDuration: 1),
                 SKAction.run(updateScore),
                 SKAction.run(updateTime),
                 SKAction.run(checkHighScore)
                 
                ]),count: timeValue+1
        ))
     
        
        if timeValue <= 0 {
            // game over
            labelTime.text = "Time: 0"
            
            
            let transitionAction = SKAction.run() {
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameResultScene = GameResult(size: self.size)
                self.view?.presentScene(gameResultScene, transition: reveal)
            }
            run(SKAction.repeat(SKAction.sequence([transitionAction,SKAction.wait(forDuration: 1000)]), count: 1))
            
            
        }
        
        
       
//        run(SKAction.run(saveHighscore))
//        run(SKAction.run(checkHighScore))

        
        
      
        
        
    }
    
    

    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func randomPosition() {
        let height = self.view!.frame.height
        let width = self.view!.frame.width
        
        let randomPosition = CGPoint(x: CGFloat(arc4random()).truncatingRemainder(dividingBy: height), y: CGFloat(arc4random()).truncatingRemainder(dividingBy: width))
        
        let sprite = SKSpriteNode()
        sprite.position = randomPosition
    }
    
    
    func addBubble() {
        
        let redbubble = SKSpriteNode(imageNamed: "redbubble150")
        let pinkbubble = SKSpriteNode(imageNamed: "pinkbubble150")
        let greenbubble = SKSpriteNode(imageNamed: "greenbubble150")
        let bluebubble = SKSpriteNode(imageNamed: "bluebubble150")
        let blackbubble = SKSpriteNode(imageNamed: "blackbubble150")
        
        redbubble.name = "redbubble150"
        pinkbubble.name = "pinkbubble150"
        greenbubble.name = "greenbubble150"
        bluebubble.name = "bluebubble150"
        blackbubble.name = "blackbubble150"
        
        var numberOfBubble = 0
        
        while groupBubble.count < bubbleValue {
            
            
            let probRed = Int(round(Double(arc4random_uniform(UInt32(bubbleValue)))*0.4))
            let probPink = Int(round(Double(arc4random_uniform(UInt32(bubbleValue)))*0.3))
            let probGreen = Int(round(Double(arc4random_uniform(UInt32(bubbleValue)))*0.15))
            let probBlue = Int(round(Double(arc4random_uniform(UInt32(bubbleValue)))*0.1))
            let probBlack = Int(round(Double(arc4random_uniform(UInt32(bubbleValue)))*0.05))
            
            
            
//            print("prob red \(probRed)")
//            print("prob pink \(probPink)")
//            print("prob green \(probGreen)")
//            print("prob blue \(probBlue)")
//            print("prob black \(probBlack)")
            
            
            for _ in 0..<probRed {
                
                
                
                
                if groupBubble.count >= bubbleValue {
                    continue
                }else {
                    groupBubble.append("red")
                    
                    
                    if groupBubble.count >= bubbleValue {
                        while groupBubble.count > bubbleValue {
                            groupBubble.remove(at: groupBubble.count-1)
                        }
                    }
                }
            }
//            print("Number of red bubble \(probRed)")
            
            for _ in 0..<probPink {
                
                if groupBubble.count >= bubbleValue {
                    continue
                }else {
                    groupBubble.append("pink")
                    
                    
                    if groupBubble.count >= bubbleValue {
                        while groupBubble.count > bubbleValue {
                            groupBubble.remove(at: groupBubble.count-1)
                        }
                    }
                }
            }
//            print("Number of pink bubble \(probPink)")
            
            for _ in 0..<probGreen {
                
                
                if groupBubble.count >= bubbleValue {
                    continue
                }else {
                    groupBubble.append("green")
                    
                    
                    if groupBubble.count >= bubbleValue {
                        while groupBubble.count > bubbleValue {
                            groupBubble.remove(at: groupBubble.count-1)
                        }
                    }
                }
            }
//            print("Number of green bubble \(probGreen)")
            
            for _ in 0..<probBlue {
                
                if groupBubble.count >= bubbleValue {
                    continue
                }else {
                    groupBubble.append("blue")
                    
                    
                    if groupBubble.count >= bubbleValue {
                        while groupBubble.count > bubbleValue {
                            groupBubble.remove(at: groupBubble.count-1)
                        }
                    }
                }
            }
//            print("Number of blue bubble \(probBlue)")
            
            for _ in 0..<probBlack {
                
                if groupBubble.count >= bubbleValue {
                    continue
                }else {
                    groupBubble.append("black")
                    
                    
                    if groupBubble.count >= bubbleValue {
                        while groupBubble.count > bubbleValue {
                            groupBubble.remove(at: groupBubble.count-1)
                        }
                    }
                }
            }
//            print("Number of black bubble \(probBlack)")
            
            
            numberOfBubble += probRed
            numberOfBubble += probPink
            numberOfBubble += probGreen
            numberOfBubble += probBlue
            numberOfBubble += probBlack
            
//            print(groupBubble.count)
            
//            print(numberOfBubble)
        }
        
        if groupSkBubble.count < bubbleValue {
           
            
        
            for index in 0..<groupBubble.count {
                
                
                if groupBubble[index] == "red" {
                    
                    let redbubble = SKSpriteNode(imageNamed: "redbubble150")
                    redbubble.name = "redbubble150"
                    
                    redbubble.physicsBody = SKPhysicsBody(circleOfRadius: max(redbubble.size.width / 2,
                                                                              redbubble.size.height / 2))
                    
                    
                    let posRedX = random(min: redbubble.size.width, max: size.width - redbubble.size.width)
                    let posRedY = random(min: redbubble.size.height, max: size.height - (redbubble.size.height+size.height / 12))
                    
                    redbubble.position = CGPoint(x: posRedX , y: posRedY)
                    
                    groupSkBubble.append(redbubble)
                    
                    groupSkBubble[index].removeFromParent()
                    
                    addChild(groupSkBubble[index])
                    
                    let bubbleFadeIn = SKAction.fadeIn(withDuration: 1)
                    let actionPopDone = SKAction.removeFromParent()
                    
                    groupSkBubble[index].run(SKAction.sequence([bubbleFadeIn,actionPopDone]))
                    
                }else if groupBubble[index] == "pink" {
                    
                    let pinkbubble = SKSpriteNode(imageNamed: "pinkbubble150")
                    pinkbubble.name = "pinkbubble150"
                    
                    pinkbubble.physicsBody = SKPhysicsBody(circleOfRadius: max(pinkbubble.size.width / 2,
                                                                               pinkbubble.size.height / 2))
                    
                    let posPinkX = random(min: pinkbubble.size.width, max: size.width - pinkbubble.size.width)
                    let posPinkY = random(min: pinkbubble.size.height, max: size.height - (pinkbubble.size.height+size.height/12))
                    
                    pinkbubble.position = CGPoint(x: posPinkX , y: posPinkY)
                    
                    groupSkBubble.append(pinkbubble)
                    
                    pinkbubble.removeFromParent()
                    
                    
                    addChild(groupSkBubble[index])
                    
                    let bubbleFadeIn = SKAction.fadeIn(withDuration: 1)
                    let actionPopDone = SKAction.removeFromParent()
                    
                    groupSkBubble[index].run(SKAction.sequence([bubbleFadeIn,actionPopDone]))
                }else if groupBubble[index] == "green" {
                    
                    let greenbubble = SKSpriteNode(imageNamed: "greenbubble150")
                    greenbubble.name = "greenbubble150"
                    
                    greenbubble.physicsBody = SKPhysicsBody(circleOfRadius: max(greenbubble.size.width / 2,
                                                                                greenbubble.size.height / 2))
                    
                    let posGreenX = random(min: greenbubble.size.width, max: size.width - greenbubble.size.width)
                    let posGreenY = random(min: greenbubble.size.height, max: size.height - (greenbubble.size.height+size.height/12))
                    
                    greenbubble.position = CGPoint(x: posGreenX , y: posGreenY)
                    
                    groupSkBubble.append(greenbubble)
                    
                    groupSkBubble[index].removeFromParent()
                    
                    addChild(groupSkBubble[index])
                    
                    let bubbleFadeIn = SKAction.fadeIn(withDuration: 1)
                    let actionPopDone = SKAction.removeFromParent()
                    
                    //
                    groupSkBubble[index].run(SKAction.sequence([bubbleFadeIn,actionPopDone]))
                }else if groupBubble[index] == "blue" {
                    
                    let bluebubble = SKSpriteNode(imageNamed: "bluebubble150")
                    bluebubble.name = "bluebubble150"
                    
                    bluebubble.physicsBody = SKPhysicsBody(circleOfRadius: max(bluebubble.size.width / 2,
                                                                               bluebubble.size.height / 2))
                    
                    let posBlueX = random(min: bluebubble.size.width, max: size.width - bluebubble.size.width)
                    let posBlueY = random(min: bluebubble.size.height, max: size.height - (bluebubble.size.height+size.height/12))
                    
                    bluebubble.position = CGPoint(x: posBlueX , y: posBlueY)
                    
                    groupSkBubble.append(bluebubble)
                    
                    groupSkBubble[index].removeFromParent()
                    
                    addChild(groupSkBubble[index])
                    
                    let bubbleFadeIn = SKAction.fadeIn(withDuration: 1)
                    let actionPopDone = SKAction.removeFromParent()
                    
                    groupSkBubble[index].run(SKAction.sequence([bubbleFadeIn,actionPopDone]))
                }else {
                    
                    let blackbubble = SKSpriteNode(imageNamed: "blackbubble150")
                    blackbubble.name = "blackbubble150"
                    
                    blackbubble.physicsBody = SKPhysicsBody(circleOfRadius: max(blackbubble.size.width / 2,
                                                                                blackbubble.size.height / 2))
                    
                    let posBlackX = random(min: blackbubble.size.width, max: size.width - blackbubble.size.width)
                    let posBlackY = random(min: blackbubble.size.height, max: size.height - (blackbubble.size.height+size.height/12))
                    
                    blackbubble.position = CGPoint(x: posBlackX , y: posBlackY)
                    
                    groupSkBubble.append(blackbubble)
                    
                    groupSkBubble[index].removeFromParent()
                    
                    addChild(groupSkBubble[index])
                    
                    let bubbleFadeIn = SKAction.fadeIn(withDuration: 1)
                    let actionPopDone = SKAction.removeFromParent()
                    
                    
                    groupSkBubble[index].run(SKAction.sequence([bubbleFadeIn,actionPopDone]))
                }
                
        
            }
        }
        
    } //func addBubble
    

    
    
    func updateScore() {
       labelScore.text = "Score: \(self.score)"
        
        if self.score != score {
            run(SKAction.repeatForever(SKAction.run({
                self.labelScore.text = "Score: \(self.score)"
            })))
        }
    }
    
    func updateTime() {
        
        if timeValue <= 0 {
            // game over
            labelTime.text = "Time: 0"
            
            
            let transitionAction = SKAction.run() {
        
            self.userList.append(self.newUsr)
            UserDefaults.standard.set(self.userList, forKey: "userList")
                
                
            self.scoreList.append(self.score)
            UserDefaults.standard.set(self.scoreList, forKey: "scoreList")
            
                
            self.sortingScoreAndUsername(usernameL: self.userList, scoreL: self.scoreList)
//                print(self.scoreList)
              
            UserDefaults.standard.synchronize()

                
            self.viewController.performSegue(withIdentifier:"showResults", sender: self)
    
            }
            run(SKAction.repeatForever(SKAction.sequence([transitionAction,SKAction.wait(forDuration: 100)])))
            
            
        }else{
            labelTime.text = "Time: \(timeValue)"
            timeValue-=1
            
        }
        
        
        
        
    }
    
    func sortingScoreAndUsername(usernameL: [Any], scoreL:[Any]) {
    
        
        var scoreL = scoreL
        var usernameL = usernameL
        
        var tempSwapArray = [Int]()
        var tempSwapArrayUserName = [String]()
        
        for _ in 0...scoreL.count {
            for index in 0..<scoreL.count-1 {
                if (((scoreL[index] as! Int) < (scoreL[index+1] as! Int)) && index+1 <= scoreL.count-1) {
                    tempSwapArray.append(scoreL[index] as! Int)
                    scoreL.insert(scoreL.remove(at: index+1), at: index)
                    tempSwapArray.removeAll()
                    
                    tempSwapArrayUserName.append(userList[index] as! String )
                    usernameL.insert(usernameL.remove(at: index+1), at: index)
                    tempSwapArrayUserName.removeAll()
                }
            }
            
        }

        self.scoreList.removeAll()
        for index in 0...scoreL.count-1  {
            self.scoreList.append(scoreL[index] as! Int)
            
            
            }
        
        self.userList.removeAll()
        for index in 0...usernameL.count-1  {
            self.userList.append(usernameL[index] as! String)
        }
        
    }
    

    
    func checkHighScore(){
    
        var highScore = 0
        
        if scoreList.count == 0 {
            highScore = score
        }else{
            sortingScoreAndUsername(usernameL: self.userList, scoreL: self.scoreList)
            highScore = scoreList[0] as! Int
        }
       
        
        
//        print(scoreIntArray[0])
    
        
        
        if scoreList.count == 0{
            highScore = score
            
            labelHighScore.text = "High Score:\(highScore )"
            
        }else{
            
            if score >= highScore {
                self.labelHighScore.text = "High Score:\(score)"
            }else{
                self.labelHighScore.text = "High Score:\(highScore )"
            }
        }
        
        
        
    }
    
    
    func removeBubble(taggedNodeArray: [String]){
        
        
        for index in 0..<taggedNodeArray.count {
            if taggedNodeArray[index] == "redbubble150Touched"{
                
                
                let bubbleExplode = SKAction.scale(by: 1.5, duration: 0.02)
                let bubbleGone = SKAction.fadeOut(withDuration: 0.02)
                let animationDone = SKAction.removeFromParent()
                
                groupSkBubble[index].run(SKAction.sequence([bubbleExplode,bubbleGone,animationDone]))
                
                groupBubble.remove(at: index)
                groupSkBubble.remove(at: index)
                //                groupSkBubble[index].removeFromParent()
                
            }else if taggedNodeArray[index] == "pinkbubble150Touched"{
                
                let bubbleExplode = SKAction.scale(by: 1.5, duration: 0.02)
                let bubbleGone = SKAction.fadeOut(withDuration: 0.02)
                let animationDone = SKAction.removeFromParent()
                
                groupSkBubble[index].run(SKAction.sequence([bubbleExplode,bubbleGone,animationDone]))
                
                groupBubble.remove(at: index)
                groupSkBubble.remove(at: index)
                //                groupSkBubble[index].removeFromParent()
                
            }else if taggedNodeArray[index] == "greenbubble150Touched"{
                
                let bubbleExplode = SKAction.scale(by: 1.5, duration: 0.02)
                let bubbleGone = SKAction.fadeOut(withDuration: 0.02)
                let animationDone = SKAction.removeFromParent()
                
                groupSkBubble[index].run(SKAction.sequence([bubbleExplode,bubbleGone,animationDone]))
                
                groupBubble.remove(at: index)
                groupSkBubble.remove(at: index)
                //                groupSkBubble[index].removeFromParent()
                
            }else if taggedNodeArray[index] == "bluebubble150Touched"{
                
                let bubbleExplode = SKAction.scale(by: 1.5, duration: 0.02)
                let bubbleGone = SKAction.fadeOut(withDuration: 0.02)
                let animationDone = SKAction.removeFromParent()
                
                groupSkBubble[index].run(SKAction.sequence([bubbleExplode,bubbleGone,animationDone]))
                
                groupBubble.remove(at: index)
                groupSkBubble.remove(at: index)
                
                
            }else if taggedNodeArray[index] == "blackbubble150Touched" {
                
                let bubbleExplode = SKAction.scale(by: 1.5, duration: 0.02)
                let bubbleGone = SKAction.fadeOut(withDuration: 0.02)
                let animationDone = SKAction.removeFromParent()
                
                
                groupBubble.remove(at: index)
                groupSkBubble[index].run(SKAction.sequence([bubbleExplode,bubbleGone,animationDone]))
                groupSkBubble.remove(at: index)
                
                
            }
            
            
        }// for
        
    }
    
    func refreshScreen(array: [SKSpriteNode]){
     
        
        groupBubble.removeAll()
        groupSkBubble.removeAll()
        addBubble()
    }
    
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        var isItTouched = ""
        
        
        
        if let body = physicsWorld.body(at: touchLocation) {
            for bubble in 0..<self.groupSkBubble.count-1 {
                if body.node != self.groupSkBubble[bubble]{
                    continue
                }else {
                    if body.node == self.groupSkBubble[bubble] {

                        isItTouched = "\(groupBubble[bubble]) is touched"
                        
                        
                        
                        if groupBubble[bubble] == "red"{
                            
                            groupBubble[bubble] = "redbubble150Touched"
                            removeBubble(taggedNodeArray: groupBubble)
                            
                             whatColorisTouch.append("redbubble150")
                           
                            
                        }else if groupBubble[bubble] == "pink" {
                            
                            groupBubble[bubble] = "pinkbubble150Touched"
                            removeBubble(taggedNodeArray: groupBubble)
                            
                            whatColorisTouch.append("pinkbubble150")
                            
                         
                        }else if groupBubble[bubble] == "green" {
                            
                            groupBubble[bubble] = "greenbubble150Touched"
                            removeBubble(taggedNodeArray: groupBubble)
                            
                            whatColorisTouch.append("greenbubble150")
                           
                            
                        }else if groupBubble[bubble] == "blue" {
                            
                            
                            groupBubble[bubble] = "bluebubble150Touched"
                            removeBubble(taggedNodeArray: groupBubble)
            
                            whatColorisTouch.append("bluebubble150")
                           
                            
           
                        }else if groupBubble[bubble] == "black" {
                            
                            
                            groupBubble[bubble] = "blackbubble150Touched"
                            removeBubble(taggedNodeArray: groupBubble)

                            whatColorisTouch.append("blackbubble150")
                           
                        
                        }
                        
                        
                        
                        if whatColorisTouch.count == 1 {
                            if whatColorisTouch[0] == "redbubble150" {
                                score+=1
                            }else if whatColorisTouch[0] == "pinkbubble150" {
                                score+=2
                            }else if whatColorisTouch[0] == "greenbubble150" {
                                score+=5
                            }else if whatColorisTouch[0] == "bluebubble150" {
                                score+=8
                            }else if whatColorisTouch[0] == "blackbubble150" {
                                score+=10
                            }else{
                                continue
                            }
                        }else if whatColorisTouch[1] == whatColorisTouch[0]{
                            if whatColorisTouch[1] == "redbubble150" {
                                score+=Int(ceil(1*1.5))
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "pinkbubble150" {
                                score+=Int(ceil(2*1.5))
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "greenbubble150" {
                                score+=Int(ceil(5*1.5))
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "bluebubble150" {
                                score+=Int(ceil(8*1.5))
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "blackbubble150" {
                                score+=Int(ceil(10*1.5))
                                whatColorisTouch.removeFirst()
                            }else{
                                continue
                            }
                        }else {
                            if whatColorisTouch[1] == "redbubble150" {
                                score+=1
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "pinkbubble150" {
                                score+=2
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "greenbubble150" {
                                score+=5
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "bluebubble150" {
                                score+=8
                                whatColorisTouch.removeFirst()
                            }else if whatColorisTouch[1] == "blackbubble150" {
                                score+=10
                                whatColorisTouch.removeFirst()
                            }else{
                                continue
                            }
                        }
                        
    
                        
                        isTheBubbleTouched = true
                        
                        //                    break
                    }else{
                        isItTouched = "Nothing is touched or finding the touched one"
                    }
                } //else
                
                
            }// for
            print(isItTouched)
            print(score)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        isTheBubbleTouched = false
        
    }
    
    
    
}
