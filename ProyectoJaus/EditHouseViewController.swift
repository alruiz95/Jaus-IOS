//
//  EditHouseViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 18/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class EditHouseViewController: UIViewController {

    @IBOutlet weak var isNegotiableSwitch: UISwitch!
    @IBOutlet weak var houseNameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    var houseToEdit : House? = nil
    var Negotiable: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        houseNameTextField.text = houseToEdit?.name
        address1TextField.text = houseToEdit?.address
        let price : Int = (self.houseToEdit?.price)!
        priceTextField.text = String(price)
        descriptionTextField.text = houseToEdit?.details
        
        
        isNegotiableSwitch.setOn((houseToEdit?.isNegotiable)!, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func negotiable(_ sender: AnyObject) {
        if (self.Negotiable == "1"){
            self.Negotiable = "0"
        }else{
            self.Negotiable = "1"
        }
    }
    
    @IBAction func saveChanges(_ sender: AnyObject) {
        
        
        var urlPath : String = CONSTANTS.BASE_URL + "/update_house?houseID="
        
        
        let id : Int = (self.houseToEdit?.houseID)!
        urlPath+=String(id)
        urlPath+="&name="+houseNameTextField.text!
        urlPath+="&address="+address1TextField.text!+address2TextField.text!
        urlPath+="&details="+descriptionTextField.text!
        urlPath+="&price="+priceTextField.text!
        urlPath+="&isNegotiable="+Negotiable
        
        print("======>>>>>  "+urlPath)
        
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("======>>>"+error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print("======>>>"+statusCode.description)
        })
        
        task.resume()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
