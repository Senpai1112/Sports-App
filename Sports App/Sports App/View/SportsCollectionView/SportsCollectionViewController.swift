//
//  SportsCollectionViewController.swift
//  Sports App
//
//  Created by Yasser Yasser on 27/01/2025.
//

import UIKit

//private let reuseIdentifier = "Cell"

class SportsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Sports"
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 10, height: UIScreen.main.bounds.size.height/2 - 10)
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        switch indexPath.row{
        case 0:
            cell.sportImage.image = UIImage(named: "footBall")
            cell.sportName.text = "Football"
        case 1:
            cell.sportImage.image = UIImage(named: "basketBall")
            cell.sportName.text = "BasketBall"
        case 2:
            cell.sportImage.image = UIImage(named: "cricket")
            cell.sportName.text = "Cricket"
        default:
            cell.sportImage.image = UIImage(named: "tennis")
            cell.sportName.text = "Tennis"
        }
        
        // Configure the cell
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LeaguesTableViewController") as! LeaguesTableViewController
        switch indexPath.row{
            // football leagues
        case 0:
            vc.sport = "footBall"
            vc.url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=63a132851e4cc98a59ef8fb84943ede033052613356a09a32fb125467d1d2a46"
        case 1:
            vc.sport = "basketBall"
            vc.url = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=63a132851e4cc98a59ef8fb84943ede033052613356a09a32fb125467d1d2a46"
        case 2:
            vc.sport = "cricket"
            vc.url = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=63a132851e4cc98a59ef8fb84943ede033052613356a09a32fb125467d1d2a46"
        default:
            vc.sport = "tennis"
            vc.url = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=63a132851e4cc98a59ef8fb84943ede033052613356a09a32fb125467d1d2a46"
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

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
