//
//  UserInfoTableViewCell.swift
//  likeVK
//
//  Created by Jambau on 29.10.2020.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var propertyAndItsValueTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
