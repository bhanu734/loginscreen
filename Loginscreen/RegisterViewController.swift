//
//  RegisterViewController.swift
//  Loginscreen
//
//  Created by Mac on 12/09/22.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
        @IBOutlet weak var emailTextfield: UITextField!
        @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func savincoredata(){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
        else {return}
        
        let persistentContainer = appdelegate.persistentContainer
        
        let context = persistentContainer.viewContext
        
       guard let entitydescription = NSEntityDescription.entity(forEntityName: "Data", in: context)
       else {return}
        let user = Data(entity: entitydescription, insertInto: context)
        user.email = emailTextfield.text
        user.password = passwordTextfield.text
        
        try? context.save()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidpassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    func showalert(title: String , message: String){
        let alertcontroller = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertcontroller.addAction(cancelButton)
        present(alertcontroller, animated: true, completion: nil)
    }
    
     func checkusers () -> Bool {
        if let email = emailTextfield.text ,let password = passwordTextfield.text {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
                    else{return false}
        let persistentContainer = appdelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
            fetchrequest.returnsObjectsAsFaults = false
            fetchrequest.predicate = NSPredicate(format: " email == %@ ", email)
            //fetchrequest.predicate = NSPredicate(format: " password == %@ ", password)
            
            do{
                let users = try context.fetch(fetchrequest)
                print(users)
                
                if  users.count > 0{
                    return true
                }else{
                    return false
                }
                
            }
            catch{
                
            }
                
    }
        return false
    }
   
    
    func fetchallusers (){
       if let email = emailTextfield.text ,let password = passwordTextfield.text {
       guard let appdelegate = UIApplication.shared.delegate as? AppDelegate
                   else{return}
       let persistentContainer = appdelegate.persistentContainer
       let context = persistentContainer.viewContext
       
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
    
        fetchrequest.returnsObjectsAsFaults = false
        
        
        
        do{
            let users = try context.fetch(fetchrequest) as? [Data]
            print(users)
            
            
        }
        catch{
            print (error.localizedDescription)
        }
    
       }
    }
    
    @IBAction func LoginTapped(){
        
        
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
                            navigationController?.pushViewController(controller, animated: true)
        
        }
        @IBAction func RegisterTapped(){
            
            //if let email = emailTextfield.text ,let password = passwordTextfield.text{
//            savincoredata(email: email  , password: password)
//            fetchallusers()
            let userexist = checkusers()
            if userexist{
                
                showalert(title: "already registered", message: "Login with your Credentials")
            }
            else{
                savincoredata()
            }
            
            
            }
//            if let email = emailTextfield.text ,let password = passwordTextfield.text {
//                if isValidEmail(email){
//
//                if isValidpassword(password){
//
//                    savincoredata(email: email  , password: password)
//                    fetchusers()
//                    showalert(title: "Registered Sucessfully", message: "Login with your Credentials")
//
//                    } else{
//                        print("invallid password")
//
//                        showalert(title: "Error", message: "Type password")}
//                }else {
//                       print("invallid emaild")
//                    showalert(title: "Error", message: "Enter valid email")
//
//                     }
//
//                   }
//                }
         
            }





//print("Enter password")
// showalert(title: "Error", message: "Type password")
