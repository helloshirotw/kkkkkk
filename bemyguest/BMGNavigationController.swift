//
//  BMGNavigationController.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/20.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit

class BMGNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = #colorLiteral(red: 0.9764705882, green: 0.6078431373, blue: 0.09411764706, alpha: 1)
        self.navigationBar.isTranslucent = false

//        self.toolbar.tintColor = APColor.deepGray
//        self.navigationBar.tintColor = APColor.deepGray
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: APColor.deepGray]
    }
}

class BMGNavigationBar: UINavigationBar {

}
