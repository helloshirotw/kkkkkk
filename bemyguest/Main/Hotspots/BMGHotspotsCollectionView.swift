//
//  BMGMrtStationCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import SDWebImage

class BMGHotspotsCollectionView: BMGBaseCollectionView, UICollectionViewDataSource {

    var hotspots = [Hotspot]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotspots.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMGHotspotsCollectionViewCell", for: indexPath) as! BMGHotspotsCollectionViewCell
        if indexPath.item <= hotspots.count {
            let hotspot = hotspots[indexPath.item]
            cell.hotspotLabel.text = hotspot.title
            if let img_url = hotspot.img_url {
                cell.hotspotImageView.sd_setImage(with: URL(string: img_url), completed: nil)
            }
        }
        return cell
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: self.frame.height)
    }

    func setupHotspots(mrtStations: [MrtStation]) {
        self.hotspots = []
        BMGFireBase.shared.getHotspot(mrtStations: mrtStations, success: { (hotspots) in
            self.hotspots.append(contentsOf: hotspots)
            self.reloadData()
        }, failure: { 
            print("get hotspots fail")
        })
    }

}
