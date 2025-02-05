//
//  FixturesPresenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation

class FixturesPresenter{
    var fixturesView : FixtureProtocol?
    
    
    func attachToFixturesView(view : FixtureProtocol)
    {
        self.fixturesView = view
    }
    
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

    
}
