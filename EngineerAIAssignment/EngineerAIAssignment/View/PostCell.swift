//
//  PostCell.swift
//  EngineerAIAssignment
//
//  Created by Kushal Mandala on 25/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    
    @IBOutlet weak var toggle: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
