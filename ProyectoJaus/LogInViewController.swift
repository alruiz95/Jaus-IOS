//
//  LogInViewController.swift
//  ProyectoJaus
//
//  Created by Estudiante on 9/27/16.
//  Copyright © 2016 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    var login : Bool = false
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loginButtom: UIButton!
    @IBOutlet weak var signUpButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background.png")!)
        loginButtom.backgroundColor = UIColor.clear
        loginButtom.layer.cornerRadius = 5
        loginButtom.layer.borderWidth = 1
        loginButtom.layer.borderColor = UIColor.white.cgColor
        
        signUpButtom.backgroundColor = UIColor.clear
        signUpButtom.layer.cornerRadius = 5
        signUpButtom.layer.borderWidth = 1
        signUpButtom.layer.borderColor = UIColor.white.cgColor
        
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func addImagetoTextField() ->Void {
        
        /*usernameTextField.leftViewMode = UITextFieldViewMode.Always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "../emailAdressIcon.png")
        imageView.image = image
        usernameTextField.leftView = imageView*/
        
        email.leftViewMode = .always
        let emailImgContainer = UIView(frame: CGRect(x: email.frame.origin.x, y: email.frame.origin.y, width: 40.0, height: 30.0))
        let emailImView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25.0, height: 25.0))
        emailImView.image = UIImage(named: "emailAdressIcon.png")
        emailImView.center = emailImgContainer.center
        emailImgContainer.addSubview(emailImView)
        email.leftView = emailImgContainer
     
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    @IBAction func loginAction(_ sender: AnyObject) {
        var algunError:Bool = false
        email.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
        
        if ((passwordTextField.text?.isEmpty)! || passwordTextField.text == "Password")
        {
            passwordTextField.layer.cornerRadius = 8.0
            passwordTextField.layer.masksToBounds = true
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide a password"
        }
        if ((email.text?.isEmpty)! || email.text == "Username")
        {
            email.layer.cornerRadius = 8.0
            email.layer.masksToBounds = true
            email.layer.borderColor = UIColor.red.cgColor
            email.layer.borderWidth = 2.0
            algunError = true
            errorLabel.text = "You need to provide an Username"
        }
        if algunError{
            
            return
        }
        
        
        
        let urlPath : String! = CONSTANTS.BASE_URL + "/login?username="+email.text!
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        var pass : String = ""
        
        let task = session.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                print("======>>>"+error!.localizedDescription)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if statusCode == CONSTANTS.STATUS_OK {
                
                DispatchQueue.main.async{
                    pass = JSON.pasrseContra(data!)
                    print("=====>>> "+pass)
                    if self.passwordTextField.text == pass {
                        CONSTANTS.currentUser = self.email.text!
                        
                        self.performSegue(withIdentifier: "GoToViewController", sender:self)
                        
                        
                    }
                }
            }
            
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
