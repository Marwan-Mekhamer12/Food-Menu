//
//  DescriptionNumbertwo.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit

class DescriptionNumbertwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func MoveToNext(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "numberthree") as? DescriptionNumberthree{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}
