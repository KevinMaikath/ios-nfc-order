//
//  CatalogViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 13/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) {
            data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
}

class CatalogViewController: UITableViewController {
    
    let model: CatalogModel = CatalogModel()

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
        //cell.categoryImage.image = UIImage()
        cell.categoryName.text = category.name
        
        return cell
    }

}
