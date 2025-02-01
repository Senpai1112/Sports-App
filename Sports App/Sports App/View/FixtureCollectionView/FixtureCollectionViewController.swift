//
//  FixtureCollectionViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 29/01/2025.
//

import UIKit

//private let reuseIdentifier = "Cell"

class FixtureCollectionViewController: UICollectionViewController , FixtureProtocol {
    
    let presenter = Presenter()
    var rightButton : UIBarButtonItem?
    var fixtures : [Fixtures]?
    var upComingEvents : [Fixtures]?
    var teams : [Teams]?
    var url : String?
    var upComingEventsUrl : String?
    var teamsUrl : String?
    var league : Leagues?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        presenter.initFavouriteData()
        presenter.attachToFixturesView(view: self)
        presenter.fetchFixturesUpComingEventsData(FixturesUrl: upComingEventsUrl)
        presenter.fetchFixturesData(FixturesUrl: url)
        presenter.fetchTeamsData(teamsUrl: teamsUrl)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        collectionView.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout{index,environment in
            switch(index)
            {
            case 0:
                return self.drawTopSection()
            case 1:
                return self.drawMiddleSection()
            default:
                return self.drawBottomSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    @objc func addToFavourite(){
        if presenter.searchInFavourites(leagueId: (league?.league_key)!){
            presenter.deleteFavouriteData(leagueId:  (league?.league_key)!)
            rightButton = UIBarButtonItem(image: UIImage(named: "whiteHeart") ,style: .done, target: self, action: #selector(addToFavourite))
            self.navigationItem.rightBarButtonItem = rightButton
        }else{
            let leagueData = LeaguesAndUrls()
            leagueData.leagueUrl = url
            leagueData.leagueUpComingMatchesUrl = upComingEventsUrl
            leagueData.leagueTeamsUrl = teamsUrl
            leagueData.league_key = league?.league_key
            leagueData.league_logo = league?.league_logo
            leagueData.league_name = league?.league_name
            
            presenter.insertFavouriteData(leagueData: leagueData)
            rightButton = UIBarButtonItem(image: UIImage(named: "redHeart") ,style: .done, target: self, action: #selector(addToFavourite))
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "League Details"
        if presenter.searchInFavourites(leagueId: (league?.league_key)!){
            rightButton = UIBarButtonItem(image: UIImage(named: "redHeart") ,style: .done, target: self, action: #selector(addToFavourite))
            self.navigationItem.rightBarButtonItem = rightButton
        }else{
            rightButton = UIBarButtonItem(image: UIImage(named: "whiteHeart") ,style: .done, target: self, action: #selector(addToFavourite))
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    func drawTopSection() -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func drawMiddleSection() -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    func drawBottomSection() -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        return section
    }
    
    func renderUpComingEventsToCollectionView(fixturesData: [Fixtures]) {
        upComingEvents = fixturesData
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func renderToCollectionView(fixturesData: [Fixtures]) {
        fixtures = fixturesData
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func renderTeamsToCollectionView(teamsData: [Teams]) {
        teams = teamsData
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            return upComingEvents?.count ?? 0
        case 1:
            return fixtures?.count ?? 0
        default:
            return teams?.count ?? 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopFixtureCollectionViewCell", for: indexPath) as! TopFixtureCollectionViewCell
            if let away_team_logo = upComingEvents?[indexPath.row].away_team_logo,
               let imageURL = URL(string: away_team_logo) {
                cell.awayTeamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.awayTeamImage.image = UIImage(named: "lol")
            }
            
            if let home_team_logo = upComingEvents?[indexPath.row].home_team_logo,
               let imageURL = URL(string: home_team_logo) {
                cell.homeTeamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.homeTeamImage.image = UIImage(named: "lol")
            }
            
            cell.awayTeamName.text = upComingEvents?[indexPath.row].event_away_team
            cell.homeTeamName.text = upComingEvents?[indexPath.row].event_home_team
            cell.date.text = upComingEvents?[indexPath.row].event_date
            
            cell.backgroundView = UIImageView(image: UIImage(named: "backGround1"))
            // Configure the cell
            cell.layer.borderWidth = 10
            cell.layer.cornerRadius = 30
            cell.backgroundColor = .white
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiddleFixtureCollectionViewCell", for: indexPath) as! MiddleFixtureCollectionViewCell
            
            if let away_team_logo = fixtures?[indexPath.row].away_team_logo,
               let imageURL = URL(string: away_team_logo) {
                cell.awayTeamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.awayTeamImage.image = UIImage(named: "lol")
            }
            
            if let home_team_logo = fixtures?[indexPath.row].home_team_logo,
               let imageURL = URL(string: home_team_logo) {
                cell.homeTeamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.homeTeamImage.image = UIImage(named: "lol")
            }
            
            cell.awayTeamName.text = fixtures?[indexPath.row].event_away_team
            cell.homeTeamName.text = fixtures?[indexPath.row].event_home_team
            cell.date.text = fixtures?[indexPath.row].event_date
            cell.finalResult.text = fixtures?[indexPath.row].event_final_result
            
            cell.backgroundView = UIImageView(image: UIImage(named: "backGround1"))
            // Configure the cell
            cell.layer.borderWidth = 5
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .white
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomFixturesCollectionViewCell", for: indexPath) as! BottomFixturesCollectionViewCell
            
            if let teamImage = teams?[indexPath.row].team_logo,
               let imageURL = URL(string: teamImage) {
                cell.teamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.teamImage.image = UIImage(named: "lol")
            }
            cell.teamName.text = teams?[indexPath.row].team_name
            // Configure the cell
            cell.layer.borderWidth = 5
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .white
            return cell
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let teamsVC = storyBoard.instantiateViewController(withIdentifier: "TeamDetailsCollectionViewController") as! TeamDetailsCollectionViewController
            let teamKey : Int = (teams?[indexPath.row].team_key)!
            let teamKeyNS : NSNumber = teamKey as NSNumber
            var strTeamKey : String = "&teamId="
            strTeamKey.append(teamKeyNS.stringValue)
            teamsVC.teamUrl = teamsUrl! + strTeamKey
            navigationController?.pushViewController(teamsVC, animated: true)
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
