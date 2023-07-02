//
//  SignupViewController.swift
//  ChatApp
//
//  Created by ahmed khaled on 01/07/2023.
//

import UIKit
import Firebase
class SignupViewController: UIViewController {
    
    var email: String = ""
    var password: String = ""
    @IBOutlet weak var errorMassage: UILabel!
    @IBOutlet weak var signupErrorMessage: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func signupButton(_ sender: UIButton) {
        email = emailTextField.text!
        if checkPassword() {
            reSetMessage()
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error == nil{
                    print("user is registerd")
                    self.performSegue(withIdentifier: "goLogin", sender: self)
                }else{
                    print(error!.localizedDescription)
                    self.signupErrorMessage.text = error!.localizedDescription
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func checkPassword() -> Bool {
        if (passwordTextField.text) != (rePasswordTextField.text){
            errorMassage.text = "*not matching retype password"
            return false
        }else{
            if passwordTextField.text!.count <= 5{
                errorMassage.text = "password must be aat least 6 charcters"
                return false
            }else{
                password = passwordTextField.text!
                return true
            }
        }
    }
    

    
    func reSetMessage() {
        errorMassage.text = ""
    }
    
    
}



