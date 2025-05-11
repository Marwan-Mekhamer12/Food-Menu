//
//  HomeTableViewCell.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 10/05/2025.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var mealimage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealCountry: UILabel!
    @IBOutlet weak var mealDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(with meal: Meal) {
        if let urlImage = URL(string: meal.strMealThumb) {
            URLSession.shared.dataTask(with: urlImage) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mealimage.image = image
                    }
                }
            }.resume()
        }
        mealName.text = meal.strMeal  // name
        mealCountry.text = "From: \(meal.strArea)"  // country
        mealDescription.text = meal.strInstructions  // description
        
    }

}
