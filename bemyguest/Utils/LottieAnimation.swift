//
//  LottieAnimation.swift
//  Bemyguest
//
//  Created by Gary Chen on 2018/10/30.
//  Copyright © 2018 Gary Chen. All rights reserved.
//

import UIKit
import Lottie

class LottieAnimation {

    public static var shared: LottieAnimation = LottieAnimation()

    var lottieView: LOTAnimationView = LOTAnimationView(name: "more")
    var blackView: UIView = UIView()

    func play(view: UIView) {

        blackView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
        blackView.frame = view.frame
        blackView.addSubview(lottieView)
        lottieView.loopAnimation = true
        lottieView.contentMode = .scaleAspectFill
        lottieView.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        lottieView.center = view.center
        lottieView.play()

        view.addSubview(blackView)
    }

    func stop(view: UIView) {
        lottieView.stop()
        blackView.removeFromSuperview()
    }

}
