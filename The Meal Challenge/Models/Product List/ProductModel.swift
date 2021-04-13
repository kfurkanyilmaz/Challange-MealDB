//
//  ProductModel.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/13/21.
//

import Foundation

struct ProductModel: Decodable {
    let meals: [Product]?
}

struct Product: Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
