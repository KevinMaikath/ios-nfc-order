//
//  CatalogViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 13/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
}

class CatalogViewController: UITableViewController {
    
    let model: CatalogModel = CatalogModel()
    var selectedCategory: Category?

    override func viewDidLoad() {
        super.viewDidLoad()

        model.loadCategories {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.getCategoriesCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        let category = model.categories![indexPath.row]
        cell.categoryImage.downloadImage(from: URL(string: category.imgUrl)!)
        cell.categoryName.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = model.categories?[indexPath.row]
        
        performSegue(withIdentifier: "catalogToCategorySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catalogToCategorySegue" {
            let categoryView = segue.destination as! CategoryViewController
            categoryView.category = selectedCategory
            

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

}
