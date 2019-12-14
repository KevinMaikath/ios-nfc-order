//
//  CatalogModel.swift
//  ios-nfc-order
//
//  Created by alumno on 13/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit

class CatalogModel {
    
    var categories: [Category]?
    var firestoreRepository: FirestoreRepository?
    
    init() {
        self.firestoreRepository = FirestoreRepository.getInstance()
        self.categories = []
    }

    func loadCategories(completion: @escaping (() -> Void)){
        firestoreRepository?.loadCategories(completion: { (loadedCategories) in
            self.categories = loadedCategories
            completion()
        })
    }
    
    func getCategoriesCount() -> Int {
        return self.categories!.count
    }
    
    
}
