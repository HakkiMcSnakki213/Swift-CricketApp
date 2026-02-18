//
//  MatchViewController.swift
//  cricketassign
//
//  Created by mobiledev on 24/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchViewController: UIViewController {
    
    var match : Match?
    var matchIndex : Int?

    
    var batter : String = "Batter"
    var runner : String = "Runner"
     
    //Scoreboard
    @IBOutlet weak var numOfBalls: UILabel!
    @IBOutlet weak var numOfRuns: UILabel!
    @IBOutlet weak var numOfWickets: UILabel!
    @IBOutlet weak var numOfOvers: UILabel!
    @IBOutlet weak var runsInOver: UILabel!
    
    //Buttons
    @IBOutlet weak var zeroRuns: UIButton!
    @IBOutlet weak var oneRun: UIButton!
    @IBOutlet weak var twoRuns: UIButton!
    @IBOutlet weak var threeRuns: UIButton!
    @IBOutlet weak var fourRuns: UIButton!
    @IBOutlet weak var sixRuns: UIButton!
    @IBOutlet weak var determineOut: UIButton!
    @IBOutlet weak var finishMatch: UIButton!
    
    //Team 1
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var batPlayer1Name: UILabel!
    @IBOutlet weak var batPlayer2Name: UILabel!
    @IBOutlet weak var batPosition1: UILabel!
    @IBOutlet weak var batPosition2: UILabel!
    @IBOutlet weak var batterRuns: UILabel!
    @IBOutlet weak var runnerRuns: UILabel!
    
    //Team 2
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var bowlPlayer1Name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let displayMatch = match{
            
            team1Name.text = displayMatch.team1Name
            team2Name.text = displayMatch.team2Name
            batPlayer1Name.text = displayMatch.currentBatter.Name
            batPlayer2Name.text = displayMatch.currentRunner.Name
            bowlPlayer1Name.text = displayMatch.currentBowler.Name
            numOfRuns.text = String(displayMatch.totalRuns!)
            numOfBalls.text = String(displayMatch.Balls!)
            numOfOvers.text = String(displayMatch.Overs!)
            runsInOver.text = String(displayMatch.Balls!)
            numOfWickets.text = String(displayMatch.Wickets!)
            batPosition1.text = batter
            batPosition2.text = runner
            batterRuns.text = String(displayMatch.currentBatter.Runs!)
            runnerRuns.text = String(displayMatch.currentRunner.Runs!)
        }
    }
    
    @IBAction func zeroRuns(_ sender: UIButton) {
        print("Dot Ball!")
        increaseBalls()
        updateData()
    }
    
    @IBAction func oneRun(_ sender: UIButton) {
        print("One Run!")
        increaseRuns(runScore: 1)
        switchPosition()
        updateData()
    }
    
    @IBAction func twoRuns(_ sender: UIButton) {
        print("Two Runs!")
        increaseRuns(runScore: 2)
        updateData()
    }
    
    @IBAction func threeRuns(_ sender: UIButton) {
        print("Three Runs!")
        increaseRuns(runScore: 3)
        switchPosition()
        updateData()
    }
    
    @IBAction func fourRuns(_ sender: UIButton) {
        print("Four Runs!")
        increaseRuns(runScore: 4)
        updateData()
    }
    
    @IBAction func sixRuns(_ sender: UIButton) {
        print("Six Runs!")
        increaseRuns(runScore: 6)
        updateData()
    }
    
    
    @IBAction func outScreen(_ sender: UIButton) {
        print("Out Screen")
    }
    
    @IBAction func cancel(sender: UIStoryboardSegue) {
        print("Out Was Cancelled")
    }
    
    @IBAction func finishMatch(_ sender: UIButton) {
        finishFromButtonAlert()
        
    }
    
    
    func increaseRuns(runScore: Int32){
        if (match!.Wickets! < 4){
            match!.totalRuns = match!.totalRuns! + runScore
            
            match!.currentBatter.Runs = match!.currentBatter.Runs! + runScore
            
            let matchRuns = String(match!.totalRuns!)
            let batterruns = String(match!.currentBatter.Runs!)
            print(batterruns)
            print(matchRuns)
            numOfRuns.text = matchRuns
            batterRuns.text = batterruns
            
            increaseBalls()
        } else {
            match?.matchComplete = true
            finishMatchAlert()
        }
        
    }
    
    func increaseBalls() {
        match!.Balls = match!.Balls! + 1
        displayBalls()
        
        if(match!.Balls == 6){
            match!.Balls = 0
            displayBalls()
            increaseOvers()
        }
    }
    
    func displayBalls(){
        let matchBalls = String(match!.Balls!)
        print(matchBalls)
        numOfBalls.text = matchBalls
        runsInOver.text = matchBalls
    }
    
    func increaseOvers(){
        match!.Overs = match!.Overs! + 1
        
        let matchOvers = String(match!.Overs!)
        print(matchOvers)
        print("New Over")
        numOfOvers.text = matchOvers
        
        swapBowlers()
        
        if match?.Overs == 5 {
            match?.matchComplete = true
            finishMatchAlert()
        }
        
    }
    
    func increaseWickets(){
        match!.Wickets = match!.Wickets! + 1
        
        let matchWickets = String(match!.Wickets!)
        print(matchWickets)
        print("PLayer is Out!")
        numOfWickets.text = matchWickets
        
        increaseBalls()
        
        if match?.Wickets == 4{
            match?.matchComplete = true
            //finishMatchAlert()
        }
    }
    
    func swapBowlers(){
        //https://codewithchris.com/swift-random-number/
        let ranNum = Int.random(in: 0 ..< 5)
        let ranBowler = match?.bowlTeam[ranNum]
        //let changePosition = matchCollection.document((self.match?.documentID)!)
        if(match?.currentBowler.hasBowled != true){
            switch(match?.currentBowler){
                case match?.bowlTeam[0]:
                match?.bowlTeam[0].hasBowled = true
                match?.currentBowler.hasBowled = true
                
                case match?.bowlTeam[1]:
                match?.bowlTeam[1].hasBowled = true
                match?.currentBowler.hasBowled = true
                
                case match?.bowlTeam[2]:
                match?.bowlTeam[2].hasBowled = true
                match?.currentBowler.hasBowled = true
                
                case match?.bowlTeam[3]:
                match?.bowlTeam[3].hasBowled = true
                match?.currentBowler.hasBowled = true
                
                case match?.bowlTeam[4]:
                match?.bowlTeam[4].hasBowled = true
                match?.currentBowler.hasBowled = true
                
                default:
                print("Oh no, something went wrong here")
            }
        }
        
        
        print("current bowler has bowled: \(String(describing: match?.currentBowler.hasBowled))")
        
        while(match?.currentBowler.hasBowled == true){
            print("changing player")
            match?.currentBowler = ranBowler!
            print(String(match!.currentBowler.Name))
            break;
        }
        
        /*
         //if you want linear swapping:
         let i : Int = 0
         match?.currentBowler = (match?.bowlTeam[i + 1])!
         */
        
        bowlPlayer1Name.text = match?.currentBowler.Name
        print("Successfully Swapped A Player")
        
    }
    
    func switchPosition(){
        var batsman : Player = match!.currentBatter
        var runsman : Player = match!.currentRunner
        var position1 : String = batPosition1.text!
        var position2 : String = batPosition2.text!
        var batterrun : Int32 = match!.currentBatter.Runs!
        var runnerrun : Int32 = match!.currentRunner.Runs!

        //https://stackoverflow.com/questions/33641541/is-there-a-way-to-swap-objects-of-different-types
        swap(&batsman, &runsman)
        //swap(&position1, &position2)
        swap(&runnerrun, &batterrun)
        
        match?.currentBatter = batsman
        match?.currentRunner = runsman
        
        
        
        batPosition1.text = position1
        batPosition2.text = position2
        batPlayer1Name.text = match?.currentBatter.Name
        batPlayer2Name.text = match?.currentRunner.Name
        batterRuns.text = String(batterrun)
        runnerRuns.text = String(runnerrun)
        
        
    }
    
    
    
    func updateData() {
        do{
            try matchCollection.document(match!.documentID!).setData(from: match!){ err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document Successfully updated")
                }
                
            }
        } catch { print("Error Updating Document \(error)")}
    }
    /*
     https://www.youtube.com/watch?v=esRZCt21TnQ
     */
    func finishFromButtonAlert(){
        let alert = UIAlertController(title:"Game Finish?", message:"Are You Certain That The Game Is Over?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(_) in
            matchCollection.document((self.match?.documentID)!).updateData(["matchComplete":true])
            self.finishMatchAlert()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     https://www.youtube.com/watch?v=esRZCt21TnQ
     */
    func finishMatchAlert(){
        let alert = UIAlertController(title:"Match Is Finished", message:"The Game is Complete, Please Press Ok To Leave", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(_) in
            self.performSegue(withIdentifier: "finishMatch", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func applyChanges(sender: UIStoryboardSegue) {
        print("Out is applied")

        updateData()
        increaseWickets()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        /*
         https://console.firebase.google.com/u/0/project/cricketassignment-android/firestore/databases/-default-/data/~2Fmatches~2FwTJEVzCfsRSIhFAudZbR
         https://cloud.google.com/firestore/docs/manage-data/add-data#swift
         https://chatgpt.com/share/46ba3b0d-a8ef-47fb-b503-1719b4cb4991
         */
        if segue.identifier == "outScreen"{
            if let outViewController = segue.destination as? OutViewController {
                outViewController.match = self.match
                outViewController.matchIndex = self.matchIndex
            }
        }
    }
}
