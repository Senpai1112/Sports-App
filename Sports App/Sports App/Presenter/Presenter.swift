//
//  Presenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation
class Presenter {
  
    var view : LeaguesProtocol?
    
    func fetchData(LeaguesUrl url : String?){
        ApiService.fetchDataFromJson(LeaguesUrl: url!) { (data) in
            self.view?.renderToTableView(leaguesData: data!)
        }
    }
    
    func attach(view : LeaguesProtocol)
    {
        self.view = view
    }
}
