//
//  MenuTableViewController.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/25.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = mainStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.navigationController?.pushViewController(detailViewController, animated: true)
        case 1: //我的背包
            return
        case 2: //米其林吃貨養成計劃
            let webVC = BMGWebViewController.webViewController(url: "https://www.apple.com")
            self.navigationController?.pushViewController(webVC, animated: true)
            return
        case 3: //免費獲得招待卷
            return
        case 4: //成為店家
            return
        case 5: //會員資格與收費
            return
        case 6:
            do {
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance()?.signOut()
                FBSDKLoginManager().logOut()

            } catch let error as NSError {
                print("Error signing out: \(error)")
            }
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = loginStoryBoard.instantiateViewController(withIdentifier: "BMGLoginViewController") as! BMGLoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
        default:

            return
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return super.tableView(tableView, cellForRowAt: indexPath)
    }

}
