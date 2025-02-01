//
//  FavouriteTableViewCell.swift
//  Sports App
//
//  Created by Yasser Yasser on 01/02/2025.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var leagueTitle: UILabel!
    
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
