//
//  BMGBaseCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/24.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit



class BMGBaseCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.delegate = self
    }
}
