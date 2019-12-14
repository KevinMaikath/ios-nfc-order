//
//  ShoppingCartRepository.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class ShoppingCartRepository {

    private static var INSTANCE: ShoppingCartRepository?
    private var cartList: [ShopItem]?
    
    init(){
        self.cartList = []
    }
    
    public static func getInstance() -> ShoppingCartRepository{
        if INSTANCE == nil {
            INSTANCE = ShoppingCartRepository()
        }
        return INSTANCE!
    }
    
    func addOneToCart(_ product: Product){
        let index = self.cartList?.firstIndex(where: { (item) -> Bool in
            return item.name == product.name
        })
        guard let ind = index else {
            self.addProductToCart(product)
            return
        }
        self.cartList?[ind].quantity += 1
    }
    
    func removeOneFromCart(_ product: Product){
        let index = self.cartList?.firstIndex(where: { (item) -> Bool in
            return item.name == product.name
        })
        guard let ind = index else {
            print("ERROR: shopItem to remove was not found in cartList")
            return
        }
        guard let qty = self.cartList?[ind].quantity else { return }
        if qty < 2 {
            self.removeProducctFromCart(ind)
        } else {
            self.cartList?[ind].quantity -= 1
        }
    }
    
    private func addProductToCart(_ product: Product){
        let item = ShopItem(name: product.name, price: product.price, quantity: 1)
        self.cartList?.append(item)
    }
    
    private func removeProducctFromCart(_ index: Int){
        self.cartList?.remove(at: index)
    }
    
    func getCartList() -> [ShopItem]{
        return self.cartList!
    }
    
}
