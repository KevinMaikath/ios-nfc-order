//
//  ProductDetailViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit
import Toast_Swift

class ProductDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var shoppingCart: ShoppingCartRepository?
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shoppingCart = ShoppingCartRepository.getInstance()
        productPrice.text = "$\(product!.price ?? 0)"
        productImage.downloadImage(from: URL(string: product!.imgUrl)!)
        navBar.title = product!.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.product?.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ingredientCell")
        
        cell.textLabel?.text = product?.ingredients[indexPath.row]
        return cell
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        self.shoppingCart?.addOneToCart(self.product!)
        self.view.makeToast("\(self.product!.name ?? "") added to the cart!", duration: 1.0)
    }
}
