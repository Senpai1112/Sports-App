//
//  FakeNetwork.swift
//  Sports AppTests
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation
@testable import Sports_App
import Reachability
class FakeNetwork : ApiProtocol{
    static var isReachable : Bool?
    static var leaguesData : [Leagues]?
    static var teamsData : [Teams]?
    static var fixturesData : [Fixtures]?
    
    init(isReachable: Bool , leaguesData : [Leagues]?, teamsData : [Teams]? , fixturesData : [Fixtures]?) {
        FakeNetwork.isReachable = isReachable
        FakeNetwork.fixturesData = fixturesData
        FakeNetwork.teamsData = teamsData
        FakeNetwork.leaguesData = leaguesData
    }
    static func fetchDataFromLeaguesJson(LeaguesUrl url : String,completionHandler: @escaping ([Leagues]?) -> Void){
        if let isRechable = FakeNetwork.isReachable{
            if isRechable{
                let league1 = Leagues()
                league1.league_key = 1
                league1.league_name = "Premier League"
                league1.league_logo = ""
                
                let league2 = Leagues()
                league1.league_key = 2
                league1.league_name = "Spain League"
                league1.league_logo = ""
                
                let mockLeagues = [league1,league2]
                
                completionHandler(mockLeagues)
            }else{
                completionHandler(nil)
            }
        }else{
            completionHandler(nil)
        }
    }
    
    static func fechDataFromFixturesJson(fixturesUrl url : String,completionHandler: @escaping ([Fixtures]?) -> Void){
        if let isRechable = FakeNetwork.isReachable{
            if isRechable{
                let fixtures1 = Fixtures()
                fixtures1.away_team_logo = "away_team_logo1"
                fixtures1.home_team_logo = "home_team_logo1"
                
                
                let fixtures2 = Fixtures()
                fixtures1.away_team_logo = "away_team_logo2"
                fixtures1.home_team_logo = "home_team_logo2"
                
                let mockFixtures = [fixtures1,fixtures2]
                completionHandler(mockFixtures)
            }else{
                completionHandler(nil)
            }
        }else{
            completionHandler(nil)
        }
    }
    
    static func fetchDataFromTeamsJson(teamsUrl url : String , completionHandler: @escaping ([Teams]?) -> Void){
        if let isRechable = isReachable{
            if isRechable{
                let team1 = Teams()
                team1.team_name = "team1"
                team1.team_key = 1
                
                
                let team2 = Teams()
                team2.team_name = "team2"
                team2.team_key = 2
                
                let mockteams = [team1,team2]
                completionHandler(mockteams)
            }else{
                completionHandler(nil)
            }
        }else{
            completionHandler(nil)
        }
    }
}
