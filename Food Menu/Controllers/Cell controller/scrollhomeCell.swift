//
//  scrollhomeCell.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 07/05/2025.
//

import UIKit

class scrollhomeCell: UICollectionViewCell {
    
    @IBOutlet weak var photoscroll: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoscroll.contentMode = .scaleAspectFill
        photoscroll.clipsToBounds = true
    }

    
    func setup(with meal: Meal) {
        
        guard let url = URL(string: meal.strMealThumb) else {
            photoscroll.image = UIImage(systemName: "trash")
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.photoscroll.image = image
                }
            }
        }.resume()
    }
}
