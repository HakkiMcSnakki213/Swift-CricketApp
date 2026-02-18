//
//  PastMatchesTableViewCell.swift
//  cricketassign
//
//  Created by mobiledev on 15/5/2024.
//

import UIKit

class PastMatchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var team2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
