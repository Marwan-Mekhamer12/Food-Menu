//
//  ViewController.swift
//  Food Menu
//
//  Created by Marwan Mekhamer on 19/10/2024.
//

import UIKit

class Home: UIViewController, UITableViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    var arrData = [Meal]()
    var manager = MenuBrain()
    var timer: Timer?
    var currentIndex = 0 // to scroll view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        timees()
            
            manager.fetchRequest { posts in
                DispatchQueue.main.async {
                    self.arrData = posts
                    self.pageView.numberOfPages = self.arrData.count
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
    }
    
    // Move image by imdex
    func timees() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveTo), userInfo: nil, repeats: true)
    }
    @objc func moveTo() {
       
        if currentIndex < arrData.count - 1 {
            currentIndex += 1
            
        }else {
            currentIndex = 0
        }
        pageView.currentPage = currentIndex
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "numberthree") as? DescriptionNumberthree {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}

extension Home: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scrollcell", for: indexPath) as? scrollhomeCell
        let meal = arrData[indexPath.row]
        cell?.setup(with: meal)
        return cell!
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout
//        collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 160, height: 160)
//    }
    
}


extension Home: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "imagecell") as? HomeTableViewCell {
            let meal = arrData[indexPath.row]
            cell.setUp(with: meal)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let meal = arrData[indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "second") as? DescriptionVC {
            vc.title = "Meal View"
            vc.image = meal.strMealThumb
            vc.name = meal.strMeal
            vc.country = meal.strArea
            vc.category = meal.strCategory
            vc.Instructions = meal.strInstructions
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
