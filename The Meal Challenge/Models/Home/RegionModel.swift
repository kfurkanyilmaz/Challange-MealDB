//
//  ListModel.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/11/21.
//

import Foundation

struct RegionModel: Decodable {
    let meals: [Region]?
}

struct Region: Decodable {
    let strArea: String?
}

