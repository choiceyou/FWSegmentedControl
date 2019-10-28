//
//  ViewController.swift
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/12.
//  Copyright © 2018年 xfg. All rights reserved.
//

import UIKit

/// segmentedControl字体大小
let kSegmentTitleFont: CGFloat = 13.0
/// segmentedControl左边边距
let kSegmentLeftEdge: CGFloat = 10

class ViewController: UIViewController, UIScrollViewDelegate {
    
    /// 是否点击了Segmented的滑块
    var isClickedSegmented = false
    /// Segmented的滑块起始页
    var startPage = 0
    
    let sectionTitles = ["关注", "游戏", "附近", "体育", "女神范", "运动啦啦", "歌舞", "吃鸡", "户外", "脱口秀"]
    
    let sectionTitles2 = ["女神", "运动啦啦", "歌舞"]
    
    let images = [UIImage(named: "1"),
                  UIImage(named: "2"),
                  UIImage(named: "3"),
                  UIImage(named: "4"),
                  UIImage(named: "5"),
                  UIImage(named: "6"),
                  UIImage(named: "7")]
    
    let selectedImages = [UIImage(named: "1-selected"),
                          UIImage(named: "2-selected"),
                          UIImage(named: "3-selected"),
                          UIImage(named: "4-selected"),
                          UIImage(named: "5-selected"),
                          UIImage(named: "6-selected"),
                          UIImage(named: "7-selected")]
    
    let imageTitles3 = ["叶子", "椰子啦", "叶紫"]
    
    let images2 = [UIImage(named: "a"),
                  UIImage(named: "b"),
                  UIImage(named: "c")]
    
    let selectedImages2 = [UIImage(named: "a-selected"),
                          UIImage(named: "b-selected"),
                          UIImage(named: "c-selected")]
    
