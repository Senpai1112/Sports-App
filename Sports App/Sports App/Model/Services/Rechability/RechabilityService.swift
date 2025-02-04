//
//  RechabilityService.swift
//  Sports App
//
//  Created by Yasser Yasser on 04/02/2025.
//

import Foundation
import Reachability

class RechabilityService : RechabilityProtocol{
    static func isRechable(completionHandler: @escaping (Bool) -> Void){
        do{
            let reachability = try Reachability()
            if reachability.connection == .wifi || reachability.connection == .cellular{
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
}
