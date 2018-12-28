//
//  BMGMrtStationCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

class BMGFreeProductsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var freeProducts = [FreeProduct]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return freeProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMGFreeProductsCollectionViewCell", for: indexPath) as! BMGFreeProductsCollectionViewCell
        cell.setup(freeProduct: freeProducts[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }

    func setup() {
        BMGFireBase.shared.getFreeProduct(success: { (freeProducts) in
            self.freeProducts = freeProducts
            self.collectionView.reloadData()
        }, failure: {
            print("getFreeProduct fail")
        })
    }
    @IBAction func adButtonTapped(_ sender: Any) {
    }

}
