//
//  FavouriteViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 13/03/2025.
//

import UIKit

class FavouriteViewController: UIViewController  , UITableViewDataSource , UITableViewDelegate , FavouriteProtocol , RechabilityCheckingProtocol {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var backgroundImageView: UIImageView?

    
    var leaguesAndUrls : [LeaguesAndUrls]?
    let presenter = FavouritePresenter()
    var isReachable : Bool?
    let rechabilityPresenter = ReachabilityPresenter()


    func renderFavouriteLeaguesToTableView(leaguesData: [LeaguesAndUrls]) {
        leaguesAndUrls = leaguesData
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        presenter.initFavouriteData()
        presenter.attachToFavouriteView(View: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchFavouriteData()
        self.tabBarController?.title = "Favourites"
        //tableView.backgroundView = UIImageView(image: UIImage(named: "darkBackGround"))
        if leaguesAndUrls?.count == 0 {
            addBackgroundImage(named: "noFavorite")
        }
        else{
            removeBackgroundImage()
        }
        initUI()
    }
    
    func addBackgroundImage(named imageName: String) {
        if backgroundImageView == nil {
            let imageView = UIImageView(frame: CGRect(x:70 , y: 130, width: 250, height: 500))
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            imageView.tag = 100  // Assign a tag to easily remove later
            self.tableView.addSubview(imageView)
            self.tableView.sendSubviewToBack(imageView)  // Ensure it stays at the back
            backgroundImageView = imageView
        }
    }
    
    func removeBackgroundImage() {
        backgroundImageView?.removeFromSuperview()
        backgroundImageView = nil
    }
    
    func initUI(){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((leaguesAndUrls?.count) != nil){
            return 1
        }
        else
        {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaguesAndUrls?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        cell.leagueTitle.text = leaguesAndUrls?[indexPath.row].league_name
        if let leagueLogo = leaguesAndUrls?[indexPath.row].league_logo,
           let imageURL = URL(string: leagueLogo) {
            cell.leagueImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "lol")
            )
        } else {
            // Set placeholder directly if the URL or league_logo is nil
            cell.leagueImage.image = UIImage(named: "lol")
        }
        cell.leagueImage.layer.cornerRadius = 25
        cell.backgroundColor = .systemGray5
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 5
        cell.clipsToBounds = true
        //cell.layer.borderWidth = 5
        //cell.clipsToBounds = true

        //cell.backgroundView = UIImageView(image: UIImage(named: "backGround"))
        return cell
    }

    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alert = UIAlertController(title: "Deleting", message: "Do you want to delete \((leaguesAndUrls?[indexPath.row].league_name)!) from favourites", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "yes", style: .destructive, handler: { [self]_ in
                presenter.deleteFavouriteData(leagueId: (leaguesAndUrls![indexPath.row].league_key)!)
                leaguesAndUrls?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler:nil))
            self.present(alert, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rechabilityPresenter.attachToView(view: self)
        rechabilityPresenter.isWifiOrCellularRechable()
        if let isReachable = isReachable{
            if isReachable {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "FixtureCollectionViewController") as! FixtureCollectionViewController
                let leagueKey : Int = (leaguesAndUrls?[indexPath.row].league_key)!
                vc.league = leaguesAndUrls?[indexPath.row]
                let leagueKeyNS : NSNumber = leagueKey as NSNumber
                var strLeagueKey : String = "&leagueId="
                strLeagueKey.append(leagueKeyNS.stringValue)
                vc.url = (leaguesAndUrls?[indexPath.row].leagueUrl)! + strLeagueKey
                vc.upComingEventsUrl = (leaguesAndUrls?[indexPath.row].leagueUpComingMatchesUrl)! + strLeagueKey
                vc.teamsUrl = (leaguesAndUrls?[indexPath.row].leagueTeamsUrl)! + strLeagueKey
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LostConnectionViewController") as! LostConnectionViewController
                self.navigationController?.present(vc, animated: true)
            }
        }
    }
    
    func renderReachabilityToView(isReachable :Bool){
        self.isReachable = isReachable
    }

}
