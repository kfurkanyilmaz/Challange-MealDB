//
//  AreaItemCollectionViewCell.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/10/21.
//

import UIKit

class AreaItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var strAreaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        strAreaLabel.layer.cornerRadius = 10
        strAreaLabel.layer.masksToBounds = true
    }
}
