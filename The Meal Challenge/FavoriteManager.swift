//
//  FavouriteManager.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/13/21.
//

import Foundation

class FavoriteManager {

    private init() {}
    
    static let shared = FavoriteManager()
    
    func addFavorite(productId: String?) {
        guard let id = productId else { return }
        var currentValues = UserDefaults.standard.stringArray(forKey: "SavedFavoritesArray") ?? [String]()
        currentValues.append(id)
        UserDefaults.standard.set(currentValues, forKey: "SavedFavoritesArray")
    }
    
    func deleteFavorite(productId: String?) {
        guard let id = productId else { return }
        var currentValues = UserDefaults.standard.stringArray(forKey: "SavedFavoritesArray") ?? [String]()
        if let index = currentValues.firstIndex(of: id) {
            currentValues.remove(at: index)
        }
        UserDefaults.standard.set(currentValues, forKey: "SavedFavoritesArray")
    }
    
    func isFavorite(productId: String?) -> Bool {
        guard let productId = productId else { return false }
        if let favorites = UserDefaults.standard.stringArray(forKey: "SavedFavoritesArray") {
            let foundObject = favorites.filter({ $0 == productId})
            return foundObject.count > 0 ? true : false
            
        }
        return false
    }
    
}
