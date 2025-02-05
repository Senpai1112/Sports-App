//
//  LeaguesPresenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation

class LeaguesPresenter{
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
}
