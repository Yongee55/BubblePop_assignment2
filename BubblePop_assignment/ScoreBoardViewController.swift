//
//  ScoreBoardViewController.swift
//  BubblePop_assignment
//
//  Created by Yongee on 5/17/17.
//  Copyright © 2017 Yongee. All rights reserved.
//

import UIKit

class ScoreBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet weak var boardForUserAndScore: UITableView!
        
    var userList: [Any] = []
    var scoreList: [Any] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        userList.sort { ($0 as AnyObject).compare($1 as! String, options: .numeric) == .orderedAscending }
//        scoreList.sort { ($0 as AnyObject).compare(($1 as?  String)!, options: .numeric) == .orderedAscending }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoreTableViewCell
        
    
        var tempSwapArray = [Int]()
        var tempSwapArrayUserName = [String]()
        for _ in 0...scoreList.count {
            for index in 0..<scoreList.count-1 {
                if (((scoreList[index] as! Int) < (scoreList[index+1] as! Int)) && index+1 <= scoreList.count-1) {
                    tempSwapArray.append(scoreList[index] as! Int)
                    scoreList.insert(scoreList.remove(at: index+1), at: index) //scoreL[index+1] as! Int, at: index)
                    //                    scoreL.append(tempSwapArray.removeFirst())
                    tempSwapArray.removeAll()
                    
                    tempSwapArrayUserName.append(userList[index] as! String )
                    userList.insert(userList.remove(at: index+1), at: index)
                    tempSwapArrayUserName.removeAll()
                }
            }
            
        }
        
        
        self.reloadInputViews()
        
        cell.userName.text = userList[indexPath.row] as? String
        cell.Score.text = (scoreList[indexPath.row] as? Int)?.description
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       userList = UserDefaults.standard.array(forKey: "userList") ?? []
       scoreList = UserDefaults.standard.array(forKey: "scoreList") ?? []
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView,
                            sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]){
        
    }
    func getNameAndScore() {
        boardForUserAndScore = UserDefaults.standard.object(forKey: "username") as! UITableView
    }
    
   
}
