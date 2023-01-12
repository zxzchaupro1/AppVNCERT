//
//  UserTableViewCell.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 09/11/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDeletePerson: UIButton!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var indexPath: IndexPath = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
