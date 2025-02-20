//
//  RegisterVC.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    
    @IBOutlet weak var CheckagreeButton: UIButton!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passworfTextfield: UITextField!
    @IBOutlet weak var logIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CheckagreeButton.layer.cornerRadius = CheckagreeButton.bounds.width/2
        CheckagreeButton.clipsToBounds = true
        logIn.layer.cornerRadius = 18
        usernameTextfield.delegate = self
        emailTextfield.delegate = self
        passworfTextfield.delegate = self
        
    }
    @IBAction func checkedButtonPress(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected{
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
        }
        
    }
    
    // Firebase Check
    
    @IBAction func LogInPressed(_ sender: UIButton) {
        
        // firebase Register
        
        if let email = emailTextfield.text, !email.isEmpty,
           let password = passworfTextfield.text, !password.isEmpty,
           password.count >= 6{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    // error handler
                    print(error.localizedDescription)
                }else{
                    // seccsfull
                    print("User Request = \(authResult?.user.email ?? "")")
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "first") as? Home{
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true)
                    }
                }
            }
        }
    }
    
}

//Mark: -> UITextfield Delegate

extension RegisterVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextfield{
            emailTextfield.becomeFirstResponder()
        }else if textField == emailTextfield{
            passworfTextfield.becomeFirstResponder()
            view.endEditing(true)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
