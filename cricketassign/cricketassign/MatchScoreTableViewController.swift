//
//  MatchScoreTableViewController.swift
//  cricketassign
//
//  Created by mobiledev on 15/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchScoreTableViewController: UITableViewController {
    
    var matches = [Match]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let db = Firestore.firestore()
        let matchCollection = db.collection("matches")
        matchCollection.getDocuments(){ (result, err) in
            if let err = err
            {
               print("Error getting documents: \(err)")
            }
            else
            {
                for document in result!.documents
                {
                    let conversionResult = Result
                    {
                        try document.data(as: Match.self)
                    }
                    switch conversionResult
                    {
                        case .success(let match):
                            print("Match: \(match)")
                            
                        if(match.matchComplete == false){
                            self.matches.append(match)
                        }
                        
                        case .failure(let error):
                            print("Error decoding match: \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let match = matches[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchScoreTableViewCell", for: indexPath)
        
        if let matchCell = cell as? MatchScoreTableViewCell
        {
            matchCell.team1.text = match.team1Name
            matchCell.team2.text = match.team2Name
        }

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let scoreViewController = segue.destination as? MatchViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        guard let selectedMatchCell = sender as? MatchScoreTableViewCell else{
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedMatchCell) else{
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedMatch = matches[indexPath.row]
        
        scoreViewController.match = selectedMatch
        scoreViewController.matchIndex = indexPath.row
    }
}
