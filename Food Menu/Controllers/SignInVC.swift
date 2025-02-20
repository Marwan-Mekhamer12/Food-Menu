//
//  SignInVC.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit
import FirebaseAuth


// https://food-menu-3450a.firebaseapp.com/__/auth/handler

class SignInVC: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LogIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LogIn.layer.cornerRadius = 18
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
    }
    
    @IBAction func LogInPressed(_ sender: UIButton) {
        if let email = EmailTextField.text, !email.isEmpty,
           let password = PasswordTextField.text, !password.isEmpty,
           password.count >= 6{
            
            Auth.auth().signIn(withEmail: email, password: password) { Authresult ,error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }else{
                    print("Succesfull LogIn: \(Authresult?.user.email ?? "")")
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "first") as? Home{
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                }
            }
        }
    }
    
    
}

//Mark: - TextField

extension SignInVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == EmailTextField{
            PasswordTextField.becomeFirstResponder()
            return true
        }else{
            view.endEditing(true)
            return false
        }
    }
}
