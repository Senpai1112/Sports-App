//
//  LeaguesTableViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 28/01/2025.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController ,LeaguesProtocol{

    var url : String?
    var sport : String?
    var leagues : [Leagues]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = Presenter()
        presenter.attachToLeaguesView(view: self)
        presenter.fetchLeaguesData(LeaguesUrl: url)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func renderToTableView(leaguesData : [Leagues]){
        leagues = leaguesData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if ((leagues?.count) != nil){
            return 1
        }
        else
        {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCustomTableViewCell
        cell.leagueTitle.text = leagues?[indexPath.row].league_name
        if let leagueLogo = leagues?[indexPath.row].league_logo,
           let imageURL = URL(string: leagueLogo) {
            cell.leagueImage.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "lol")
            )
        } else {
            // Set placeholder directly if the URL or league_logo is nil
            cell.leagueImage.image = UIImage(named: "lol")
        }
        cell.backgroundColor = .lightGray
        cell.layer.borderColor = UIColor.systemBackground.cgColor
        cell.layer.borderWidth = 5
        cell.clipsToBounds = true

        //cell.backgroundView = UIImageView(image: UIImage(named: "backGround"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FixtureCollectionViewController") as! FixtureCollectionViewController
        
        switch sport
        {
        case "footBall":
            vc.league_key = leagues?[indexPath.row].league_key
            vc.url = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=63a132851e4cc98a59ef8fb84943ede033052613356a09a32fb125467d1d2a46&leagueid=152&from=2021-05-18&to=2021-05-18"
            print(sport!)
        case "basketBall":
            print(sport!)
        case "cricket":
            print(sport!)
        default:
            print(sport!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
