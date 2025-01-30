//
//  ApiProtocol.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation

protocol ApiProtocol {
    static func fetchDataFromLeaguesJson(LeaguesUrl url : String,completionHandler: @escaping ([Leagues]?) -> Void)
    
    static func fechDataFromFixturesJson(fixturesUrl url : String,completionHandler: @escaping ([Fixtures]?) -> Void)
}
