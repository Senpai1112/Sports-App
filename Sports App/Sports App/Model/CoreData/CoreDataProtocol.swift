//
//  CoreDataProtocol.swift
//  Sports App
//
//  Created by Yasser Yasser on 01/02/2025.
//

import Foundation

protocol CoreDataProtocol{
    static func initCoreData()
    static func insertIntoCoreData(leaguesData : LeaguesAndUrls)
    static func deleteFromCoreData(leagueId : Int)
    static func fetchFromCoreData(completionHandler : @escaping ([LeaguesAndUrls]?) -> Void)
    static func searchInCoreDataWith(leagueId:Int)->Bool
}
