//
//  OutViewController.swift
//  cricketassign
//
//  Created by Harkirat on 27/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class OutViewController: UIViewController {
    
    var match : Match?
    var matchIndex : Int?
    
    var fieldPlayer : Player?
    var benchPlayer : Player?
    
    //Cancel and Accpet Buttons
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var apply: UIButton!
    
    //Outs Available
    @IBOutlet weak var bowled: UIButton!
    @IBOutlet weak var caught: UIButton!
    @IBOutlet weak var caubowl: UIButton!
    @IBOutlet weak var lbw: UIButton!
    @IBOutlet weak var runOut: UIButton!
    @IBOutlet weak var hitWicket: UIButton!
    @IBOutlet weak var stumping: UIButton!
    
    //Out Message
    var outMethod : String = ""
    
    //Player Labels
    @IBOutlet weak var batterName: UILabel!
    @IBOutlet weak var runnerName: UILabel!
    
    @IBOutlet weak var benchOne: UILabel!
    @IBOutlet weak var benchTwo: UILabel!
    @IBOutlet weak var benchThree: UILabel!
    
    //Field Buttons
    @IBOutlet weak var batterButton: UIButton!
    @IBOutlet weak var runnerButton: UIButton!
    
    //Bench Buttons
    @IBOutlet weak var benchOneButton: UIButton!
    @IBOutlet weak var benchTwoButton: UIButton!
    @IBOutlet weak var benchThreeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         https://console.firebase.google.com/u/0/project/cricketassignment-android/firestore/databases/-default-/data/~2Fmatches~2FwTJEVzCfsRSIhFAudZbR
         https://chatgpt.com/share/46ba3b0d-a8ef-47fb-b503-1719b4cb4991
         */
        if let matchId = match?.documentID {
                    let matchRef = matchCollection.document(matchId)
                    matchRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            do {
                                self.match = try document.data(as: Match.self)
                            } catch {
                                print("Error decoding match data: \(error)")
                            }
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
            
        /*
         Radio Buttons
         https://www.youtube.com/watch?v=8o3adVYnwNE
         
         Icons
         https://stackoverflow.com/questions/37772411/how-to-add-system-icons-for-a-uibutton-programmatically
         */
        bowled.setImage(UIImage(systemName: "circle"), for: .normal)
        bowled.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        caught.setImage(UIImage(systemName: "circle"), for: .normal)
        caught.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        caubowl.setImage(UIImage(systemName: "circle"), for: .normal)
        caubowl.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        lbw.setImage(UIImage(systemName: "circle"), for: .normal)
        lbw.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        runOut.setImage(UIImage(systemName: "circle"), for: .normal)
        runOut.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        hitWicket.setImage(UIImage(systemName: "circle"), for: .normal)
        hitWicket.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        stumping.setImage(UIImage(systemName: "circle"), for: .normal)
        stumping.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        
        batterButton.setImage(UIImage(systemName: "circle"), for: .normal)
        batterButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        
        runnerButton.setImage(UIImage(systemName: "circle"), for: .normal)
        runnerButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        
        benchOneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        benchOneButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        benchTwoButton.setImage(UIImage(systemName: "circle"), for: .normal)
        benchTwoButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        benchThreeButton.setImage(UIImage(systemName: "circle"), for: .normal)
        benchThreeButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .selected)
        
        bowled.isSelected = true
        
        batterButton.isSelected = true
        
        benchOneButton.isSelected = true
        
        outMethod = "Bowled"
        fieldPlayer = match?.currentBatter
        benchPlayer = match?.batTeam[2]
        
        batterName.text = match?.currentBatter.Name
        runnerName.text = match?.currentRunner.Name
        
        if let third = match?.batTeam[2].Name {
            if(third == match?.currentBatter.Name){
                benchOne.isHidden = true
                benchOneButton.isHidden = true
            } else if (third == match?.currentRunner.Name){
                benchOne.isHidden = true
                benchOneButton.isHidden = true
            } else{
                benchOne.text = third
            }
        }
        if let fourth = match?.batTeam[3].Name {
            if(fourth == match?.currentBatter.Name){
                benchTwo.isHidden = true
                benchTwoButton.isHidden = true
            } else if (fourth == match?.currentRunner.Name){
                benchTwo.isHidden = true
                benchTwoButton.isHidden = true
            } else{
                benchTwo.text = fourth
            }
        }
        if let fifth = match?.batTeam[4].Name {
            if(fifth == match?.currentBatter.Name){
                benchThree.isHidden = true
                benchThreeButton.isHidden = true
            } else if (fifth == match?.currentRunner.Name){
                benchThree.isHidden = true
                benchThreeButton.isHidden = true
            } else{
                benchThree.text = fifth
            }
        }
    }
    
    /*
     Radio Buttons
     https://www.youtube.com/watch?v=8o3adVYnwNE
     
     Icons
     https://stackoverflow.com/questions/37772411/how-to-add-system-icons-for-a-uibutton-programmatically
     
     Switch
     https://www.programiz.com/swift-programming/switch-statement
     */
    @IBAction func outDeclaration(_ sender: UIButton) {
        switch(sender){
        case bowled:
            bowled.isSelected = true
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = false
            outMethod = "Bowled"
            
        case caught:
            bowled.isSelected = false
            caught.isSelected = true
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = false
            outMethod = "Caught"
            
        case caubowl:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = true
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = false
            outMethod = "Caught and Bowled Out"
            
        case lbw:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = true
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = false
            outMethod = "Leg Before Wicket"
            
        case runOut:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = true
            hitWicket.isSelected = false
            stumping.isSelected = false
            outMethod = "runOut"
            
        case hitWicket:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = true
            stumping.isSelected = false
            outMethod = "Hitting The Wicket"
            
        case stumping:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = true
            outMethod = "Stumping"
            
        default:
            bowled.isSelected = false
            caught.isSelected = false
            caubowl.isSelected = false
            lbw.isSelected = false
            runOut.isSelected = false
            hitWicket.isSelected = false
            stumping.isSelected = false
        }
    }
    
    @IBAction func fieldPlayers(_ sender: UIButton) {
        switch(sender){
        case batterButton :
            batterButton.isSelected = true
            runnerButton.isSelected = false
            fieldPlayer = match?.currentBatter
            
        
        case runnerButton:
            batterButton.isSelected = false
            runnerButton.isSelected = true
            fieldPlayer = match?.currentRunner
            
        default:
            batterButton.isSelected = false
            runnerButton.isSelected = false
        }
    }
    
    @IBAction func benchPlayers(_ sender: UIButton) {
        switch(sender){
        case benchOneButton :
            benchOneButton.isSelected = true
            benchTwoButton.isSelected = false
            benchThreeButton.isSelected = false
            benchPlayer = match?.batTeam[2]
        
        case benchTwoButton:
            benchOneButton.isSelected = false
            benchTwoButton.isSelected = true
            benchThreeButton.isSelected = false
            benchPlayer = match?.batTeam[3]
            
        case benchThreeButton:
            benchOneButton.isSelected = false
            benchTwoButton.isSelected = false
            benchThreeButton.isSelected = true
            benchPlayer = match?.batTeam[4]
            
        default:
            benchOneButton.isSelected = false
            benchTwoButton.isSelected = false
            benchThreeButton.isSelected = false
        }
    }
    
    func swapBatters(){
        var currentBat = match?.currentBatter
        var currentRun = match?.currentRunner
        
        if(fieldPlayer == match?.currentBatter){
            //match?.currentBatter = benchPlayer!
            swap(&currentBat, &benchPlayer)
            print("Current Batter Swapped")
            match?.currentBatter = currentBat!
        } else if(fieldPlayer == match?.currentRunner){
            //match?.currentRunner = benchPlayer!
            swap(&currentRun, &benchPlayer)
            print("Current Runner Swapped")
            match?.currentRunner = currentRun!
        }
        
        
        
    }
       
    
    @IBAction func hitCancel(_ sender: UIButton) {
    }
    @IBAction func hitApply(_ sender: UIButton) {
        applyOutAlert()
    }
    
    /*
     https://www.youtube.com/watch?v=esRZCt21TnQ
     */
    func applyOutAlert(){
        let alert = UIAlertController(title:"is \(String(describing: fieldPlayer?.Name)) really out by \(outMethod)?", message:"Are You Sure You Want to swap \(String(describing: fieldPlayer?.Name)) with \(String(describing: benchPlayer?.Name))?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Apply", style: .default, handler: {(_) in
            
            self.swapBatters()
            self.performSegue(withIdentifier: "outChanges", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
