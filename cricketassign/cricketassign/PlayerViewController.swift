//
//  PlayerViewController.swift
//  cricketassign
//
//  Created by mobiledev on 25/5/2024.
//

import UIKit

class PlayerViewController: UIViewController {
    
    var match : Match?
    var matchIndex : Int?
    
    //Bowl Team
    @IBOutlet weak var teamName1: UILabel!
    @IBOutlet weak var PlayerOneBowl: UILabel!
    @IBOutlet weak var PlayerTwoBowl: UILabel!
    @IBOutlet weak var PlayerThreeBowl: UILabel!
    @IBOutlet weak var PlayerFourBowl: UILabel!
    @IBOutlet weak var PlayerFiveBowl: UILabel!
    //@IBOutlet weak var imageTeamBowl: UIImageView!
    
    //Bat Team
    @IBOutlet weak var teamName2: UILabel!
    @IBOutlet weak var PlayerOneBat: UILabel!
    @IBOutlet weak var PlayerTwoBat: UILabel!
    @IBOutlet weak var PlayerThreeBat: UILabel!
    @IBOutlet weak var PlayerFourBat: UILabel!
    @IBOutlet weak var PlayerFiveBat: UILabel!
    //@IBOutlet weak var imageTeamBat: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let displayMatch = match {
            
            teamName2.text = displayMatch.team1Name
            teamName1.text = displayMatch.team2Name
            
            PlayerOneBat.text = displayMatch.batTeam[0].Name
            PlayerTwoBat.text = displayMatch.batTeam[1].Name
            PlayerThreeBat.text = displayMatch.batTeam[2].Name
            PlayerFourBat.text = displayMatch.batTeam[3].Name
            PlayerFiveBat.text = displayMatch.batTeam[4].Name
            
            PlayerOneBowl.text = displayMatch.bowlTeam[0].Name
            PlayerTwoBowl.text = displayMatch.bowlTeam[1].Name
            PlayerThreeBowl.text = displayMatch.bowlTeam[2].Name
            PlayerFourBowl.text = displayMatch.bowlTeam[3].Name
            PlayerFiveBowl.text = displayMatch.bowlTeam[4].Name
        }
    }
    
    //https://stackoverflow.com/questions/35387327/how-do-i-make-a-new-line-in-swift
    @IBAction func shareButton(_ sender: UIButton) {
        let shareViewController = UIActivityViewController(activityItems: ["\(String(match!.team1Name)) vs \(String( match!.team2Name)) \n\(String( match!.team1Name)): \n\(String( match!.batTeam[0].Name)), \n\(String( match!.batTeam[1].Name)), \n\(String( match!.batTeam[2].Name)), \n\(String( match!.batTeam[3].Name)), \n\(String( match!.batTeam[4].Name)) \n\n\(String( match!.team2Name)): \n\(String( match!.bowlTeam[0].Name)), \n\(String( match!.bowlTeam[1].Name)), \n\(String( match!.bowlTeam[2].Name)), \n\(String( match!.bowlTeam[3].Name)), \n\(String( match!.bowlTeam[4].Name))"], applicationActivities: [])
        
        shareViewController.popoverPresentationController?.sourceView = sender
        
        present(shareViewController, animated: true, completion:nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
