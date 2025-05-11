//
//  SignInVC.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore


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
    
    // LogIn with Google
    
    @IBAction func LogInWithGoogle(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

           // Set the config
           GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

           // Present the sign-in view
           GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
               if let error = error {
                   print("Google Sign-In error: \(error.localizedDescription)")
                   return
               }

               guard let signInResult = signInResult else {
                   print("No sign-in result returned")
                   return
               }

               let user = signInResult.user

               user.refreshTokensIfNeeded { auth, error in
                   if let error = error {
                       print("Authentication error: \(error.localizedDescription)")
                       return
                   }

                   guard let auth = auth else {
                       print("Authentication object is nil")
                       return
                   }

                   let credential = GoogleAuthProvider.credential(
                    withIDToken: (auth.idToken?.tokenString)!,
                       accessToken: auth.accessToken.tokenString
                   )

                   Auth.auth().signIn(with: credential) { authResult, error in
                       if let error = error {
                           print("Firebase sign-in error: \(error.localizedDescription)")
                       } else {
                           print("✅ Signed in as: \(authResult?.user.email ?? "unknown")")
                           // Navigate or update UI here
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

