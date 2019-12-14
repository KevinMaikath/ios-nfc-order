//
//  CategoryModel.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class CategoryModel {

    var productList: [Product]?
    var firestoreRepository: FirestoreRepository?
 
    init() {
        self.firestoreRepository = FirestoreRepository.getInstance()
        self.productList = []
    }
    
    func loadProductList(fromCategory category: Category, completion: @escaping (() -> Void)){
        firestoreRepository?.loadProducts(fromCategory: category, completion: { (loadedProducts) in
            self.productList = loadedProducts
            completion()
        })
    }
    
    func getProductListCount() -> Int {
        return self.productList!.count
    }
    
}
