//
//  BMGMrtStationCollectionViewCell.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

class BMGFreeProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productTypeLabel: UILabel!
    @IBOutlet weak var remainAmountLabel: UILabel!
    @IBOutlet weak var exchangeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(freeProduct: FreeProduct) {
        if let img_url = freeProduct.img_url {
            self.imageView.sd_setImage(with: URL(string: img_url), completed: nil)
        }
        self.productNameLabel.text = freeProduct.title
        self.productTypeLabel.text = freeProduct.subtitle
        self.remainAmountLabel.text = "\(freeProduct.quantity_daily)"
        self.exchangeButton.setTitle("用\(freeProduct.point)招待幣立即兌換", for: .normal)
    }
    @IBAction func exchangeButtonTapped(_ sender: Any) {
    }
}
