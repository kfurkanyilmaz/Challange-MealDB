//
//  ViewController.swift
//  The Meal Challenge
//
//  Created by K. Furkan Yılmaz on 4/10/21.
//

import UIKit
import Alamofire
import NVActivityIndicatorView


class HomePageVC: UIViewController {
  
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [Category]?
    var regions: [Region]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCategories()
        setupCollectionView()
        
    }
    
    func setupUI() {
        self.activityIndicatorView.type = .lineScalePulseOut
    }
    
    func fetchCategories() {
        self.activityIndicatorView.startAnimating()
        let request = AF.request("https://www.themealdb.com/api/json/v1/1/categories.php")
        request.responseDecodable(of: CategoriesModel.self) { (response) in
            guard let result = response.value else { return }
            self.categories = result.categories
            
            let request = AF.request("https://www.themealdb.com/api/json/v1/1/list.php?a=list")
            request.responseDecodable(of: RegionModel.self) { (response) in
                guard let result = response.value else { return }
                self.regions = result.meals
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    fileprivate func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "AreaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "area_cell")
        self.collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "category_cell")
    }
}

extension HomePageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc2 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductListVC") as? ProductListVC
                vc2?.selectedCategory = categories?[indexPath.row]
            self.navigationController?.pushViewController(vc2!, animated: true)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return categories?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "area_cell", for: indexPath) as! AreaCollectionViewCell
            cell.delegate = self
            cell.setupUI(regions: regions)
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cell", for: indexPath) as! CategoryCollectionViewCell
            cell.setupUI(category: categories?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomePageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        if indexPath.section == 0 {
            return .init(width: width, height: 60)
        } else if indexPath.section == 1 {
            let itemSize = (width - 42) / 3
            return .init(width: itemSize, height: itemSize)
        }
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
    }
}

extension HomePageVC: AreaCollectionViewCellDelegate {
    func didSelectRegion(region: Region?) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductListVC") as? ProductListVC
        vc?.selectedRegion = region
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
