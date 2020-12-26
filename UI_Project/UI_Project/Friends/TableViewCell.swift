//
//  TableViewCell.swift
//  UI_Project
//
//  Created by Shisetsu on 12.12.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
