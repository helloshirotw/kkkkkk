//
//  BMGFirebase.swift
//  bemyguest
//
//  Created by Gary Chen on 2018/12/20.
//  Copyright © 2018 Gary Chen. All rights reserved.

import FirebaseDatabase
import FirebaseAuth

extension DateFormatter {

    static let shared = DateFormatter()
    func getNow(dateFormat: String) -> String {
        self.dateFormat = dateFormat
        return self.string(from: Date())
    }
}

struct MrtStation {
    var name: String
    var number: String

    init(dic: [String: AnyObject]) {
        self.name = dic["name"] as! String
        self.number = dic["number"] as! String
    }
}

struct Hotspot {
    var title: String?
    var href: String?
    var img_url: String?

    init(dic: [String: AnyObject]) {
        if let title = dic["title"] as? String {
            self.title = title
        }
        if let href = dic["href"] as? String {
            self.href = href
        }
        if let img_url =  dic["img_url"] as? String {
            self.img_url = img_url
        }
    }
}

struct ChangeProduct {
    var name: String
    var fire_id: Int
    var store_name: String
    var image_path: String?
    var extra_point: String?
    init(dic: [String: AnyObject]) {
        self.fire_id = dic["fire_id"] as! Int
        self.name = dic["name"] as! String
        self.store_name = dic["store_name"] as! String
        if let image_path = dic["image_path"] as? String {
            self.image_path = image_path
        }
        if let extra_point = dic["extra_point"] as? String {
            self.extra_point = extra_point
        }
    }
}

struct FreeProduct {
    var title: String
    var subtitle: String
    var quantity_daily: Int
    var img_url: String?
    var point: Int

    init(dic: [String: AnyObject]) {
        self.title = dic["title"] as! String
        self.subtitle = dic["subtitle"] as! String
        self.quantity_daily = dic["quantity_daily"] as! Int
        self.point = dic["point"] as! Int
        if let img_url = dic["img_url"] as? String {
            self.img_url = img_url
        }
    }
}

struct Banner {
    var href: String
    var img_url: String
    var title: String

    init(dic: [String: AnyObject]) {
        self.href = dic["href"] as! String
        self.img_url = dic["img_url"] as! String
        self.title = dic["title"] as! String
    }
}

struct AddProduct {
    var product: String
    var image_path: String?
    var point: Int
    var price: Int
    var text1: String
    var text2: String

    init(dic: [String: AnyObject]) {
        self.product = dic["product"] as! String
        self.image_path = dic["image_path"] as? String
        self.point = dic["point"] as! Int
        self.price = dic["price"] as! Int
        self.text1 = dic["text1"] as! String
        self.text2 = dic["text2"] as! String
    }
}

struct User {
    var annual_income: String = ""
    var birthday: String = ""
    var daily_game: Bool = false
    var dialog: Bool = false
    var display_name: String = ""
    var education: String = ""
    var email: String = ""
    var fail_quantity: Int = 0
    var fire_id: String = ""
    var first_name: String = ""
    var first_game: Bool = false
    var game_loop: Int = 1
    var gender: String = ""
    var job: String = ""
    var last_name: String = ""
    var last_login: String = ""
    var lumen_point: Int = 0
    var phone: String? = ""
    var profile_picture_path: String = ""
    var registered_timedate: String = ""
    var residence: String = ""
    var subscribe_plan: String = ""
    var success_quantity: Int = 0
    var treat_code: String = ""
    var treat_ticket: Int = 2

    init(dic: [String: AnyObject]) {
        self.annual_income = dic["annual_income"] as! String
        self.birthday = dic["birthday"] as! String
        self.daily_game = dic["daily_game"] as! Bool
        self.dialog = dic["dialog"] as! Bool
        self.display_name = dic["display_name"] as! String
        self.education = dic["education"] as! String
        self.email = dic["email"] as! String
        self.fail_quantity = dic["fail_quantity"] as! Int
        self.fire_id = dic["fire_id"] as! String
        self.first_name = dic["first_name"] as! String
        self.first_game = dic["first_game"] as! Bool
        self.game_loop = dic["game_loop"] as! Int
        self.gender = dic["gender"] as! String
        self.job = dic["job"] as! String
        self.last_name = dic["last_name"] as! String
        self.last_login = dic["last_login"] as! String
        self.lumen_point = dic["lumen_point"] as! Int
        if let phone = dic["phone"] as? String {
            self.phone = phone
        }
        self.profile_picture_path = dic["profile_picture_path"] as! String
        self.registered_timedate = dic["registered_timedate"] as! String
        self.residence = dic["residence"] as! String
        self.subscribe_plan = dic["subscribe_plan"] as! String
        self.success_quantity = dic["success_quantity"] as! Int
        self.treat_code = dic["treat_code"] as! String
        self.treat_ticket = dic["treat_ticket"] as! Int
    }

