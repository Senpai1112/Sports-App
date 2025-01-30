//
//  FixtureCollectionViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 29/01/2025.
//

import UIKit

//private let reuseIdentifier = "Cell"

class FixtureCollectionViewController: UICollectionViewController , FixtureProtocol {
        
    var fixtures : [Fixtures]?
    var upComingEvents : [Fixtures]?
    var url : String?
    var upComing : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        
        let presenter = Presenter()
        presenter.attachToFixturesView(view: self)
        presenter.fetchFixturesUpComingEventsData(FixturesUrl: upComing)
        presenter.fetchFixturesData(FixturesUrl: url)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let layout = UICollectionViewCompositionalLayout{index,environment in
            switch(index)
            {
            case 0:
                return self.drawTopSection()
            default:
                return self.drawMiddleSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
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
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0:
            return upComingEvents?.count ?? 0
        default:
            return fixtures?.count ?? 0
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
            return cell
        default:
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
            return cell
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
