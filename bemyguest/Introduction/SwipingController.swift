//
//  SwipingController.swift
//  Auto Layout Programmatically
//
//  Created by SnoopyKing on 2017/11/11.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//
//Controller
import UIKit

class SwipingController : UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    
    
    let pages = [
        Page(imgName: "guide-image-1", headerText: "讓我們用招待來改變世界"),
        Page(imgName: "guide-image-2", headerText: "驚喜不斷、創造歡樂"),
        Page(imgName: "guide-image-3", headerText: "我招待你，你招待他!"),
        Page(imgName: "guide-image-4", headerText: "我招待你，你招待他!")
    ]

    fileprivate func setupBtnControls(){

        view.addSubview(skipButton)
        skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -30).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(nextBtn)
        nextBtn.leftAnchor.constraint(equalTo: skipButton.rightAnchor, constant: 70).isActive = true
        nextBtn.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor).isActive = true
        view.addSubview(priviousBtn)
        priviousBtn.rightAnchor.constraint(equalTo: skipButton.leftAnchor, constant: -70).isActive = true
        priviousBtn.centerYAnchor.constraint(equalTo: skipButton.centerYAnchor).isActive = true

    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentIndex = self.pageControl.currentPage
        if currentIndex == self.pages.endIndex - 1 {
            self.nextBtn.setTitle("Done", for: .normal)
        } else {
            self.nextBtn.setTitle("Next", for: .normal)
        }
    }
    
    let priviousBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Prev", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.gray, for: .normal)
        btn.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return btn
    }()
    let nextBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
    }()
    
    @objc private func handleNext(){
        if nextBtn.titleLabel!.text! == "Done" {
            self.dismiss(animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunchedOnce")
        } else {
            textAnimations()
        }
    }
    
    func textAnimations() {
        let nextIndex = min(self.pageControl.currentPage + 1, self.pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        self.pageControl.currentPage = nextIndex
        if nextIndex == self.pages.endIndex - 1 {
            self.nextBtn.setTitle("Done", for: .normal)
        }
        self.collectionView?.isScrollEnabled = false
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrevious(){
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        let previousIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("SKIP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleSkip() {
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: "isAppAlreadyLaunchedOnce")
    }

    lazy var pageControl : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor.red
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnControls()
        collectionView.backgroundColor = UIColor.init(red: 249/255, green: 155/255, blue: 24/255, alpha: 1)
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.isPagingEnabled = true
    }
}
