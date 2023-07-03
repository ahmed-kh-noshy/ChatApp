//
//  LoginViewController.swift
//  ChatApp
//
//  Created by ahmed khaled on 01/07/2023.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

   
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            
            if error == nil{
                print("login")
                self?.performSegue(withIdentifier: "login", sender: self)
            }else{
                self!.errorMessage.text = error!.localizedDescription
            }
          
        }
        
    }
    
    
    @IBAction func goToSignupButton(_ sender: UIButton) {
        let newController = self.storyboard!.instantiateViewController(withIdentifier: "signup")
        //the identifier above comes from storyboard
        self.navigationController!.pushViewController(newController, animated : true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    

    
}
