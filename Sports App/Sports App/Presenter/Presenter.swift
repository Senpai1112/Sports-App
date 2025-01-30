//
//  Presenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation
class Presenter {
    // for leagues data
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
    
    //for fixtures data
    var fixturesView : FixtureProtocol?
    
    func fetchFixturesData(FixturesUrl url : String?){
        ApiService.fechDataFromFixturesJson(fixturesUrl: url!) { (data) in
            self.fixturesView?.renderToCollectionView(fixturesData: data!)
        }
    }
    
    func attachToFixturesView(view : FixtureProtocol)
    {
        self.fixturesView = view
    }

}
