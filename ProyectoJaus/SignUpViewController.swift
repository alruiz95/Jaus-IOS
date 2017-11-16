//
//  SignUpViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 10/2/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var passWord2TextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        SignUpButton.backgroundColor = UIColor.clear
        SignUpButton.layer.cornerRadius = 5
        SignUpButton.layer.borderWidth = 1
        SignUpButton.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func signUp(_ sender: AnyObject) {
        var algunError:Bool = false
        emailTextField.layer.borderWidth = 0
        passWordTextField.layer.borderWidth = 0
        passWord2TextField.layer.borderWidth = 0
        errorLabel.text = ""
        
        if ((passWord2TextField.text?.isEmpty)! || passWord2TextField.text == "Confirm Password")
        {
            passWord2TextField.layer.cornerRadius = 8.0
            passWord2TextField.layer.masksToBounds = true
            passWord2TextField.layer.borderColor = UIColor.red.cgColor
            passWord2TextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide the confirmation password"
        }
        if ((passWordTextField.text?.isEmpty)! || passWordTextField.text == "Password")
        {
            passWordTextField.layer.cornerRadius = 8.0
            passWordTextField.layer.masksToBounds = true
            passWordTextField.layer.borderColor = UIColor.red.cgColor
            passWordTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a password"
        }
        if ((emailTextField.text?.isEmpty)! || emailTextField.text == "Username")
        {
            emailTextField.layer.cornerRadius = 8.0
            emailTextField.layer.masksToBounds = true
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide an Username"
        }
        
        if((passWordTextField.text != passWord2TextField.text) && (algunError == false)){
            passWord2TextField.layer.cornerRadius = 8.0
            passWord2TextField.layer.masksToBounds = true
            passWord2TextField.layer.borderColor = UIColor.red.cgColor
            passWord2TextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "The passwords doesn't match"
            
        }
        if algunError{
            return
        }
        
        
        let urlPath : String! = CONSTANTS.BASE_URL + "/user/new?username="+emailTextField.text!+"&password="+passWordTextField.text!
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
