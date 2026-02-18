//
//  MatchManageTableViewController.swift
//  cricketassign
//
//  Created by mobiledev on 15/5/2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class MatchManageTableViewController: UITableViewController {
    
    var matches = [Match]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchManagementTableViewCell", for: indexPath)
        
        if let matchCell = cell as? MatchManagementTableViewCell
        {
            matchCell.team1.text = match.team1Name
            matchCell.team2.text = match.team2Name
        }

        // Configure the cell...

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        super.prepare(for: segue, sender: segue)
        
        guard let playersViewController = segue.destination as? PlayerViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        guard let selectedMatchCell = sender as? MatchManagementTableViewCell else{
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedMatchCell) else{
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedMatch = matches[indexPath.row]
        
        playersViewController.match = selectedMatch
        playersViewController.matchIndex = indexPath.row
    }
    

}
