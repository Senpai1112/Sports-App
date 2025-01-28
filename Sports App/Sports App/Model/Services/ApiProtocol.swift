//
//  ApiProtocol.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import Foundation

protocol ApiProtocol {
    static func fetchDataFromJson(LeaguesUrl url : String,completionHandler: @escaping ([Leagues]?) -> Void)
}
