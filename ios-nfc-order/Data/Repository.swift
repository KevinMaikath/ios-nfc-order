//
//  Repository.swift
//  ios-nfc-order
//
//  Created by alumno on 13/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit
import Firebase

class Repository {

    private static var INSTANCE: Repository?
    private let CATEGORIES_ROOT_REF = "/categories"
    private var categories: [Category]!
    private var lastCategoryLoaded = ""
    private var productList: [Product]!
    
    init(){
        self.categories = []
        self.productList = []
    }
    
    public static func getInstance() -> Repository{
        if INSTANCE == nil {
            INSTANCE = Repository()
        }
        return INSTANCE!
    }
    
    func loadCategories(completion: @escaping (([Category]) -> Void)){
        if (self.categories.isEmpty) {
            Firestore.firestore().collection(self.CATEGORIES_ROOT_REF).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("ERROR: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let name = data["name"] as? String ?? ""
                        let imgUrl = data["imgUrl"] as? String ?? ""
                        let items = data["items"] as? [DocumentReference] ?? []
                    
                        let category = Category(name: name, imgUrl: imgUrl, items: items)
                        self.categories.append(category)
                    }
                    completion(self.categories)
                }
            }
        } else {
            completion(self.categories)
        }
    }
    
    
    func loadProducts(fromCategory category: Category, completion: @escaping (([Product]) -> Void)) {
        if (self.lastCategoryLoaded == category.name) {
            completion(self.productList)
        } else {
            self.productList = []
            for doc in category.items {
                doc.getDocument { (docSnapshot, error) in
                    if let err = error {
                        print("ERROR: \(err)")
                    } else {
                        guard let docSnapshot = docSnapshot, docSnapshot.exists else {
                            print("___________Error while loading document from firebase")
                            return
                        }
                        let data = docSnapshot.data()
                        let name = data!["name"] as? String ?? ""
                        let imgUrl = data!["imgUrl"] as? String ?? ""
                        let ingredients = data!["ingredients"] as? [String] ?? []
                        let price = data!["price"] as? Float ?? 0
                    
                        let product = Product(name: name, imgUrl: imgUrl, price: price,    ingredients: ingredients)
                        self.productList.append(product)
                        completion(self.productList)
                    }
                }
            }
            self.lastCategoryLoaded = category.name
        }
    }
    
}
