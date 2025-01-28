//
//  ApiService.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation

class ApiService : ApiProtocol
{
    static var leaguesResult : LeaguesResult?
    static func fetchDataFromJson(LeaguesUrl url : String,completionHandler: @escaping ([Leagues]?) -> Void) {
        let url = URL(string: url)
        guard let guardedUrl = url
        else
        {
            return
        }
        let request = URLRequest(url:guardedUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            // closure code
            guard let guardedData = data else
            {
                return
            }
            do {
                leaguesResult = try JSONDecoder().decode(LeaguesResult.self, from: guardedData)
                completionHandler((leaguesResult?.result)!)
            }catch
            {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    
}
