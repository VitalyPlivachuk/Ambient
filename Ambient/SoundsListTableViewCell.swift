//
//  SoundsListTableViewCell.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 08.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class SoundsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var favoriteIndicatorImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
