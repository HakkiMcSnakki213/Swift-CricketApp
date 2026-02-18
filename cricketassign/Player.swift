//
//  Player.swift
//  cricketassign
//
//  Created by mobiledev on 22/5/2024.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct Player : Codable
{
    var Name:String
    var Balls:Int32?
    var Runs:Int32?
    var hasBowled:Bool?
    var hasBatted:Bool?
    
}

/*
 https://developer.apple.com/documentation/swift/equatable
 */
extension Player : Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.Name == rhs.Name &&
        lhs.Balls == rhs.Balls &&
        lhs.Runs == rhs.Runs &&
        lhs.hasBowled == rhs.hasBowled &&
        lhs.hasBatted == rhs.hasBatted
    }
}
