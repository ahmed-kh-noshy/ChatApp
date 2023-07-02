//
//  ChatViewController.swift
//  ChatApp
//
//  Created by ahmed khaled on 02/07/2023.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {

    var messageArray = ["hi"]
    
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func sendMessageButton(_ sender: UIButton) {
        messageArray.append(messageTextField.text!)
        messageTextField.text = ""
        messageTableView.reloadData()
        
    }
    
    
    
    
    
    
    @IBAction func logotButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.dataSource = self

        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    

    

}
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = messageTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = messageArray[indexPath.row]
        
        return cell
        
    }
    
    
}
