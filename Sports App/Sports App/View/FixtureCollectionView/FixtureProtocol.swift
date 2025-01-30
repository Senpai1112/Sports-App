//
//  FixtureProtocol.swift
//  Sports App
//
//  Created by Yasser Yasser on 30/01/2025.
//

import Foundation

protocol FixtureProtocol{
    func renderToCollectionView(fixturesData : [Fixtures])
    func renderUpComingEventsToCollectionView(fixturesData : [Fixtures])
}
