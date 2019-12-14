//
//  ShoppingCartViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class ShopItemCell: UITableViewCell {
    
    
    @IBOutlet weak var shopItemName: UILabel!
    @IBOutlet weak var shopItemQuantity: UILabel!
    
    var addButtonAction: (() -> ())?
    var removeButtonAction: (() -> ())?
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonAction?()
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        removeButtonAction?()
    }
    
}


class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var model: ShoppingCartModel = ShoppingCartModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.totalPriceLabel.text = "$\(model.totalPrice ?? 0)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getCartListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopItemCell", for: indexPath) as! ShopItemCell
        
        let shopItem = model.cartList?[indexPath.row]
        cell.shopItemName.text = shopItem!.name
        cell.shopItemQuantity.text = "\(shopItem!.quantity ?? 0)"
        cell.addButtonAction = { [unowned self] in
            self.addButtonTapped(indexPath)
        }
        cell.removeButtonAction = { [unowned self] in
            self.removeButtonTapped(indexPath)
        }
    
        return cell
    }
    
    private func addButtonTapped(_ indexPath: IndexPath) {
        self.model.addOneToCart(indexPath.row)
        self.refresh()
    }
    
    private func removeButtonTapped(_ indexPath: IndexPath) {
        self.model.removeOneFromCart(indexPath.row)
        self.refresh()
    }
    
    private func refresh() {
        self.tableView.reloadData()
        self.totalPriceLabel.text = "$\(model.totalPrice ?? 0)"
    }

}
