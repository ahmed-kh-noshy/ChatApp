//
//  ChatViewController.swift
//  ChatApp
//
//  Created by ahmed khaled on 02/07/2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class ChatViewController: UIViewController {

    var messageArray = [Message]()
    let db = Firestore.firestore()
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func sendMessageButton(_ sender: UIButton) {
       
        let message = Message(sender: Auth.auth().currentUser?.email , messageBody:messageTextField.text)
        saveMessages(message)
        messageTextField.text = nil
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
        messageTextField.delegate = self
        self.messageTableView.separatorStyle = .none
        messageTableView.register(UINib(nibName: "SenderTableViewCell", bundle: nil), forCellReuseIdentifier: "senderCell")
        messageTableView.register(UINib(nibName: "ReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: "receiverCell")
        getMessages()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    

    

}
extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messageArray[indexPath.row].sender == Auth.auth().currentUser!.email{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! SenderTableViewCell
            cell.lable.text = messageArray[indexPath.row].messageBody
            
            return cell
        }else{
            let cell = messageTableView.dequeueReusableCell(withIdentifier: "receiverCell", for: indexPath) as! ReceiverTableViewCell
            cell.lable.text = messageArray[indexPath.row].messageBody
            
            return cell
        }
        
        
    }
    
    func saveMessages(_ message: Message){
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db.collection("messages").addDocument(data: [
            "messageBody": message.messageBody!,
            "sender": message.sender!,
            "time": Date().timeIntervalSince1970
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    func getMessages(){
        db.collection("messages").whereField("sender", isEqualTo:Auth.auth().currentUser!.email! ).order(by:"time")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.messageArray.removeAll()
                for doc in documents{
                    let msgsBody = doc.data()["messageBody"] as! String
                    let msgsSender = Auth.auth().currentUser?.email

                    let msgs = Message(sender: msgsSender, messageBody: msgsBody)
                    self.messageArray.append(msgs)
                    self.messageTableView.reloadData()
                }
                
                let indexPath = IndexPath(row: self.messageArray.count - 1, section: 0)
                if indexPath.row > 5 {
                    self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
                
            }
    }
}

extension ChatViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        let message = Message(sender: Auth.auth().currentUser?.email , messageBody:messageTextField.text)
        saveMessages(message)
        messageTextField.text = nil
        messageTableView.reloadData()
        return true

    }
}
