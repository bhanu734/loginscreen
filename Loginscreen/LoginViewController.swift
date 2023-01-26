//
//  LoginViewController.swift
//  Loginscreen
//
//  Created by Mac on 12/09/22.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
        @IBOutlet weak var emailTextfield: UITextField!
        @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ = UserDefaults.standard.value(forKey: "mail") as? String {
        
            let controller = UIStoryboard(name: "main", bundle: nil).instantiateViewController(identifier: "HomeViewController")
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    func checkusers () -> Bool {
        if let email = emailTextfield.text, let password = passwordTextfield.text  {
       guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
                   else{return false}
       let persistentContainer = appdelegate.persistentContainer
       let context = persistentContainer.viewContext
       
       let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
           fetchrequest.returnsObjectsAsFaults = false
           fetchrequest.predicate = NSPredicate(format: " email == %@ ", email)
           
           
           do{
               let users = try context.fetch(fetchrequest)
               print(users)
               
            if users.count > 0 {
                let user = users[0] as! Data
                let password = user.password
                if password == passwordTextfield.text{
                UserDefaults.standard.setValue(email, forKey: "email")
                   return true
                }
                
              else{return false}
            
                }
            
           }
           catch{
            print(error.localizedDescription)
           }
               
   }
       return false
   }
    
    
    func showalert(title: String , message: String){
        let alertcontroller = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertcontroller.addAction(cancelButton)
        present(alertcontroller, animated: true, completion: nil)
    }

    @IBAction func LoginTapped(){
        
        
        let userdata = checkusers()
        if userdata{
            print("login done")
            
            if let controller1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
                controller1.email = emailTextfield.text ?? ""
                controller1.password = passwordTextfield.text ?? ""
            
                navigationController?.pushViewController(controller1, animated: true)
                
            }
            
            // showalert(title: "Thank you ", message: "enjoy your time")
        }else{
            showalert(title: "invalid", message: "check username password")
            print("invallid")
        }
        
       
        
        }
        @IBAction func RegisterTapped(){

            let RegTapped = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController")
            navigationController?.pushViewController(RegTapped, animated: true)
}
}
