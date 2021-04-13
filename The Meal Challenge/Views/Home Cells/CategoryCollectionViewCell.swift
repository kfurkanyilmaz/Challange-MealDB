//
//  CategoryCollectionViewCell.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/10/21.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setupUI(category: Category?) {
        self.categoryLabel.text = category?.strCategory
        if let urlStr = category?.strCategoryThumb, let url = URL(string: urlStr) {
            self.categoryImageView.kf.setImage(with: url)
        }
    }

}