    init() {
        if let user = Auth.auth().currentUser {
            if let display_name = user.displayName {
                self.display_name = display_name
            }
            if let email = user.email {
                self.email = email
            }
            self.fire_id = user.uid
            self.last_login = DateFormatter.shared.getNow(dateFormat: "yyyy-MM-dd")
            if let phone = user.phoneNumber {
                self.phone = phone
            }
            if let profile_picture_path = user.photoURL {
                self.profile_picture_path = "\(profile_picture_path)"
            }
            self.registered_timedate = DateFormatter.shared.getNow(dateFormat: "yyyy-MM-dd'T'HH:mm:ss")
            self.treat_code = randomString(length: 11)
        }

    }

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }

    var dictionary: [String: Any] {
        let dic: [String: Any] = [
            "annual_income": annual_income,
            "birthday": birthday,
            "daily_game": daily_game,
            "dialog": dialog,
            "display_name": display_name,
            "education": education,
            "email": email,
            "fail_quantity": fail_quantity,
            "fire_id": fire_id,
            "first_name": first_name,
            "first_game": first_game,
            "game_loop": game_loop,
            "gender": gender,
            "job": job,
            "last_name": last_name,
            "last_login": last_login,
            "lumen_point": lumen_point,
            "phone": phone as Any,
            "profile_picture_path": profile_picture_path,
            "registered_timedate": registered_timedate,
            "residence": residence,
            "subscribe_plan": subscribe_plan,
            "success_quantity": success_quantity,
            "treat_code": treat_code,
            "treat_ticket": treat_ticket
        ]
        return dic
    }
}

class BMGFireBase: NSObject {

    static let shared: BMGFireBase = BMGFireBase()
    let ref = Database.database().reference()
    var mrtList: DatabaseReference {
        return ref.child("mrtList")
    }
    var hotspot: DatabaseReference {
        return ref.child("vrBar")
    }
    var changeProduct: DatabaseReference {
        return ref.child("changeProduct")
    }
    var freeProduct: DatabaseReference {
        return ref.child("freeProduct")
    }
    var banner: DatabaseReference {
        return ref.child("banner")
    }
    var userRef: DatabaseReference {
        return ref.child("user")
    }
    var store: DatabaseReference {
        return ref.child("store")
    }

