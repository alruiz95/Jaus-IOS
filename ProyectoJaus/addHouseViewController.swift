//
//  addHouseViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 10/6/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit
import Foundation


class addHouseViewController: UIViewController {

    @IBOutlet weak var houseNameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var waterServiceButtom: UIButton!
    @IBOutlet weak var createHouseButtom: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var houseOrAppartment: UISegmentedControl!
    @IBOutlet weak var saleOrRent: UISegmentedControl!
    
    @IBOutlet weak var waterServiceButton: UIButton!
    @IBOutlet weak var internetServiceButton: UIButton!
    @IBOutlet weak var lightServiceButton: UIButton!
    @IBOutlet weak var cableServiceButton: UIButton!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var switchUISwitch: UISwitch!
    
    
    var type : String = "Sale"
    var isNegotiable : Int = 0
    var water: Bool = false
    var light: Bool = false
    var internet: Bool = false
    var cable: Bool = false
    
    var services: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agregaIcono(textField: houseNameTextField, image: "home.png")
        agregaIcono(textField: address1TextField, image: "address.png")
        agregaIcono(textField: address2TextField, image: "address.png")
        agregaIcono(textField: phoneTextField, image: "phone.png")
        agregaIcono(textField: priceTextField, image: "price.png")
        createHouseButtom.backgroundColor = UIColor.clear
        createHouseButtom.layer.cornerRadius = 5
        createHouseButtom.layer.borderWidth = 1
        createHouseButtom.layer.borderColor = UIColor.blue.cgColor
      
        buttonColor(button: waterServiceButtom,isOn: false)
        buttonColor(button: internetServiceButton,isOn: false)
        buttonColor(button: lightServiceButton,isOn: false)
        buttonColor(button: cableServiceButton,isOn: false)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonColor(button: UIButton, isOn: Bool) ->Void{
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        
        if(isOn == false){
           button.layer.borderColor = UIColor.red.cgColor
        }else{
           button.layer.borderColor = UIColor.green.cgColor
        }
        
        
    }
    
