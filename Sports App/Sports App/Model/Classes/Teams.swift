//
//  Teams.swift
//  Sports App
//
//  Created by Yasser Yasser on 31/01/2025.
//

import Foundation

class TeamsResult : Codable{
    var success : Int?
    var result : [Teams]?
}

class Teams : Codable{
    var team_key : Int?
    var team_name : String?
    var team_logo : String?
    var players : [Players]?
}

class Players : Codable{
    var player_name : String?
    var player_type : String?
    var player_image : String?
}
