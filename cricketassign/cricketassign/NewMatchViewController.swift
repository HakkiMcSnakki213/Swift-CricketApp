//
//  NewMatchViewController.swift
//  cricketassign
//
//  Created by mobiledev on 15/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class NewMatchViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var team1 = [Player]()
    var team2 = [Player]()
    
    var match : Match?
    
    //Team 1
    @IBOutlet weak var batTeamName: UITextField!
    @IBOutlet weak var batPlayerOne: UITextField!
    @IBOutlet weak var batPlayerTwo: UITextField!
    @IBOutlet weak var batPlayerThree: UITextField!
    @IBOutlet weak var batPlayerFour: UITextField!
    @IBOutlet weak var batPlayerFive: UITextField!
    
    //Team2
    @IBOutlet weak var bowlTeamName: UITextField!
    @IBOutlet weak var bowlPlayerOne: UITextField!
    @IBOutlet weak var bowlPlayerTwo: UITextField!
    @IBOutlet weak var bowlPlayerThree: UITextField!
    @IBOutlet weak var bowlPlayerFour: UITextField!
    @IBOutlet weak var bowlPlayerFive: UITextField!
    
    //Confirm and Cancel
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    //Error Texts
    @IBOutlet weak var error1: UILabel!
    @IBOutlet weak var error2: UILabel!
    
    
    
    //scoreboard items
    
    var Runs : Int32 = 0
    var Overs : Int32 = 0
    var Wickets : Int32 = 0
    var Balls : Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func confirmMatch(_ sender: UIButton) {
        
        /*
         If Empty Text Fields
         https://www.tutorialspoint.com/how-to-check-if-a-text-field-is-empty-or-not-in-swift
         https://stackoverflow.com/questions/33227924/check-if-multiple-textfields-are-empty-ios-with-swift
         */
        let textFields = [batTeamName, batPlayerOne, batPlayerTwo, batPlayerThree, batPlayerFour, batPlayerFive, bowlTeamName, bowlPlayerOne, bowlPlayerTwo, bowlPlayerThree, bowlPlayerFour, bowlPlayerFive]
        
        let emptyText = textFields.contains{$0?.text?.isEmpty ?? true }
        
        if(emptyText == true){
            
            error1.isHidden = false
            error2.isHidden = false
            
            for names in textFields where (names != nil) == emptyText{
                if let text = names?.text, text.isEmpty{
                    names?.backgroundColor = UIColor.red
                    
                }else {
                    names?.backgroundColor = UIColor.white
                }
            }
            
        }else{
            
            error1.isHidden = true
            error2.isHidden = true
            
            teamAlert()
        }
    }
    
    /*
     https://stackoverflow.com/questions/29959592/how-to-unwind-segue-with-alert-view-in-swift
     https://stackoverflow.com/questions/25197960/segue-crashes-my-program-has-something-to-do-with-my-navigationcontroller-and-m/25202589#25202589
     */
    @IBAction func hitCancel(_ sender: UIButton) {
        
        cancelAlert()
    }
    
    
    func teamCreate(){
        
        team1 = [
            Player(Name: batPlayerOne.text!, Runs: 0, hasBatted: false),
            Player(Name: batPlayerTwo.text!, Runs: 0, hasBatted: false),
            Player(Name: batPlayerThree.text!, Runs: 0, hasBatted: false),
            Player(Name: batPlayerFour.text!, Runs: 0, hasBatted: false),
            Player(Name: batPlayerFive.text!, Runs: 0, hasBatted: false)
        ]
        
        team2 = [
            Player(Name: bowlPlayerOne.text!, hasBowled: false),
            Player(Name: bowlPlayerTwo.text!, hasBowled: false),
            Player(Name: bowlPlayerThree.text!, hasBowled: false),
            Player(Name: bowlPlayerFour.text!, hasBowled: false),
            Player(Name: bowlPlayerFive.text!, hasBowled: false)
        ]
        
        let addMatch = Match(totalRuns: Runs,
                             Overs: Overs,
                             Wickets: Wickets,
                             Balls: Balls,
                             matchComplete: false,
                             team1Name: batTeamName.text!,
                             batTeam: team1,
                             currentBatter: team1[0],
                             currentRunner: team1[1],
                             team2Name: bowlTeamName.text!,
                             bowlTeam: team2,
                             currentBowler: team2[0]
                            )
        
        
        do {
            try matchCollection.addDocument(from: addMatch, completion: { (err) in
                if let err = err {
                    print("Error adding Document: \(err)")
                } else {
                    print("Successfully created match")
                }
            })
        } catch let error {
            print("Error writing to Firestore: \(error)")
        }
    }
    
    /*
     Alert
     https://www.youtube.com/watch?v=esRZCt21TnQ
     
     Unwind
     https://stackoverflow.com/questions/29959592/how-to-unwind-segue-with-alert-view-in-swift
     https://stackoverflow.com/questions/25197960/segue-crashes-my-program-has-something-to-do-with-my-navigationcontroller-and-m/25202589#25202589
     */
    func cancelAlert() {
        
        let alert = UIAlertController(title: "Are You Sure?", message:"Canceling will erase your current team, so be certain about your choice?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title:"Accept", style: .destructive, handler: { (_) in
            self.performSegue(withIdentifier: "cancelHit", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     Alert
     https://www.youtube.com/watch?v=esRZCt21TnQ
     
     Unwind
     https://stackoverflow.com/questions/29959592/how-to-unwind-segue-with-alert-view-in-swift
     https://stackoverflow.com/questions/25197960/segue-crashes-my-program-has-something-to-do-with-my-navigationcontroller-and-m/25202589#25202589
     */
    func teamAlert(){
        let alert = UIAlertController(title:"Team Creation", message:"Is this the match you would like to proceed with?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: {(_) in
            self.teamCreate()
            self.performSegue(withIdentifier: "createMatch", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
}
