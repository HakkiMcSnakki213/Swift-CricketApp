//
//  PastMatchDetailViewController.swift
//  cricketassign
//
//  Created by Gurleen Kaur Padda on 26/5/2024.
//

import UIKit

class PastMatchDetailViewController: UIViewController {
    
    var match : Match?
    var matchIndex : Int?
    
    //Team 1
    @IBOutlet weak var teamName1: UILabel!
    @IBOutlet weak var batPlayerOne: UILabel!
    @IBOutlet weak var batPlayerTwo: UILabel!
    @IBOutlet weak var batPlayerThree: UILabel!
    @IBOutlet weak var batPlayerFour: UILabel!
    @IBOutlet weak var batPlayerFive: UILabel!
    
    //Team 2
    @IBOutlet weak var teamName2: UILabel!
    @IBOutlet weak var bowlPlayerOne: UILabel!
    @IBOutlet weak var bowlPlayerTwo: UILabel!
    @IBOutlet weak var bowlPlayerThree: UILabel!
    @IBOutlet weak var bowlPlayerFour: UILabel!
    @IBOutlet weak var bowlPlayerFive: UILabel!
    
    //Scores
    @IBOutlet weak var Wickets: UILabel!
    @IBOutlet weak var Runs: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let displayMatch = match {
            
            teamName1.text = displayMatch.team1Name
            teamName2.text = displayMatch.team2Name
            
            batPlayerOne.text = displayMatch.batTeam[0].Name
            batPlayerTwo.text = displayMatch.batTeam[1].Name
            batPlayerThree.text = displayMatch.batTeam[2].Name
            batPlayerFour.text = displayMatch.batTeam[3].Name
            batPlayerFive.text = displayMatch.batTeam[4].Name
            
            bowlPlayerOne.text = displayMatch.bowlTeam[0].Name
            bowlPlayerTwo.text = displayMatch.bowlTeam[1].Name
            bowlPlayerThree.text = displayMatch.bowlTeam[2].Name
            bowlPlayerFour.text = displayMatch.bowlTeam[3].Name
            bowlPlayerFive.text = displayMatch.bowlTeam[4].Name
            
            Wickets.text = String(displayMatch.Wickets!)
            Runs.text = String(displayMatch.totalRuns!)
            
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
