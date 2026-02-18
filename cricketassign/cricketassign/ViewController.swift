//
//  ViewController.swift
//  cricketassign
//
//  Created by mobiledev on 9/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

let db = Firestore.firestore()
let matchCollection = db.collection("matches")

class ViewController: UIViewController {
    
    
    @IBOutlet weak var newMatch: UIButton!
    @IBOutlet weak var matchManage: UIButton!
    @IBOutlet weak var matchScoring: UIButton!
    @IBOutlet weak var pastMatches: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func newMatchNavi(_ sender: UIButton) {
        print("New Match Selected")
        
        //self.performSegue(withIdentifier: "newMatch", sender: nil)
    }
    
    @IBAction func matchManageNavi(_ sender: Any) {
        print("Match Managing Selected")
        
        //self.performSegue(withIdentifier: "matchManagement", sender: nil)
    }
    
    @IBAction func matchScoringNavi(_ sender: Any) {
        print("Match Scoring Selected")
        
        //self.performSegue(withIdentifier: "matchScoring", sender: nil)
    }
    
    @IBAction func pastMatchNavi(_ sender: Any) {
        print("Past Matches Selected")
        
        //self.performSegue(withIdentifier: "pastMatches", sender: nil)
    }
    
    /*
     https://stackoverflow.com/questions/29959592/how-to-unwind-segue-with-alert-view-in-swift
     https://stackoverflow.com/questions/25197960/segue-crashes-my-program-has-something-to-do-with-my-navigationcontroller-and-m/25202589#25202589
     */
    @IBAction func hitCancel(sender: UIStoryboardSegue) {
        print("Match Creation Cancelled")
    }
    
    @IBAction func confirmMatch(sender: UIStoryboardSegue) {
        print("Match Successfully Created")
    }
    
    @IBAction func finishMatch(sender: UIStoryboardSegue) {
        print("Match Is Finished")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "newMatch"{
            guard let newMatchViewController = segue.destination as? NewMatchViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
        }
        
        if segue.identifier == "matchManagement"{
            guard let matchManagementViewController = segue.destination as? MatchManageTableViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
        }
        
        if segue.identifier == "matchScoring" {
            guard let matchScoringViewController = segue.destination as? MatchScoreTableViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
        }
        
        if segue.identifier == "pastMatches"{
            guard let pastMatchViewController = segue.destination as? PastMatchesTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        }
    }
    
}

