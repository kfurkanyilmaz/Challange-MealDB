//
//  ProductDetailModel.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/11/21.
//

import Foundation

struct ProductDetailModel: Decodable {
    let meals: [ProductDetail]?
}

struct ProductDetail: Decodable {
    let idMeal: String?
    let strMeal: String?
    let strCategory: String?
    let strInstructions: String?
    let strMealThumb: String?
}
