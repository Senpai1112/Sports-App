//
//  Fixtures.swift
//  Sports App
//
//  Created by Yasser Yasser on 29/01/2025.
//

import Foundation

class FixturesResult : Codable{
    var success : Int?
    var result : [Fixtures]
}

class Fixtures : Codable{
    var home_team_logo : String?
    var away_team_logo : String?
    var event_time : String?
    var event_home_team : String?
    var event_away_team : String?
    var event_final_result : String?
    var event_date : String?
}
