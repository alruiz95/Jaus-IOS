//
//  MyCellTableViewCell.swift
//  ProyectoJaus
//
//  Created by Alberto on 11/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {

    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseDescriptionLabel: UILabel!
    @IBOutlet weak var housePriceLabel: UILabel!
    var houseID : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func destroy(_ sender: AnyObject) {
        let urlPath = CONSTANTS.BASE_URL + "/house_destroy?id="+String(self.houseID)
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("======>>>"+error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == CONSTANTS.STATUS_OK){
                print("Se Borro")
            }
            
            print("======>>>"+statusCode.description)
        })
        
        task.resume()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
