//
//  ViewController.swift
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/12.
//  Copyright © 2018年 xfg. All rights reserved.
//

import UIKit

/// segmentedControl字体大小
fileprivate let kSegmentTitleFont = 13.0
/// segmentedControl左边边距
fileprivate let kSegmentLeftEdge = 10

class ViewController: UIViewController {
    
    private lazy var segmentedControl: FWSegmentedControl = {
        
        let sectionTitles = ["关注", "游戏", "附近", "体育", "女神范", "运动啦啦", "歌舞", "吃鸡", "户外", "脱口秀"]
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: nil, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50))
        
        segmentedControl.sectionTitleArray = sectionTitles
        segmentedControl.scSelectionIndicatorStyle = .fullWidthStripe
        
        return segmentedControl
    }()
    
    private lazy var segmentedControl2: FWSegmentedControl = {
        
        let sectionTitles = ["关注", "游戏", "附近", "体育", "女神范", "运动啦啦", "歌舞", "吃鸡", "户外", "脱口秀"]
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: sectionTitles, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 100, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.autoresizingMask = .flexibleRightMargin
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(kSegmentLeftEdge), 0, CGFloat(kSegmentLeftEdge))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionIndicatorBoxColor = UIColor.clear
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        
        return segmentedControl
    }()
    
    private lazy var segmentedControl3: FWSegmentedControl = {
        
        let sectionTitles = ["女神", "运动啦啦", "歌舞"]
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: sectionTitles, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 150, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .fullWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.autoresizingMask = .flexibleRightMargin
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(kSegmentLeftEdge), 0, CGFloat(kSegmentLeftEdge))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionIndicatorBoxColor = UIColor.clear
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        
        return segmentedControl
    }()
    
    private lazy var segmentedControl4: FWSegmentedControl = {
        
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
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.images, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: nil, sectionImageArray: images as? [UIImage], sectionSelectedImageArray: selectedImages as? [UIImage], frame: CGRect(x: 0, y: 200, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .up
        segmentedControl.autoresizingMask = .flexibleRightMargin
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(kSegmentLeftEdge), 0, CGFloat(kSegmentLeftEdge))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 5
        segmentedControl.selectionIndicatorBoxColor = UIColor.clear
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        return segmentedControl
    }()
    
    private lazy var segmentedControl5: FWSegmentedControl = {
        
        let imageTitles = ["叶子", "椰子", "叶紫"]
        
        let images = [UIImage(named: "a"),
                      UIImage(named: "b"),
                      UIImage(named: "c")]
        
        let selectedImages = [UIImage(named: "a-selected"),
                              UIImage(named: "b-selected"),
                              UIImage(named: "c-selected")]
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.textImages, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: imageTitles, sectionImageArray: images as? [UIImage], sectionSelectedImageArray: selectedImages as? [UIImage], frame: CGRect(x: 0, y: 250, width: Int(UIScreen.main.bounds.width), height: 40))
        
        segmentedControl.scSelectionIndicatorStyle = .contentWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.scImagePosition = .leftOfText
        segmentedControl.autoresizingMask = .flexibleRightMargin
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(kSegmentLeftEdge), 0, CGFloat(kSegmentLeftEdge))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionIndicatorBoxColor = UIColor.clear
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        segmentedControl.textImageSpacing = 4
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        
        return segmentedControl
    }()
    
    private lazy var segmentedControl6: FWSegmentedControl = {
        
        let imageTitles = ["1111", "2222", "3333"]
        
        let images = [UIImage(named: "a"),
                      UIImage(named: "b"),
                      UIImage(named: "c")]
        
        let selectedImages = [UIImage(named: "a-selected"),
                              UIImage(named: "b-selected"),
                              UIImage(named: "c-selected")]
        
        let segmentedControl = FWSegmentedControl.initWith(scType: SCType.textImages, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: imageTitles, sectionImageArray: images as? [UIImage], sectionSelectedImageArray: selectedImages as? [UIImage], frame: CGRect(x: 0, y: 300, width: Int(UIScreen.main.bounds.width), height: 50))
        
        segmentedControl.scSelectionIndicatorStyle = .arrowDown
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.scImagePosition = .aboveText
        segmentedControl.autoresizingMask = .flexibleRightMargin
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(kSegmentLeftEdge), 0, CGFloat(kSegmentLeftEdge))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 5
        segmentedControl.selectionIndicatorBoxColor = UIColor.clear
        segmentedControl.arrowWidth = 15
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 2.0
        
        segmentedControl.textImageSpacing = 2.0
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(kSegmentTitleFont))]
        
        return segmentedControl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.segmentedControl2)
        self.view.addSubview(self.segmentedControl3)
        self.view.addSubview(self.segmentedControl4)
        self.view.addSubview(self.segmentedControl5)
        self.view.addSubview(self.segmentedControl6)
    }
}

