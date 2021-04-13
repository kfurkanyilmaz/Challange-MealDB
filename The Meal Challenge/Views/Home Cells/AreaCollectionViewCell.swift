//
//  AreaCollectionViewCell.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/10/21.
//

import UIKit
import Alamofire

protocol AreaCollectionViewCellDelegate {
    func didSelectRegion(region: Region?)
}
class AreaCollectionViewCell: UICollectionViewCell {
 
    var delegate: AreaCollectionViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var regions: [Region]?
    
    fileprivate func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "AreaItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "area_item_cell")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionView()
    }
    func setupUI(regions: [Region]?) {
        self.regions = regions
        self.collectionView.reloadData()
    }
    
    
}

extension AreaCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return regions?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "area_item_cell", for: indexPath) as? AreaItemCollectionViewCell {
            if let safeRegion = self.regions {
                cell.strAreaLabel.text = safeRegion[indexPath.row].strArea
            } else {
                cell.strAreaLabel.text = nil
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectRegion(region: regions?[indexPath.row])
    }
}
