//
//  BMGMrtStationCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

protocol BMGChangeProductsCollectionViewDelegate {
    func didSelect(changeProduct: ChangeProduct)
}

class BMGChangeProductsCollectionView: BMGBaseCollectionView, UICollectionViewDataSource {

    var changeProducts = [ChangeProduct]()
    var changeProductDelegate: BMGChangeProductsCollectionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return changeProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMGChangeProductsCollectionViewCell", for: indexPath) as! BMGChangeProductsCollectionViewCell
        let changeProduct = changeProducts[indexPath.item]
        cell.changeProductTitleLabel.text = changeProduct.name
        cell.changeProductStoreLabel.text = changeProduct.store_name
        cell.changeProductPriceLabel.text = changeProduct.extra_point
        if let img_url = changeProduct.image_path {
            cell.changeProductImageView.sd_setImage(with: URL(string: img_url), completed: nil)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.changeProductDelegate?.didSelect(changeProduct: changeProducts[indexPath.item])
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width - 10) / 2, height: 170)

    }

    func setupChangeProducts(mrtNumber: String) {
        BMGFireBase.shared.getChangeProduct(mrtNumber: mrtNumber, success: { (changeProducts) in
            self.changeProducts = changeProducts
            self.reloadData()
        }, failure: {
            print("get change product fail")
        })
    }

    func setupTopfifteenChangeProducts() {
        BMGFireBase.shared.getTopfifteenProduct(success: { (changeProducts) in
            self.changeProducts = changeProducts
            self.reloadData()
        }, failure: {
            print("getTopfifteenProduct fail")
        })
    }

}
