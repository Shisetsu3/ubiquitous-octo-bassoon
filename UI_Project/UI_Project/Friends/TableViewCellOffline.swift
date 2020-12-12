//
//  TableViewCellOffline.swift
//  UI_Project
//
//  Created by  Shisetsu on 12.12.2020.
//

import UIKit

class TableViewCellOffline: UITableViewCell {

    @IBOutlet weak var friendPhotoOff: UIImageView!
    @IBOutlet weak var friendLabelOff: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
