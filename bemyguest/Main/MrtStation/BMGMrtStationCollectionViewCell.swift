//
//  BMGMrtStationCollectionViewCell.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

protocol BMGMrtStationCollectionViewCellDelegate {
    func mrtStationButtonTapped(at index: IndexPath)
}

class BMGMrtStationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mrtStationButton: UIButton!
    var indexPath: IndexPath!
    var delegate : BMGMrtStationCollectionViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func mrtStationButtonTapped(_ sender: Any) {
        self.delegate.mrtStationButtonTapped(at: indexPath)
    }
    func setup() {
        
    }
}
