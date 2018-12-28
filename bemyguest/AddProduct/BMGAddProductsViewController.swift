//
//  BMGMrtStationCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

class BMGAddProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var viewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var addProductImageView: UIImageView!
    @IBOutlet weak var addProductProductName: UILabel!
    @IBOutlet weak var addProductStoreName: UILabel!
    @IBOutlet weak var addProductPriceLabel: UILabel!
    @IBOutlet weak var addProductIntroTitleLabel: UILabel!
    @IBOutlet weak var addProductGetCoinsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var backButton: UIButton!

    var changeProduct: ChangeProduct?
    var addProducts = [AddProduct]()
    var totalCoins: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        if let changeProduct = changeProduct {
            setup(changeProduct: changeProduct)
        }

        confirmButton.isEnabled = false
        confirmButton.setTitle("購物車為空", for: .normal)

    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMGAddProductsCollectionViewCell", for: indexPath) as! BMGAddProductsCollectionViewCell
        cell.addProduct = addProducts[indexPath.item]
        cell.addProductsDelegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }

    func setup(changeProduct: ChangeProduct) {
        addProductProductName.text = changeProduct.name
        addProductStoreName.text = changeProduct.store_name
        addProductIntroTitleLabel.text = "凡購買網友必點Top3就招待\(changeProduct.name)"
        if let image_url = changeProduct.image_path {
            addProductImageView.sd_setImage(with: URL(string: image_url), completed: nil)
        }
        if let extra_point = changeProduct.extra_point {
            addProductPriceLabel.text = extra_point
        }
        BMGFireBase.shared.getAddProducts(productID: changeProduct.fire_id, success: { (addProducts) in
            self.addProducts = addProducts
            self.collectionView.reloadData()
        }, failure: {
            print("getAddProducts fail")
        })
    }
}

extension BMGAddProductsViewController: BMGAddProductsCollectionViewCellDelegate {
    func addCoins(amount: Int){
        self.totalCoins += amount
        self.addProductGetCoinsLabel.text = "您額外獲得\(totalCoins)招待幣"
        if confirmButton.isEnabled == false {
            confirmButton.isEnabled = true
            confirmButton.setTitle("送出訂單", for: .normal)
        }
    }
}
