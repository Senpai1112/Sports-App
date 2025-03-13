//
//  TestingApi.swift
//  Sports AppTests
//
//  Created by Yasser Yasser on 05/02/2025.
//

import XCTest
@testable import Sports_App
@testable import Reachability

final class TestingApi: XCTestCase {
    
    var fakeNetwork : FakeNetwork!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        fakeNetwork = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testfetchDataFromLeaguesJson() {
        let expectation = self.expectation(description: "Fetch Leagues Success")
        let league1 = Leagues()
        league1.league_key = 1
        league1.league_name = "Premier League"
        league1.league_logo = ""
        
        let league2 = Leagues()
        league1.league_key = 2
        league1.league_name = "Spain League"
        league1.league_logo = ""
        
        let mockLeagues = [league1,league2]
        
        fakeNetwork = FakeNetwork(isReachable: true, leaguesData: mockLeagues, teamsData: nil, fixturesData: nil)
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { leagues in
            XCTAssertNotNil(leagues, "Leagues should not be nil")
            XCTAssertEqual(leagues?.count, mockLeagues.count,"Leagues count should match mock data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testfailedFailed() {
        fakeNetwork = FakeNetwork(isReachable: false, leaguesData: nil, teamsData: nil, fixturesData: nil)
        let expectation = self.expectation(description: "Fetch Leagues Failure")
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { leagues in
            XCTAssertNil(leagues, "Leagues should be nil when network is unreachable")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testfechDataFromFixturesJson() {
        let expectation = self.expectation(description: "Fetch Leagues Success")
        let fixtures1 = Fixtures()
        fixtures1.away_team_logo = "away_team_logo1"
        fixtures1.home_team_logo = "home_team_logo1"
        
        
        let fixtures2 = Fixtures()
        fixtures1.away_team_logo = "away_team_logo2"
        fixtures1.home_team_logo = "home_team_logo2"
        
        let mockFixtures = [fixtures1,fixtures2]
        
        fakeNetwork = FakeNetwork(isReachable: true, leaguesData: nil, teamsData: nil, fixturesData: mockFixtures)
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { fixtures in
            XCTAssertNotNil(fixtures, "Fixtures should not be nil")
            XCTAssertEqual(fixtures?.count, mockFixtures.count,"Fixtures count should match mock data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchFixturesFailure() {
        fakeNetwork = FakeNetwork(isReachable: false, leaguesData: nil, teamsData: nil, fixturesData: nil)
        let expectation = self.expectation(description: "Fetch Fixtures Failure")
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { fixtures in
            XCTAssertNil(fixtures, "Fixtures should be nil when network is unreachable")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testfetchDataFromTeamsJson() {
        let expectation = self.expectation(description: "Fetch Leagues Success")
        let team1 = Teams()
        team1.team_name = "team1"
        team1.team_key = 1
        
        
        let team2 = Teams()
        team2.team_name = "team2"
        team2.team_key = 2
        
        let mockteams = [team1,team2]
        
        fakeNetwork = FakeNetwork(isReachable: true, leaguesData: nil, teamsData: mockteams, fixturesData: nil)
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { teams in
            XCTAssertNotNil(mockteams, "Teams should not be nil")
            XCTAssertEqual(teams?.count, mockteams.count,"Teams count should match mock data")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testFetchTeamsFailure() {
        fakeNetwork = FakeNetwork(isReachable: false, leaguesData: nil, teamsData: nil, fixturesData: nil)
        let expectation = self.expectation(description: "Fetch teams Failure")
        
        FakeNetwork.fetchDataFromLeaguesJson(LeaguesUrl: "mockURL") { teams in
            XCTAssertNil(teams, "teams should be nil when network is unreachable")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
