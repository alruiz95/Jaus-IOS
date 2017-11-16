//
//  houseViewViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 18/10/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class houseViewViewController: UIViewController {
    @IBOutlet weak var waterServiceLabel: UILabel!
    @IBOutlet weak var lightServiceLabel: UILabel!
    @IBOutlet weak var internetServiceLabel: UILabel!
    @IBOutlet weak var cableServiceLabel: UILabel!
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var houseDescription: UITextView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var house: House? = nil
    var services : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waterServiceLabel.backgroundColor = UIColor(patternImage: UIImage(named: "water.png")!)
        lightServiceLabel.backgroundColor = UIColor(patternImage: UIImage(named: "light.png")!)
        internetServiceLabel.backgroundColor = UIColor(patternImage: UIImage(named: "internet.png")!)
        cableServiceLabel.backgroundColor = UIColor(patternImage: UIImage(named: "cable.png")!)        
        
        
        address1Label.text = house?.name
        address2Label.text = house?.address
        priceLabel.text = String (describing: house?.price)
        houseDescription.text = house?.details
        // Do any additional setup after loading the view.
        connect()
        getServices()
    }
    
    func buttonColor(label: UILabel, isOn: Bool) ->Void{
        if(isOn == false){
            label.layer.borderWidth = 5.0
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.borderWidth = 2.0
            label.layer.cornerRadius = 8
        }else{
            label.layer.borderWidth = 5.0
            label.layer.borderColor = UIColor.green.cgColor
            label.layer.borderWidth = 2.0
            label.layer.cornerRadius = 8
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func connect(){
        
        let urlPath : String! = CONSTANTS.BASE_URL + "/get_user?username="+(house?.provUsername)!
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //let convertedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            if statusCode == CONSTANTS.STATUS_OK {
                
                DispatchQueue.main.async{
                    self.phoneNumberLabel.text = JSON.pasrsePhoneNumber(data!)
                    
                }
                
            }
            print(statusCode.description)
        })
        
        task.resume()
    }
    
    func getServices(){
        
        let urlPath : String = CONSTANTS.BASE_URL + "/get_house_services?houseID="+String(describing: house?.houseID)
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            //let convertedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            if statusCode == CONSTANTS.STATUS_OK {
                
                DispatchQueue.main.async{
                     self.services = JSON.parseServices(data!)
                    self.completeServices()
                }
                
            }
            print(statusCode.description)
        })
        
        task.resume()
    }
    
    func completeServices(){
        if (self.services.count==0){
            return
        }else{
            for service in services{
                if(service == "Electricidad"){
                   buttonColor(label: lightServiceLabel, isOn: true)
                }
                if(service == "Internet"){
                   buttonColor(label: internetServiceLabel, isOn: true)
                }
                if(service == "Recoleccion de basura"){
                    buttonColor(label: cableServiceLabel, isOn: true)
                }
                if(service == "Agua"){
                    buttonColor(label: waterServiceLabel, isOn: true)
                }
            }
        }
        
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
