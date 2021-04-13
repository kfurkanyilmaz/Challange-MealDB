//
//  ProductCollectionViewCell.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/13/21.
//

import UIKit

protocol ProductCollectionViewCellDelegate {
    func favoriteAction(product: Product?)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    var delegate: ProductCollectionViewCellDelegate?
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI(product: Product?, selected: Bool) {
        self.product = product
        self.productLabel.text = product?.strMeal
        if let urlStr = product?.strMealThumb, let url = URL(string: urlStr) {
            self.productImageView.kf.setImage(with: url)
        }
        let image = selected ? UIImage(named: "star") : UIImage(named: "uncheck_star")
        favButton.setImage(image, for: .normal)
    }
    
    @IBAction func favButtonAction(_ sender: UIButton) {
        delegate?.favoriteAction(product: self.product)
    }
}
