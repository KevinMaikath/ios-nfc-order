//
//  CategoryViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit
import Toast_Swift

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    var buttonTappedAction: (() -> ())?
    
    @IBAction func productButtonTapped(_ sender: UIButton) {
        buttonTappedAction?()
    }
    
}

class CategoryViewController: UITableViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    
    let model: CategoryModel = CategoryModel()
    var shoppingCart: ShoppingCartRepository?
    var category: Category?
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shoppingCart = ShoppingCartRepository.getInstance()
        model.loadProductList(fromCategory: category!) {
            self.tableView.reloadData()
        }
        navBar.title = category?.name
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return model.getProductListCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        
        let product = model.productList![indexPath.row]
        cell.productName.text = product.name
        cell.productImage.downloadImage(from: URL(string: product.imgUrl)!)
        
        cell.buttonTappedAction = { [unowned self] in
            self.buttonTapped(indexPath)
        }
        
        return cell
    }
    
    func buttonTapped(_ indexPath: IndexPath) {
        let product = model.productList![indexPath.row]
        self.shoppingCart?.addOneToCart(product)
        self.view.makeToast("\(product.name ?? "") added to the cart!", duration: 1.0, position: .center)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = model.productList?[indexPath.row]
        
        performSegue(withIdentifier: "categoryToProductDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToProductDetailSegue" {
            let productDetailView = segue.destination as! ProductDetailViewController
            productDetailView.product = selectedProduct
            

        }
    }

}
