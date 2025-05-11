//
//  DescriptionVC.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 10/05/2025.
//

import UIKit

class DescriptionVC: UIViewController {

    @IBOutlet weak var MealImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    var image: String?
    var name: String?
    var category: String?
    var country: String?
    var Instructions: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageUrlString = image, let url = URL(string: imageUrlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.MealImage.image = image
                    }
                }
            }.resume()
        }
        nameLabel.text = name
        categoryLabel.text = category
        countryLabel.text = "From: \(country ?? "")"
        desLabel.text = Instructions
    }
    
  

}
