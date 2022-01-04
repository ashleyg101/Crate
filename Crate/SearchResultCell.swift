//
//  SearchResultCell.swift
//  Crate
//
//  Created by Ashley Gong on 12/2/21.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var artworkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
