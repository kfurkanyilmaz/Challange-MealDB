//
//  Categories.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/11/21.
//

import Foundation

struct CategoriesModel: Decodable {
    let categories: [Category]?
}

struct Category: Decodable {
    let idCategory: String?
    let strCategory: String?
    let strCategoryThumb: String?
}
