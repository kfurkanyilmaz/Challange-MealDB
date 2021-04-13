//
//  ProductDetailVC.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/13/21.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ProductDetailVC: UIViewController {
    
    var selectedProduct: Product?
    var productDetail: ProductDetail?

    
    
    @IBOutlet weak var strCategoryLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var strMealLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView! {
        didSet {
            self.activityIndicatorView.type = .lineScalePulseOut
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProductDetails()
    }
    
    func setupUI(detail: ProductDetail?) {
        self.strMealLabel.text = detail?.strMeal
        self.strCategoryLabel.text = detail?.strCategory
        self.descriptionTextView.text = detail?.strInstructions
        if let urlStr = detail?.strMealThumb, let url = URL(string: urlStr) {
            self.productImageView.kf.setImage(with: url)
        }
    }

    func fetchProductDetails() {
        
        if let safeSelectedProduct = selectedProduct {
            self.title = safeSelectedProduct.strMeal
            self.activityIndicatorView.startAnimating()
            let request = AF.request("https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(safeSelectedProduct.idMeal ?? "")")
            request.responseDecodable(of: ProductDetailModel.self) { (response) in
                guard let result = response.value else { return }
                self.productDetail = result.meals?.first
                self.setupUI(detail: self.productDetail)
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
}

