//
//  ShoppingCartModel.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class ShoppingCartModel {

    var shoppingCart: ShoppingCartRepository?
    var cartList: [ShopItem]?
    var totalPrice: Float?
    
    init(){
        self.shoppingCart = ShoppingCartRepository.getInstance()
        self.refreshCart()
    }
    
    private func refreshCart(){
        self.cartList = shoppingCart?.getCartList()
        self.totalPrice = shoppingCart?.getTotalPrice()
    }
    
    func getCartListCount() -> Int {
        return self.cartList!.count
    }
    
    func addOneToCart(_ shopItemIndex: Int) {
        self.shoppingCart?.addOneToCart(shopItemIndex)
        self.refreshCart()
    }
    
    func removeOneFromCart(_ shopItemIndex: Int){
        self.shoppingCart?.removeOneFromCart(shopItemIndex)
        self.refreshCart()
    }
    
    func pushDataToFirestore(_ docRef: String, completion: @escaping ((String) -> Void)) {
        self.shoppingCart!.pushDataToFirestore(docRef, completion: { error in
            completion(error)
        })
    }
    
}
