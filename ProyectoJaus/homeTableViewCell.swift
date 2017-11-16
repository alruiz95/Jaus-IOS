//
//  homeTableViewCell.swift
//  ProyectoJaus
//
//  Created by Alberto on 11/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class homeTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellAddress: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
