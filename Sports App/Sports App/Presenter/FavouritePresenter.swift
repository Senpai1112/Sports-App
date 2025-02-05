//
//  FavouritePresenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation

class FavouritePresenter{
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
