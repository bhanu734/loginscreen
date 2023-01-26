//
//  HomeViewController.swift
//  Loginscreen
//
//  Created by Mac on 12/09/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var LogoutButton : UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var Label1: UILabel!
    
    var email : String = ""
    var password : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcome()
        emailTextfield.text = email
        passwordTextfield.text = password
       
    }
    
    func welcome(){
        if let name = UserDefaults.standard.value(forKeyPath: "email") as? String {
            Label1.text = ("welcome" + name )
        }
    }
    
    
    
    func fetchAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let persitanceContainer = appDelegate.persistentContainer
        let context = persitanceContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let users = try context.fetch(fetchRequest)
            print(users)
        }catch {
            
        }
    }

    
    @IBAction func Updatedetails(){
        if let emailText = emailTextfield.text, let passwordtext = passwordTextfield.text {
            if email != emailText || password != passwordtext {
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                let persitanceContainer = appDelegate.persistentContainer
                let context = persitanceContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
                fetchRequest.returnsObjectsAsFaults = false
                fetchRequest.predicate = NSPredicate(format: "email == %@", email) //ram1
                
                do {
                    let users = try context.fetch(fetchRequest)
                    if users.count > 0 {
                        if let user = users[0] as? Data {
                            user.email = emailText//setValue(emailText, forKey: "email")
                            user.password = passwordtext//setValue(passwordtext, forKey: "password")
                        }
                    }
                }catch {
                    print(error.localizedDescription)
                }
                do {
                    try context.save()
                    email = emailTextfield.text ?? ""
                }catch {
                    print(error.localizedDescription)
                }
            }else {
                print("update is not required")
            }
        }
        fetchAllData()
    }
    
    @IBAction func LogoutButtonTapped(){
        
        UserDefaults.standard.setValue(nil, forKey: "email")
        
        navigationController?.popViewController(animated: true)
        
//        let jumpto = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
//        navigationController?.pushViewController(jumpto , animated: true)
    }
  

}
