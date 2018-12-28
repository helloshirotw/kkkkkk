//
//  BMGLoginViewController.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/20.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import GoogleSignIn

class BMGLoginViewController: UIViewController {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var googleLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        fbLoginButton.delegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.uiDelegate = self
//        if let isSignedInBefore = GIDSignIn.sharedInstance()?.hasAuthInKeychain() {
//            if isSignedInBefore {
//                GIDSignIn.sharedInstance()?.signInSilently()
//            }
//        }
    }
//    @IBAction func fbLoginButtonTouchUpInside(_ sender: Any) {
//    }
    @IBAction func googleLoginButtonTouchUpInside(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()

    }

}

extension BMGLoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }

//        LottieAnimation.shared.play(view: self.view)

        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { [weak self] (_, error) in

            if let error = error {
                print(error)
                return
            }
            let user = User.init()
            BMGFireBase.shared.updateUser(user: user, success: {
                self?.navigationController?.popViewController(animated: true)
            }, failure: nil)
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("didDisconnectWith \(user!)")
    }

}

extension BMGLoginViewController: GIDSignInUIDelegate {
}

extension BMGLoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signInAndRetrieveData(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let user = User.init()
            BMGFireBase.shared.updateUser(user: user, success: {
                self.navigationController?.popViewController(animated: true)
            }, failure: nil)
        }
    }
//    func checkFBUser() {
//        //"EAAdPHaZBIJtwBAIr3aJPoWfhav1qrXfK9BLFGBO5fpF0zqnAClvFVWgU2HKc5rgwLttJbAiLlwuxmTnay71bwZAZBvqAOiXUr5523lLFBi8W0Os58mHqjVjpajy9SJM9KyUpW2NiuKotIBvd2F9RCi2NIxaZAAgNCAYPZAB0q7hhQjoPzB0rXsbZClozIPrNZBCNhdKZAqSD9QZDZD"
//        let accessToken = FBSDKAccessToken.current()
//        guard let accessTokenString = accessToken?.tokenString else { return }
//        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//        HUD.show(.progress)
//        Auth.auth().signIn(with: credentials, completion: { (user, error) in
//
//            if error != nil {
//                print("Something went wrong with our FB user: ", error!)
//                return
//            }
//
//            guard let uid = user?.uid else { return }
//
//            FirebaseManager.usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                if !snapshot.hasChild(uid) {
//                    // If user sign in first time
//                    self.getUserFBInfo(completion: { (values) in
//                        self.registerUser(uid, values)
//                    })
//                } else {
//                    self.customTabBarController?.login()
//                    HUD.hide()
//                    self.dismiss(animated: true, completion: nil)
//                }
//
//            })
//        })
//    }
//
//    func getUserFBInfo(completion: @escaping ([String : NSObject]) -> Void) {
//        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "name, email, picture"]).start { (connection, result, err) in
//            if err != nil {
//                print("Failed to start graph request", err!)
//                return
//            }
//            if let dic = result as? [String: AnyObject] {
//                let email = dic["email"] as? String
//                let name = dic["name"] as? String
//                let picture = dic["picture"] as! [String: Any]
//                let picData = picture["data"] as! [String: Any]
//                let profileImageUrl = picData["url"] as! String
//
//                let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl] as! [String: NSObject]
//
//                completion(values)
//            }
//        }
//
//    }
//
//    private func registerUser(_ uid: String, _ values: [String: NSObject]) {
//        let usersReference = FirebaseManager.usersRef.child(uid)
//        usersReference.updateChildValues(values) { (error, reference) in
//            guard error == nil else { return }
//            print(reference)
//            self.customTabBarController?.login()
//            HUD.hide()
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
}