    func getBuySumMonthly(userID: String, success: ((Int) -> Void)?, failure: (() -> Void)?) {
        let timeDate = DateFormatter.shared.getNow(dateFormat: "yyyy-MM")
        userRef.child("buySumMonthly").child(timeDate).observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                let buy_sum = data["buy_sum"] as! Int
                success?(buy_sum)
            } else {
                failure?()
            }
        }
    }

    func getAddProducts(productID: Int, success: (([AddProduct]) -> Void)?, failure: (() -> Void)?) {
        store.child("\(productID)").child("menu").queryOrderedByKey().queryEnding(atValue: "2").observeSingleEvent(of: .value) { (snapshot) in
            var addProducts = [AddProduct]()
            let dispatchGroup = DispatchGroup()
            for child in snapshot.children {
                dispatchGroup.enter()
                let snapChild = child as! DataSnapshot
                if let data = snapChild.value as? [String: AnyObject] {
                    let addProduct = AddProduct(dic: data)
                    addProducts.append(addProduct)
                    dispatchGroup.leave()
                } else {
                    failure?()
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                success?(addProducts)
            })
        }
    }

    func updateUser(user: User, success: (() -> Void)?, failure: (() -> Void)?) {
        if let currentUser = Auth.auth().currentUser {
            userRef.child(currentUser.uid).observe(.value) { (snapshot) in
                // user exist
                if snapshot.exists() {
                    self.userRef.child(currentUser.uid).updateChildValues(["treat_ticket": 2])
                    success?()
                } else {
                    self.userRef.child(currentUser.uid).setValue(user.dictionary, withCompletionBlock: { (_, _) in
                        success?()
                    })
                }
            }
        } else {
            failure?()
        }
    }

    func getUser(success: ((User) -> Void)?, failure: (() -> Void)?) {
        if let currentUser = Auth.auth().currentUser {
            userRef.child(currentUser.uid).observe(.value) { (snapshot) in
                if let data = snapshot.value as? [String: AnyObject] {
                    let user = User(dic: data)
                    success?(user)
                } else {
                    failure?()
                }
            }
        } else {
            failure?()
        }
    }

    func getBanner(child: String, success: ((Banner) -> Void)?, failure: (() -> Void)?) {
        banner.observeSingleEvent(of: .value) { (snapshot) in

        }
    }

    func getFreeProduct(success: (([FreeProduct]) -> Void)?, failure: (() -> Void)?) {
        freeProduct.observeSingleEvent(of: .value) { (snapshot) in
            var freeProducts = [FreeProduct]()
            let dispatchGroup = DispatchGroup()
            for child in snapshot.children {
                dispatchGroup.enter()
                let snapChild = child as! DataSnapshot
                if let data = snapChild.value as? [String: AnyObject] {
                    let freeProduct = FreeProduct(dic: data)
                    freeProducts.append(freeProduct)
                    dispatchGroup.leave()
                } else {
                    failure?()
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                success?(freeProducts)
            })

        }
    }
    func getMrtList(success: (([MrtStation]) -> Void)?, failure: (() -> Void)?) {
        mrtList.observeSingleEvent(of: .value) { (snapshot) in
            var mrtStations = [MrtStation]()
            let dispatchGroup = DispatchGroup()
            for child in snapshot.children {
                dispatchGroup.enter()
                let snapChild = child as! DataSnapshot
                if let data = snapChild.value as? [String: AnyObject] {
                    let mrtStation = MrtStation(dic: data)
                    mrtStations.append(mrtStation)
                    dispatchGroup.leave()
                } else {
                    failure?()
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                success?(mrtStations)
            })
        }
    }

    func getHotspot(mrtStations: [MrtStation], success: (([Hotspot]) -> Void)?, failure: (() -> Void)?) {

        for mrtStation in mrtStations {
            var hotspots = [Hotspot]()
            let dispatchGroup = DispatchGroup()
            hotspot.child(mrtStation.number).observeSingleEvent(of: .value) { (snapshot) in
                for child in snapshot.children {
                    dispatchGroup.enter()
                    let snapChild = child as! DataSnapshot
                    if let data = snapChild.value as? [String: AnyObject] {
                        let hotspot = Hotspot(dic: data)
                        hotspots.append(hotspot)
                        dispatchGroup.leave()
                    } else {
                        failure?()
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                    success?(hotspots)
                })
            }
        }
    }

    func getTopfifteenProduct(success: (([ChangeProduct]) -> Void)?, failure: (() -> Void)?) {
        changeProduct.observeSingleEvent(of: .value) { (snapshot) in
            var changeProducts = [ChangeProduct]()
            let dispatchGroup = DispatchGroup()
            for child in snapshot.children {
                dispatchGroup.enter()
                let snapChild = child as! DataSnapshot
                if let data = snapChild.value as? [String: AnyObject] {
                    if let type = data["top_fifteen"] as? Bool {
                        if type == true {
                            let changeProduct = ChangeProduct(dic: data)
                            changeProducts.append(changeProduct)
                        }
                    }
                    dispatchGroup.leave()
                } else {
                    failure?()
                    dispatchGroup.leave()
                }

            }
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                success?(changeProducts)
            })
        }
    }

    func getChangeProduct(mrtNumber: String, success: (([ChangeProduct]) -> Void)?, failure: (() -> Void)?) {
        changeProduct.observeSingleEvent(of: .value) { (snapshot) in
            var changeProducts = [ChangeProduct]()
            let dispatchGroup = DispatchGroup()
            for child in snapshot.children {
                dispatchGroup.enter()
                let snapChild = child as! DataSnapshot
                if let data = snapChild.value as? [String: AnyObject] {
                    let type = data["type"] as! String
                    if type == mrtNumber {
                        let changeProduct = ChangeProduct(dic: data)
                        changeProducts.append(changeProduct)
                    }
                    dispatchGroup.leave()
                } else {
                    failure?()
                    dispatchGroup.leave()
                }

            }
            dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                success?(changeProducts)
            })
        }
    }

    /*
    var userRef: DatabaseReference {
        return ref.child("user").child(APShareData.shared.userID!)
    }
    var storeRef: DatabaseReference {
        return ref.child("store").child(APShareData.shared.changeProductID!)
    }


    var storeUidRef: DatabaseReference {
        return ref.child("storeUid")
    }

    var productHistoryRef: DatabaseReference? {
        guard let serialNumberAddUserID = APShareData.shared.serialNumberAddUserID else { return nil }
        return changeProductRef.child("exchangeHistory").child(serialNumberAddUserID)
    }

    var sellHistoryRef: DatabaseReference {
        return storeRef.child("sellHistory").child(APShareData.shared.serialNumber!)
    }

    var storeExchangeHistoryRef: DatabaseReference? {
        guard let serialNumberAddUserID = APShareData.shared.serialNumberAddUserID else { return nil }
        let currentDate = DateFormatter.shared.getNow(dateFormat: "yyyy-MM-dd")
        return storeRef.child("exchangeHistory").child(currentDate).child(serialNumberAddUserID)
    }

    var buyHistoryRef: DatabaseReference {
        return userRef.child("buyHistory").child(APShareData.shared.serialNumber!).child(APShareData.shared.changeProductID!)
    }

    func observeStoreUidRef(storeUid: String, success: (() -> Void)?, failure: (() -> Void)?) {
        storeUidRef.child(storeUid).observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String: AnyObject],
                let id = data["id"] as? Int {
                APShareData.shared.changeProductID = "\(id)"
                success?()
            } else {
                failure?()
            }
        }
    }

    func observeUserRef(userID: String, completion: (() -> Void)?) {
        userRef.observeSingleEvent(of: .value) { (snapshot) in

            guard let data = snapshot.value as? [String: AnyObject] else { return }
            APShareData.shared.user = User(dic: data)
            print("lumenPoint:\(APShareData.shared.user.lumen_point)")
            completion?()
        }
    }



    func reduceUserPoint(completion: (() -> Void)?) {
        print("Step 5-1")
        if !APShareData.shared.user.first_game {
            self.userRef.updateChildValues(["first_game": true], withCompletionBlock: { (_, _) in
                completion?()
            })
        } else {
            APShareData.shared.user.lumen_point -= APShareData.shared.changeProduct.point
            self.userRef.updateChildValues(["lumen_point": APShareData.shared.user.lumen_point], withCompletionBlock: { (_, _) in

                completion?()
            })
        }
    }

    func addUserPoint(completion: (() -> Void)?) {
        APShareData.shared.user.lumen_point += APShareData.shared.buyHistory.point
        print("userPoint: \(APShareData.shared.user.lumen_point)")
        userRef.updateChildValues(["lumen_point": APShareData.shared.user.lumen_point]) { (_, _) in
            completion?()
        }
    }

    func updateBuyHistoryIsPurchase(completion: (() -> Void)?) {
        buyHistoryRef.updateChildValues(["isPurchase": true]) { (_, _) in
            completion?()
        }
    }

    func updateChangeProduct(completion: (() -> Void)?) {
        print("Step 5-2-1")
        self.productHistoryRef!.updateChildValues(["isSuccess": true]) { [weak self](_, _) in
            print("Step 5-2-2")
            self!.changeProductRef.updateChildValues(["quantity_of_day_remain": APShareData.shared.changeProduct.quantity_of_day_remain - 1], withCompletionBlock: { [weak self](_, _) in

                print("Step 5-2-3")
                let storeHistory = StoreHistory()
                self!.storeExchangeHistoryRef!.setValue(storeHistory.dictionary, withCompletionBlock: { (_, _) in
                    completion?()
                })
            })
        }
    }
    func observeBuyHistoryRef(hasPurchaseCompletion: (() -> Void)?, noPurchaseCompletion: (() -> Void)?) {
        buyHistoryRef.observeSingleEvent(of: .value) { (snapshot) in

            if let data = snapshot.value as? [String: Any] {
                print("hasPurchase")
                APShareData.shared.buyHistory = BuyHistory.init(dic: data)
                hasPurchaseCompletion?()
            } else {
                print("noPurchase")
                noPurchaseCompletion?()
            }
        }
    }
    func observeProductListRef(completion: (() -> Void)?) {
        buyHistoryRef.child("productList").observeSingleEvent(of: .value) { (snapshot) in

            for child in snapshot.children {
                let snapChild = child as! DataSnapshot
                let data = snapChild.value as! [String: Any]
                let product = Product.init(dic: data)
                APShareData.shared.productList.append(product)
            }
            print(APShareData.shared.productList)
            completion?()
        }
    }

    func setSellHistory(completion: (() -> Void)?) {
        APShareData.shared.sellHistory = SellHistory.init()
        sellHistoryRef.setValue(APShareData.shared.sellHistory.dictionary) { (_, _) in
            completion?()
        }
    }

    func observeStoreRef(completion: (() -> Void)?) {
        storeRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            APShareData.shared.store = Store.init(dic: data)
            completion?()
        })
    }

    func updateStoreRef(completion: (() -> Void)?) {

        storeRef.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            if let data = snapshot.value as? [String: AnyObject] {
                let buyCount = data["buy_count"] as! Int
                let buySum = data["buy_sum"] as! Int
                let exchangeCount = data["exchange_count"] as! Int
                let makeMoney = data["make_money"] as! Int
                self!.storeRef.updateChildValues(["buy_count": buyCount + 1, "buy_sum": buySum + APShareData.shared.buyHistory.sum_quantity, "exchange_count": exchangeCount + 1, "make_money": makeMoney + APShareData.shared.buyHistory.point], withCompletionBlock: { (_, _) in
                    completion?()
                })

            }
        })
    }
*/
}
