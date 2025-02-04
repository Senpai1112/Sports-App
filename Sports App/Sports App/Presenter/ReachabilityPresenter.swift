//
//  RechabilityPresenter.swift
//  Sports App
//
//  Created by Yasser Yasser on 05/02/2025.
//

import Foundation

class ReachabilityPresenter{
    
    var view : RechabilityCheckingProtocol?
    func attachToView(view : RechabilityCheckingProtocol){
        self.view = view
    }
    func isWifiOrCellularRechable(){
        RechabilityService.isRechable(completionHandler: { [weak self] isReachableflag in
            self!.view?.renderReachabilityToView(isReachable: isReachableflag)
        })
    }
}
