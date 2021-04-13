//
//  ProductListVC.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/13/21.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductListVC: UIViewController {

    var products : [Product]?
    var selectedCategory: Category?
    var selectedRegion: Region?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        fetchProducts()
    }
    
    fileprivate func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "product_cell")
    }
    
    func setupUI() {
        self.activityIndicatorView.type = .lineScalePulseOut
    }
    
    
    func fetchProducts() {
        
        if let safeSelectedCategory = selectedCategory {
            self.title = safeSelectedCategory.strCategory
            self.activityIndicatorView.startAnimating()
            let request = AF.request("https://www.themealdb.com/api/json/v1/1/filter.php?c=\(safeSelectedCategory.strCategory ?? "")")
            request.responseDecodable(of: ProductModel.self) { (response) in
                guard let result = response.value else { return }
                self.products = result.meals
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
            
        } else if let safeSelectedRegion = selectedRegion {
            self.title = safeSelectedRegion.strArea
            self.activityIndicatorView.startAnimating()
            let request = AF.request("https://www.themealdb.com/api/json/v1/1/filter.php?a=\(safeSelectedRegion.strArea ?? "")")
            request.responseDecodable(of: ProductModel.self) { (response) in
                guard let result = response.value else { return }
                self.products = result.meals
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
}

extension ProductListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product_cell", for: indexPath) as? ProductCollectionViewCell {
            cell.setupUI(product: self.products?[indexPath.row], selected: FavoriteManager.shared.isFavorite(productId: self.products?[indexPath.row].idMeal))
            cell.delegate = self
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let itemSize = (width - 32) / 2
        return .init(width: itemSize, height: itemSize + 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
        vc?.selectedProduct = products?[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ProductListVC: ProductCollectionViewCellDelegate {
    func favoriteAction(product: Product?) {
        if FavoriteManager.shared.isFavorite(productId: product?.idMeal) {
            FavoriteManager.shared.deleteFavorite(productId: product?.idMeal)
        } else {
            FavoriteManager.shared.addFavorite(productId: product?.idMeal)
        }
        
        self.collectionView.reloadData()
    }
}
