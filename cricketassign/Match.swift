//
//  Match.swift
//  cricketassign
//
//  Created by mobiledev on 22/5/2024.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Match : Codable
{
    @DocumentID var documentID: String?
    var totalRuns:Int32?
    var Overs:Int32?
    var Wickets:Int32?
    var Balls:Int32?
    var matchComplete:Bool?
    
    //Team 1
    var team1Name:String
    var batTeam: [Player] = []
    var currentBatter:Player
    var currentRunner:Player
    
    //Team 2
    var team2Name:String
    var bowlTeam: [Player] = []
    var currentBowler:Player
}
