//
//  ProfileViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 10/11/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var maleOrFemale: UISegmentedControl!
    
    var datos : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    agregaIcono(textField: nameTextField, image: "usernameIcon.png")
    agregaIcono(textField: passwordTextField, image: "passwordIcon.png")
    agregaIcono(textField: mailTextField, image:"emailAdressIcon.png")
    agregaIcono(textField: phoneTextField, image: "phone.png")
        // Do any additional setup after loading the view.
        //self.navigationController?.navigationItem.setRightBarButtonItems(navIteamProfile.rightBarButtonItems, animated: true)
        
        let urlPath : String! = CONSTANTS.BASE_URL + "/get_user?username=" + CONSTANTS.currentUser
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("======>>>"+error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == CONSTANTS.STATUS_OK{
                self.datos = JSON.parseUpUser(data!)
                
                if self.datos[0] != "null"{
                    self.passwordTextField.text = self.datos[0]
                }
                if self.datos[1] != "null"{
                    self.nameTextField.text = self.datos[1]
                }
                if self.datos[2] != "null"{
                    self.lastTextField.text = self.datos[2]
                }
                if self.datos[3] != "null"{
                    self.phoneTextField.text = self.datos[3]
                }
                if self.datos[4] != "null"{
                    self.mailTextField.text = self.datos[4]
                }
                if self.datos[5] != "null"{
                    if self.datos[5] == "M"{
                        self.maleOrFemale.selectedSegmentIndex = 0
                    }else{
                        self.maleOrFemale.selectedSegmentIndex = 1
                    }
                }
                
                
            }
            print("======>>>"+statusCode.description)
        })
        
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func agregaIcono(textField: UITextField, image : String) -> Void{
        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: image)
        imageView.image = image
        textField.leftView = imageView
    }
    
    @IBAction func modifyAction(_ sender: AnyObject) {
        var fema:String = "F"
        
        if(maleOrFemale.selectedSegmentIndex == 0){
            fema = "M"
        }
        else{
            fema = "F"
        }
        
        var urlPath : String = CONSTANTS.BASE_URL + "/update_user?username="
        urlPath+=CONSTANTS.currentUser
        urlPath+="&password="+String (passwordTextField.text!)
        urlPath+="&name="+nameTextField.text!
        urlPath+="&lastname="+lastTextField.text!
        urlPath+="&phoneNumber="+phoneTextField.text!
        urlPath+="&email="+mailTextField.text!
        urlPath+="&gender="+fema+"&photo=null"
        
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
