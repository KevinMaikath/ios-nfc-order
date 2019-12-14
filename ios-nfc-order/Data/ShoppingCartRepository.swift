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
    private var totalPrice: Float?
    
    init(){
        self.cartList = []
        self.totalPrice = 0
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
        self.totalPrice! += product.price
    }
    
    
    private func addProductToCart(_ product: Product){
        let item = ShopItem(name: product.name, price: product.price, quantity: 1)
        self.cartList?.append(item)
        self.totalPrice! += product.price
    }
    
    private func removeProductFromCart(_ index: Int){
        self.cartList?.remove(at: index)
    }
    
    func getCartList() -> [ShopItem]{
        return self.cartList!
    }
    
    func getTotalPrice() -> Float{
        return self.totalPrice!
    }
    
    func addOneToCart(_ shopItemIndex: Int) {
        self.cartList?[shopItemIndex].quantity += 1
        print("ADD QTY: \(self.cartList?[shopItemIndex].quantity ?? 99)")
        self.totalPrice! += (self.cartList?[shopItemIndex].price)!
    }
    
    func removeOneFromCart(_ shopItemIndex: Int) {
        guard let qty = self.cartList?[shopItemIndex].quantity else { return }
        print("QUANTITY SET TO : \(qty - 1)")
        self.totalPrice! -= (self.cartList?[shopItemIndex].price)!
        if qty <= 1 {
            self.removeProductFromCart(shopItemIndex)
        } else {
            self.cartList?[shopItemIndex].quantity -= 1
        }
        
    }
    
}