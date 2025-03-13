//
//  TeamDetailsCollectionViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 31/01/2025.
//

import UIKit
import Reachability

//private let reuseIdentifier = "Cell"

class TeamDetailsCollectionViewController: UICollectionViewController , TeamsProtocol{

    var teamUrl : String?
    var team : [Teams]?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let presenter = TeamsPresenter()
        presenter.attachToTeamsView(View: self)
        presenter.fetchTeamData(teamUrl: teamUrl)
        
        collectionView.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout{index,environment in
            switch(index)
            {
            case 0:
                return self.drawTopSection()
            default:
                return self.drawBottomSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        initUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Team Details"
        
        //collectionView.backgroundView = UIImageView(image: UIImage(named: "darkBackGround"))
    }

    func initUI(){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    func drawBottomSection() -> NSCollectionLayoutSection
    {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
    func renderTeamToCollectionView(teamData: [Teams]) {
        team = teamData
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
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
        if (team != nil){
            return 2
        }else{
            return 0
        }
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section{
        case 0 :
            return team?.count ?? 0
        default:
            if let teamCount = team?[0].players?.count{
                return teamCount
            }else {
                return 0
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamLogoCollectionViewCell", for: indexPath) as! TeamLogoCollectionViewCell
            if let teamLogo = team?[indexPath.row].team_logo,
               let imageURL = URL(string: teamLogo) {
                cell.teamImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "lol")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.teamImage.image = UIImage(named: "lol")
            }
            cell.teamName.text = team?[indexPath.row].team_name
            cell.backgroundView = UIImageView(image: UIImage(named: "backGround1"))
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersDetailsCollectionViewCell", for: indexPath) as! PlayersDetailsCollectionViewCell
            if let playerImage = team?[0].players![indexPath.row].player_image,
               let imageURL = URL(string: playerImage) {
                cell.playerImage.kf.setImage(
                    with: imageURL,
                    placeholder: UIImage(named: "person")
                )
            } else {
                // Set placeholder directly if the URL or league_logo is nil
                cell.playerImage.image = UIImage(named: "person")
            }
            cell.playerName.text = team?[0].players![indexPath.row].player_name
            cell.playerType.text = team?[0].players![indexPath.row].player_type
            //cell.layer.borderWidth = 12
            //cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 5
            cell.layer.cornerRadius = 15
            cell.backgroundColor = .white
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCollectionReusableView
        switch indexPath.section{
        case 0:
            header.nameLabel.text = "team"
        default:
            header.nameLabel.text = "Players"
        }
        
        return header
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
