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
    
    init() {
        let category1 = Category(name: "Hamburgers", imgUrl: "https://upload.wikimedia.org/wikipedia/commons/0/0b/RedDot_Burger.jpg")
        let category2 = Category(name: "Supplements", imgUrl: "https://cms.splendidtable.org/sites/default/files/styles/w2000/public/french-fries.jpg")
        self.categories = [category1, category2]
    }

    func setCategories(categories: [Category]) {
        self.categories = categories
    }
    
    func getCategoriesCount() -> Int {
        return self.categories!.count
    }
    
    
}
