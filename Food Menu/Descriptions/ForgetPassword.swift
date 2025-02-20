//
//  ForgetPassword.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit

class ForgetPassword: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var textfieldText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        send.layer.cornerRadius = 18
        textfieldText.layer.cornerRadius = 18
        textfieldText.becomeFirstResponder()
        textfieldText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil{
            view.endEditing(true)
            textfieldText.text = ""
            return true
        }else{
            return false
        }
    }
    
    @IBAction func SendPress(_ sender: UIButton) {
        textfieldText.text = ""
    }
    


}
