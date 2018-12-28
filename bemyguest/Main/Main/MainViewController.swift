//
//  ViewController.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/18.
//  Copyright © 2018 Gary Chen. All rights reserved.
//


import UIKit
import Firebase
class MainViewController: BaseViewController {

    @IBOutlet weak var freeProdudctsContainerView: UIView!
    @IBOutlet weak var hotSpotsView: UIView!
    @IBOutlet weak var adButton: UIButton!
    @IBOutlet weak var mrtStationLabel: UILabel!
    @IBOutlet weak var mrtStationsCollectionView: BMGMrtStationsCollectionView!
    @IBOutlet weak var hotspotsCollectionView: BMGHotspotsCollectionView!
    @IBOutlet weak var changeProductsCollectionView: BMGChangeProductsCollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginRightBarButton: UIButton!
    @IBOutlet weak var coinRightBarView: UIView!
    @IBOutlet weak var ticketRightBarView: UIView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var ticketLabel: UILabel!
    
    var freeProductsViewController: BMGFreeProductsViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        mrtStationsCollectionView.mrtStationsDelegate = self
        changeProductsCollectionView.changeProductDelegate = self
        self.addSlideMenuButton()
        if isAppAlreadyLaunchedOnce() == false {
            self.presentIntroVC()
        }
    }

    func presentIntroVC() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let introViewController = SwipingController(collectionViewLayout: layout)
        self.present(introViewController, animated: true, completion: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BMGFireBase.shared.getUser(success: { (user) in
            ShareData.shared.user = user
            self.loginRightBarButton.isHidden = true
            self.coinRightBarView.isHidden = false
            self.ticketRightBarView.isHidden = false
            self.coinLabel.text = "\(user.lumen_point)"
            self.ticketLabel.text = "\(user.treat_ticket)"
        }, failure: {
            self.loginRightBarButton.isHidden = false
            self.coinRightBarView.isHidden = true
            self.ticketRightBarView.isHidden = true
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = loginStoryBoard.instantiateViewController(withIdentifier: "BMGLoginViewController") as! BMGLoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let vc = segue.destination as? BMGFreeProductsViewController {
            self.freeProductsViewController = vc
        }
    }

    func isAppAlreadyLaunchedOnce() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return true
        }else{
            print("App launched first time")
            return false
        }
    }

}
extension MainViewController: BMGMrtStationsCollectionViewDelegate {
    func didSelect(item: Int, mrtStations: [MrtStation]) {
        switch item {
        case 0:
            self.freeProdudctsContainerView.isHidden = false
            scrollView.isHidden = true
            freeProductsViewController.setup()
        case 1:
            self.freeProdudctsContainerView.isHidden = true
            scrollView.isHidden = false

            changeProductsCollectionView.setupTopfifteenChangeProducts()
            hotspotsCollectionView.setupHotspots(mrtStations: mrtStations)
        default:
            self.freeProdudctsContainerView.isHidden = true
            scrollView.isHidden = false

            hotspotsCollectionView.setupHotspots(mrtStations: mrtStations)
            if let number = mrtStations.first?.number {
                changeProductsCollectionView.setupChangeProducts(mrtNumber: number)
            }
        }
    }
}

extension MainViewController: BMGChangeProductsCollectionViewDelegate {
    func didSelect(changeProduct: ChangeProduct) {
        if let _ = Auth.auth().currentUser {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let exchangeVC = mainStoryBoard.instantiateViewController(withIdentifier: "BMGExchangeViewController") as! BMGAddProductsViewController
            exchangeVC.changeProduct = changeProduct
            self.navigationController?.pushViewController(exchangeVC, animated: true)
        } else {
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = loginStoryBoard.instantiateViewController(withIdentifier: "BMGLoginViewController") as! BMGLoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
