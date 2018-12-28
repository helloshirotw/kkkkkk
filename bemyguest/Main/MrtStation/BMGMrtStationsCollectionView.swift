//
//  BMGMrtStationCollectionView.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/19.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
protocol BMGMrtStationsCollectionViewDelegate: class {
    func didSelect(item: Int, mrtStations: [MrtStation])
}

class BMGMrtStationsCollectionView: BMGBaseCollectionView, UICollectionViewDataSource {

    var mrtStations = [MrtStation]()
    var mrtStationsDelegate: BMGMrtStationsCollectionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mrtStations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMGMrtStationCollectionViewCell", for: indexPath) as! BMGMrtStationCollectionViewCell
        cell.mrtStationButton.setTitle(mrtStations[indexPath.row].name, for: .normal)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.dataSource = self

        BMGFireBase.shared.getMrtList(success: { (mrtStations) in
            let exchangeAreadic = ["name": "兌換區", "number": "default"]
            let topfifteendic = ["name": "精選店家", "number": "TOP-15"]
            let exchangeArea = MrtStation(dic: exchangeAreadic as [String : AnyObject])
            let topfifteen = MrtStation(dic: topfifteendic as [String : AnyObject])
            self.mrtStations.append(exchangeArea)
            self.mrtStations.append(topfifteen)
            self.mrtStations.append(contentsOf: mrtStations)
            self.reloadData()
            self.mrtStationButtonTapped(at: IndexPath(item: 0, section: 0))
        }, failure: {
            print("getMrtList fail")
        })
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return mrtStations[indexPath.item].name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])

    }

}

extension BMGMrtStationsCollectionView: BMGMrtStationCollectionViewCellDelegate {
    func mrtStationButtonTapped(at index: IndexPath) {
        if index.item == 1 {
            mrtStationsDelegate?.didSelect(item: index.item, mrtStations: mrtStations)
        } else {
            mrtStationsDelegate?.didSelect(item: index.item, mrtStations: [mrtStations[index.item]])
        }
    }


}
