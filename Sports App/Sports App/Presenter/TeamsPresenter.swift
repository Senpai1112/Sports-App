//
//  TeamsPresenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation

class TeamsPresenter{
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
}
