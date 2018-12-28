//
//  MenuViewController.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/24.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import Firebase

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index: Int32)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var notLoginVIew: UIView!
    @IBOutlet weak var didLoginView: UIView!
    @IBOutlet weak var btnCloseMenuOverlay: UIView!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountEmailLabel: UILabel!
    @IBOutlet weak var accountPhotoImageView: UIImageView!
    @IBOutlet weak var buySumMonthLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    var btnMenu: UIButton!
    var delegate: SlideMenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        if let user = ShareData.shared.user {
            self.accountNameLabel.text = user.display_name
            self.accountEmailLabel.text = user.email
            let url = URL.init(string: user.profile_picture_path)
            self.accountPhotoImageView.sd_setImage(with: url, completed: nil)
            self.coinsLabel.text = "\(user.lumen_point)"
            BMGFireBase.shared.getBuySumMonthly(userID: user.fire_id, success: { (buySum) in
                self.buySumMonthLabel.text = "\(buySum)"
            }, failure: {
                print("getBuySumMonthly fail")
            })
        }

        if Auth.auth().currentUser != nil {
            didLoginView.isHidden = false
            notLoginVIew.isHidden = true
        } else {
            didLoginView.isHidden = true
            notLoginVIew.isHidden = false
        }
    }

    @IBAction func btnAccountTapped(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    @IBAction func btnCloseTapped(_ button: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }

}