    func agregaIcono(textField: UITextField, image : String) -> Void{
        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: image)
        imageView.image = image
        textField.leftView = imageView
    }
    
    func searchService(idService: Int){
        for i in 0...services.count-1{
            if(services[i] ==  idService){
                services.remove(at: i)
            }
        }
    }
    
    @IBAction func houseType(_ sender: AnyObject) {
        if (saleOrRent.selectedSegmentIndex == 0){
            self.type = "Sale"
        }
        else{
            self.type = "Rental"
        }
        
    }
    
    @IBAction func waterServiceOn(_ sender: AnyObject) {
        if(water == false){
            water = true
            services.append(2)
            
        }
        else{
            water = false
            searchService(idService: 2)
        }
        buttonColor(button: waterServiceButtom, isOn: water)
    }
    @IBAction func internetServiceOn(_ sender: AnyObject) {
        if(internet == false){
            internet = true
            services.append(4)
            
        }
        else{
            internet = false
            searchService(idService: 4)
        }
        buttonColor(button: internetServiceButton, isOn: internet)
    }
    
    @IBAction func lightServiceOn(_ sender: AnyObject) {
        if(light == false){
            light = true
            services.append(3)
            
        }
        else{
            light = false
            searchService(idService: 3)
        }
        buttonColor(button: lightServiceButton, isOn: light)
    }
    
    @IBAction func cableServiceOn(_ sender: AnyObject) {
        if(cable == false){
            cable = true
            services.append(5)
            
        }
        else{
            cable = false
            searchService(idService: 5)
        }
        buttonColor(button: cableServiceButton, isOn: cable)
    }
    
    
    
    
    @IBAction func isNegotiableChage(_ sender: AnyObject) {
        if (self.isNegotiable == 0){
            self.isNegotiable = 1
        }else{
            self.isNegotiable = 0
        }
    
    }
    
    @IBAction func addNewHouse(_ sender: AnyObject) {
        var algunError:Bool = false
        houseNameTextField.layer.borderWidth = 0
        address1TextField.layer.borderWidth = 0
        address2TextField.layer.borderWidth = 0
        phoneTextField.layer.borderWidth = 0
        priceTextField.layer.borderWidth = 0
        errorLabel.text=""
        
        if ((houseNameTextField.text?.isEmpty)! || houseNameTextField.text == "House Name")
        {
            houseNameTextField.layer.cornerRadius = 8.0
            houseNameTextField.layer.masksToBounds = true
            houseNameTextField.layer.borderColor = UIColor.red.cgColor
            houseNameTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a name"
        }
        if ((address1TextField.text?.isEmpty)! || address1TextField.text == "Address 1")
        {
            address1TextField.layer.cornerRadius = 8.0
            address1TextField.layer.masksToBounds = true
            address1TextField.layer.borderColor = UIColor.red.cgColor
            address1TextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide an address"
        }
        if ((address2TextField.text?.isEmpty)! || address2TextField.text == "Address 2")
        {
            address2TextField.layer.cornerRadius = 8.0
            address2TextField.layer.masksToBounds = true
            address2TextField.layer.borderColor = UIColor.red.cgColor
            address2TextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to specify your address"
        }
        if ((phoneTextField.text?.isEmpty)! || phoneTextField.text == "Phone Number")
        {
            phoneTextField.layer.cornerRadius = 8.0
            phoneTextField.layer.masksToBounds = true
            phoneTextField.layer.borderColor = UIColor.red.cgColor
            phoneTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a phone number"
        }
        if ((priceTextField.text?.isEmpty)! || priceTextField.text == "price")
        {
            priceTextField.layer.cornerRadius = 8.0
            priceTextField.layer.masksToBounds = true
            priceTextField.layer.borderColor = UIColor.red.cgColor
            priceTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a cost"
        }
        if ((descriptionTextField.text?.isEmpty)! || priceTextField.text == "Description")
        {
            descriptionTextField.layer.cornerRadius = 8.0
            descriptionTextField.layer.masksToBounds = true
            descriptionTextField.layer.borderColor = UIColor.red.cgColor
            descriptionTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a description"
        }
        
        if (algunError){
            return
        }
        
        var urlPath : String = CONSTANTS.BASE_URL
        
        if saleOrRent.selectedSegmentIndex == 0 {
            urlPath+="/house_for_sale/new?h_provider_username="+CONSTANTS.currentUser
            urlPath+="&h_name="+self.houseNameTextField.text!
            urlPath+="&h_address="+address1TextField.text!+address2TextField.text!
            urlPath+="&h_details="+self.descriptionTextField.text!
            urlPath+="tec&h_price="+self.priceTextField.text!
            urlPath+="&h_photo=null&h_isNegotiable="+String(isNegotiable)
            urlPath+="&h_latitude=-22.1&h_longitude=151.3"
            
        }else{
            urlPath+="/house_rental/new?h_provider_username="+CONSTANTS.currentUser
            urlPath+="&h_name="+self.houseNameTextField.text!
            urlPath+="&h_address="+address1TextField.text!+address2TextField.text!
            urlPath+="&h_details="+self.descriptionTextField.text!
            urlPath+="tec&h_price="+self.priceTextField.text!
            urlPath+="&h_photo=null&h_isNegotiable="+String(isNegotiable)
            urlPath+="&h_latitude=-22.1&h_longitude=151.3"
            
            if (services.count > 0){
                urlPath+="&array_servicesID="
                for i in 0...services.count-1{
                    if ( i == (services.count-1)){
                        urlPath+=String(services[1])
                    }else{
                        urlPath+=String(services[1])+","
                    }
                }
            }
            
        }
        
        print("===>>>  "+urlPath)
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
                self.navigationController?.popViewController(animated: true)
            }
            
            print("======>>>"+statusCode.description)
        })
        
        task.resume()
        
    
    }
    
    
    
    @IBAction func searchImage(_ sender: AnyObject){
      
    
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
