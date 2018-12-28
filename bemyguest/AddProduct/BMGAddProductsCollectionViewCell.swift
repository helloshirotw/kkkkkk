//
//  BMGMrtStationCollectionViewCell.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

protocol BMGAddProductsCollectionViewCellDelegate {
    func addCoins(amount: Int)
}

class BMGAddProductsCollectionViewCell: UICollectionViewCell {

    var addProduct: AddProduct? {
        didSet {
            if let addProduct = addProduct {
                setup(addProduct: addProduct)
            }
        }
    }
    var amounts = [0,1,2,3]
    var addProductsDelegate: BMGAddProductsCollectionViewCellDelegate!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountIntroLabel: UILabel!
    @IBOutlet weak var amountButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBAction func amountButtonTapped(_ sender: Any) {
        ActionSheetMultipleStringPicker.show(withTitle: "選擇數量", rows: [amounts], initialSelection: [0, 0], doneBlock: {
                picker, indexes, values in
            if let dic = values as? [Int] {
                self.amountIntroLabel.isHidden = true
                self.amountButton.isHidden = true
                self.amountLabel.isHidden = false
                self.amountLabel.text = "商品已列進購物車，數量：\(dic.first!)"
                self.amountButton.setTitle("\(dic.first!)", for: .normal)
                self.addCoins(amount: dic.first!)
            }
            return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }

    func addCoins(amount: Int) {
        var totalReward: Double = 0
        var reward = 0.0
        switch ShareData.shared.user.subscribe_plan {
        case "1", "4":
            reward = 0.1
        case "2", "5":
            reward = 0.2 
        case "3", "6":
            reward = 0.5
        default:
            reward = 0.0
        }
        if let point = addProduct?.point {
            totalReward = Double(point) * reward * Double(amount)
        } else {
            totalReward = 0
        }

        self.addProductsDelegate.addCoins(amount: Int(totalReward))
    }

    func setup(addProduct: AddProduct) {
        self.nameLabel.text = addProduct.product
        self.priceLabel.text = "\(addProduct.price)"
        if let image_url = addProduct.image_path {
            self.imageView.sd_setImage(with: URL(string: image_url), completed: nil)
        }
        starLabel.text = addProduct.text1
    }
}
