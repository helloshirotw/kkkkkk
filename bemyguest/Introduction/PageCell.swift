//
//  PageCell.swift
//  Auto Layout Programmatically
//
//  Created by SnoopyKing on 2017/11/12.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
//View
class PageCell : UICollectionViewCell{
    
    var page : Page? {
        didSet{
            guard let page = page else {return}
            bearImageView.image = UIImage(named: page.imgName)
            headerLabel.text = page.headerText
        }
    }

    let bearImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "guide-image-1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout(){
        self.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(bearImageView)

        bearImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bearImageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
}
