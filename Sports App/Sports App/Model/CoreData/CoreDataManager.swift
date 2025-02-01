//
//  CoreDataManager.swift
//  Sports App
//
//  Created by Yasser Yasser on 01/02/2025.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager : CoreDataProtocol{

    static var manager : NSManagedObjectContext!
    //static var fetchedMovie : [NSManagedObject] = []

     static func initCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manager = appDelegate.persistentContainer.viewContext
    }
    static func insertIntoCoreData(leaguesData : LeaguesAndUrls){
        let entity = NSEntityDescription.entity(forEntityName: "LeaguesEntity", in: manager)
        
        let leagues = NSManagedObject(entity: entity!, insertInto: manager)
        
        leagues.setValue(leaguesData.league_key, forKey: "leagueKey")
        leagues.setValue(leaguesData.league_logo, forKey: "leagueLogo")
        leagues.setValue(leaguesData.league_name, forKey: "leagueName")
        leagues.setValue(leaguesData.leagueUrl, forKey: "leagueUrl")
        leagues.setValue(leaguesData.leagueUpComingMatchesUrl, forKey: "leagueUpComingMatchesUrl")
        leagues.setValue(leaguesData.leagueTeamsUrl, forKey: "leagueTeamsUrl")
        
        do{
            try manager.save()
        }
        catch let error as NSError{
            print(error)
        }
    }
    static func deleteFromCoreData(leagueId : Int){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "LeaguesEntity")
        
        // predicate
        
        let predicate = NSPredicate(format: "leagueKey == \(leagueId)")
        fetch.predicate = predicate
        do{
            let objects = try manager.fetch(fetch)
                for object in objects {
                    manager.delete(object)
                }
            try manager.save()
        }catch let error
        {
            print(error.localizedDescription)
        }
    }
    static func fetchFromCoreData(completionHandler : @escaping ([LeaguesAndUrls]?) -> Void){
        let fetchRequest = NSFetchRequest<NSManagedObject> (entityName: "LeaguesEntity")
        var leagues = [LeaguesAndUrls]()
        do{
            let league = LeaguesAndUrls()
            let fetchedLeagues = try manager.fetch(fetchRequest)
            for item in fetchedLeagues{
                league.leagueTeamsUrl = item.value(forKey: "leagueTeamsUrl") as? String
                league.leagueUpComingMatchesUrl = item.value(forKey: "leagueUpComingMatchesUrl") as? String
                league.leagueUrl = item.value(forKey: "leagueUrl") as? String
                league.league_key = item.value(forKey: "leagueKey") as? Int
                league.league_logo = item.value(forKey: "leagueLogo") as? String
                league.league_name = item.value(forKey: "leagueName") as? String
                leagues.append(league)
            }
            completionHandler(leagues)
        }
        catch let error
        {
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    static func searchInCoreDataWith(leagueId:Int)->Bool{
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "LeaguesEntity")
        
        // predicate
        
        let predicate = NSPredicate(format: "leagueKey == \(leagueId)")
        fetch.predicate = predicate
        do{
            let objects = try manager.fetch(fetch)
            if objects.isEmpty{
                return false
            }else{
                return true
            }
        }catch let error
        {
            print(error.localizedDescription)
            return false
        }
    }
}
