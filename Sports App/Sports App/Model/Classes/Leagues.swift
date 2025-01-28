//
//  Leagues.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation


class LeaguesResult : Codable{
    var success : Int?
    var result : [Leagues]?
}

class Leagues : Codable
{
    var league_name : String?
    var league_logo : String?
}
