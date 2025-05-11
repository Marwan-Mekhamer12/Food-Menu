//
//  MenuBrain.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 07/05/2025.
//

import Foundation

struct MenuBrain {
    
    func fetchRequest(_ Completion: @escaping (([Meal]) -> Void)) {
        
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=chicken") {
            let urlsesson = URLSession(configuration: .default)
            let task = urlsesson.dataTask(with: url) { data, respone, error in
                if error != nil{
                    print("❌ error: \(error?.localizedDescription ?? "")")
                }
                
                if let safeData = data {
                perform(safeData, Completion: Completion)
                }
            }
            
            task.resume()
        }
    }
    
    func perform(_ data: Data, Completion: (([Meal]) -> Void)) {
        let JsonDecoder = JSONDecoder()
        do {
            let decoder = try JsonDecoder.decode(MenuDetails.self, from: data)
            Completion(decoder.meals)
        }catch {
            print("❌ error: \(error.localizedDescription)")
        }
    }
}
