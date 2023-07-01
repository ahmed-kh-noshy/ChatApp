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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func signupButton(_ sender: UIButton) {
        print("presed")
        if checkPassword() {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil{
                    print("registerd")
                }else{
                    print(error as Any)
                }
            }
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func checkPassword() -> Bool {
        if (passwordTextField.text!) != (rePasswordTextField.text!){
            errorMassage.text = "*not matching retype password"
            return false
        }else{
            password = passwordTextField.text!
            return true
        }
    }
    
    
}