    /// 例一
    private lazy var segmentedControl: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: nil, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: 50))
        
        segmentedControl.sectionTitleArray = sectionTitles
        segmentedControl.scSelectionIndicatorStyle = .fullWidthStripe
        
        return segmentedControl
    }()
    
    /// 例二
    private lazy var segmentedControl2: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: sectionTitles, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: Int(self.segmentedControl.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.selectedSegmentIndex = 1
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin]
        
        return segmentedControl
    }()
    
    /// 例三
    private lazy var segmentedControl3: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: sectionTitles2, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: Int(self.segmentedControl2.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.scSelectionIndicatorStyle = .box
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorBoxColor = UIColor.green
        segmentedControl.selectionIndicatorBoxOpacity = 0.4
        segmentedControl.selectionIndicatorBoxFollowEdgeInset = true
        segmentedControl.selectionIndicatorHeight = 0
        
        segmentedControl.scBorderType = [.left, .bottom, .top, .right]
        segmentedControl.segmentBorderColor = UIColor.red
        segmentedControl.segmentBorderWidth = 2.0
        segmentedControl.segmentBackgroundColor = UIColor.white
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    /// 例四
    private lazy var segmentedControl4: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamic, sectionTitleArray: sectionTitles, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: Int(self.segmentedControl3.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 30))
        
        segmentedControl.backgroundColor = UIColor.clear
        segmentedControl.scSelectionIndicatorStyle = .box
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 6.0)
        segmentedControl.segmentBackgroundEdgeInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        segmentedControl.selectionIndicatorBoxColor = UIColor.red
        segmentedControl.selectionIndicatorBoxEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segmentedControl.selectionIndicatorBoxFollowEdgeInset = true
        segmentedControl.selectionIndicatorHeight = 0
        
        segmentedControl.enlargetouchesEdgeInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        segmentedControl.segmentBackgroundCornerRadius = 15
        segmentedControl.segmentBackgroundColor = UIColor.white
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    /// 例五
    private lazy var segmentedControl5: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.images, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: nil, sectionImageArray: images as? [UIImage], sectionSelectedImageArray: selectedImages as? [UIImage], frame: CGRect(x: 0, y: Int(self.segmentedControl4.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .up
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 5
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    /// 例六
    private lazy var segmentedControl6: FWSegmentedControl = {
        
        let imageTitles5 = ["福建", "直播", "小视频", "", "附近"]
        
        let sectionSelectedImageDict = [
            0 : FWSectionImageItem(itemImage: UIImage(named: "hm_hot_city")!, itemSelectedImage: UIImage(named: "hm_hot_city_selected")),
            3 : FWSectionImageItem(itemImage: UIImage(named: "a")!, itemSelectedImage: UIImage(named: "a-selected")),
        ]
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.textImages, scWidthStyle: SCWidthStyle.dynamic, sectionTitleArray: imageTitles5, sectionSelectedImageDict: sectionSelectedImageDict, frame: CGRect(x: 0, y: Int(self.segmentedControl5.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.scImagePosition = .rightOfText
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        segmentedControl.selectionIndicatorFollowText = true
        
        segmentedControl.textImageSpacing = 4
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    /// 例七
    private lazy var segmentedControl7: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.textImages, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: imageTitles3, sectionImageArray: images2 as? [UIImage], sectionSelectedImageArray: selectedImages2 as? [UIImage], frame: CGRect(x: 0, y: Int(self.segmentedControl6.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 50))
        
        segmentedControl.scSelectionIndicatorStyle = .arrowDown
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.scImagePosition = .aboveText
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 5
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 2.0
        
        segmentedControl.textImageSpacing = 2.0
        
        segmentedControl.arrowWidth = 15
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    /// 例八
    private lazy var segmentedControl8: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.textImages, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: imageTitles3, sectionImageArray: images2 as? [UIImage], sectionSelectedImageArray: selectedImages2 as? [UIImage], frame: CGRect(x: 0, y: Int(self.segmentedControl7.frame.maxY) + 10, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .fullWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.scImagePosition = .rightOfText
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: kSegmentLeftEdge, bottom: 0, right: kSegmentLeftEdge)
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        segmentedControl.textImageSpacing = 4
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: kSegmentTitleFont)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: kSegmentTitleFont)]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: self.segmentedControl8.frame.maxY, width: self.view.frame.width, height: self.view.frame.height-self.segmentedControl8.frame.maxY))
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(imageTitles3.count), height: self.view.bounds.height-self.segmentedControl8.frame.maxY)
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.view.bounds.width, height: scrollView.frame.height), animated: false)
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        self.navigationItem.title = "FWSegmentedControl"
        self.edgesForExtendedLayout = []
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "多级联动>", style: .plain, target: self, action: #selector(goNextVC))
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.segmentedControl2)
        self.view.addSubview(self.segmentedControl3)
        self.view.addSubview(self.segmentedControl4)
        self.view.addSubview(self.segmentedControl5)
        self.view.addSubview(self.segmentedControl6)
        self.view.addSubview(self.segmentedControl7)
        self.view.addSubview(self.segmentedControl8)
        self.view.addSubview(self.scrollView)

        self.segmentedControl8.indexChangeBlock = { [weak self] index in
            self?.isClickedSegmented = true
            self?.scrollView.scrollRectToVisible(CGRect(x: (self?.view.bounds.width)! * CGFloat(index), y: 0, width: (self?.view.bounds.width)!, height: (self?.scrollView.frame.height)!), animated: true)
        }

        self.scrollView.addSubview(self.setupUIView(index: 0))
        self.scrollView.addSubview(self.setupUIView(index: 1))
        self.scrollView.addSubview(self.setupUIView(index: 2))
    }
}

extension ViewController {
    
    func setupUIView(index: Int) -> UILabel {
        
        let label = UILabel(frame: CGRect(x: self.view.frame.width * CGFloat(index), y: 0, width: self.view.frame.width, height: self.scrollView.frame.height))
        label.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
        label.textColor = UIColor.white
        label.text = self.imageTitles3[index]
        label.textAlignment = .center
        return label
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isClickedSegmented == false {
            let pageWidth = scrollView.frame.width
            let tmpPage = scrollView.contentOffset.x / pageWidth
            let tmpPage2 = scrollView.contentOffset.x / pageWidth
            let page = tmpPage2-tmpPage>=0.5 ? tmpPage+1 : tmpPage
            if startPage != Int(page) {
                self.segmentedControl8.setSelectedSegmentIndex(index: Int(page), animated: true)
                startPage = Int(page)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let page = scrollView.contentOffset.x / pageWidth
        self.isClickedSegmented = false
        self.segmentedControl8.setSelectedSegmentIndex(index: Int(page), animated: true)
    }
    
    @objc func goNextVC() {
        
        self.navigationController?.pushViewController(ViewController2(), animated: true)
    }
}

