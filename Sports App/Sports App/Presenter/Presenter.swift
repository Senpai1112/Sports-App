//
//  Presenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation
class Presenter {
    // for leagues data
    /*/////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    var leaguesView : LeaguesProtocol?
    
    func fetchLeaguesData(LeaguesUrl url : String?){
        ApiService.fetchDataFromLeaguesJson(LeaguesUrl: url!) { (data) in
            self.leaguesView?.renderToTableView(leaguesData: data!)
        }
    }
    
    func attachToLeaguesView(view : LeaguesProtocol)
    {
        self.leaguesView = view
    }
    
    /*/////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    //for fixtures data
    var fixturesView : FixtureProtocol?
    
    func fetchFixturesData(FixturesUrl url : String?){
        ApiService.fechDataFromFixturesJson(fixturesUrl: url!) { (data) in
            if let data = data{
                self.fixturesView?.renderToCollectionView(fixturesData: data)
            }
            else{
                self.fixturesView?.renderToCollectionView(fixturesData: [])
            }
            
        }
    }
    
    func fetchFixturesUpComingEventsData(FixturesUrl url : String?){
        ApiService.fechDataFromFixturesJson(fixturesUrl: url!) { (data) in
            if let data = data{
                self.fixturesView?.renderUpComingEventsToCollectionView(fixturesData: data)
            }
            else
            {
                self.fixturesView?.renderUpComingEventsToCollectionView(fixturesData: [])
            }
        }
    }
    
    func fetchTeamsData(teamsUrl url : String?){
        ApiService.fetchDataFromTeamsJson(teamsUrl: url!) { (data) in
            if let data = data{
                self.fixturesView?.renderTeamsToCollectionView(teamsData: data)
            }
            else
            {
                self.fixturesView?.renderTeamsToCollectionView(teamsData: [])
            }
        }
    }
    
    func attachToFixturesView(view : FixtureProtocol)
    {
        self.fixturesView = view
    }
    
    /*/////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    // teams data
    var teamsView : TeamsProtocol?
    func attachToTeamsView(View : TeamsProtocol){
        self.teamsView = View
    }
    
    func fetchTeamData(teamUrl url : String?){
        ApiService.fetchDataFromTeamsJson(teamsUrl: url!) { (data) in
            if let data = data{
                self.teamsView?.renderTeamToCollectionView(teamData: data)
            }
            else
            {
                self.teamsView?.renderTeamToCollectionView(teamData: [])
            }
        }
    }
    
    /*/////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    // for core Data
    var favouriteView : FavouriteProtocol?
    func attachToFavouriteView(View : FavouriteProtocol){
        self.favouriteView = View
    }
    func initFavouriteData(){
        CoreDataManager.initCoreData()
    }
    
    func fetchFavouriteData(){
        CoreDataManager.fetchFromCoreData(completionHandler: {
            data in
            if let data = data{
                self.favouriteView?.renderFavouriteLeaguesToTableView(leaguesData: data)
            }else{
                self.favouriteView?.renderFavouriteLeaguesToTableView(leaguesData: [])
            }
        })
    }
    func deleteFavouriteData(leagueId : Int){
        CoreDataManager.deleteFromCoreData(leagueId: leagueId)
    }
    func insertFavouriteData(leagueData : LeaguesAndUrls){
        CoreDataManager.insertIntoCoreData(leaguesData: leagueData)
    }
    
    func searchInFavourites(leagueId : Int) -> Bool{
        return CoreDataManager.searchInCoreDataWith(leagueId: leagueId)
    }
}
