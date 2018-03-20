//
//  ViewController2.swift
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

let segmentedControlHeight: CGFloat = 40.0
let segmentedControl2Height: CGFloat = 40.0


class ViewController2: UIViewController, UIScrollViewDelegate {
    
    let sectionTitles = ["女神", "歌舞"]
    let sectionTitles2 = ["叶子", "椰子啦", "叶紫", "叶梓"]
    let sectionTitles3 = ["Swift", "OC", "Android", "RN"]
    
    var segmentedControlArray: [FWSegmentedControl] = []
    
    
    private lazy var segmentedControl: FWSegmentedControl = {
        
        let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: sectionTitles, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: Int(kStatusAndNavBarHeight), width: Int(UIScreen.main.bounds.width), height: Int(segmentedControlHeight)))
        
        segmentedControl.scSelectionIndicatorStyle = .fullWidthStripe
        segmentedControl.scSelectionIndicatorLocation = .down
        segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(10), 0, CGFloat(10))
        
        segmentedControl.selectionIndicatorColor = UIColor.red
        segmentedControl.selectionIndicatorHeight = 3
        
        segmentedControl.verticalDividerEnabled = true
        segmentedControl.verticalDividerColor = UIColor.lightGray
        segmentedControl.verticalDividerWidth = 1.0
        
        segmentedControl.scBorderType = .bottom
        segmentedControl.segmentBorderColor = UIColor.lightGray
        segmentedControl.segmentBorderWidth = 1.0
        
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(13.0))]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13.0))]
        
        segmentedControl.autoresizingMask = .flexibleRightMargin
        
        return segmentedControl
    }()
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: self.segmentedControl.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - self.segmentedControl.frame.maxY))
        scrollView.tag = 0
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(sectionTitles.count), height: segmentedControl2Height)
        scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.view.bounds.width, height: scrollView.frame.height), animated: false)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(self.segmentedControl)
        self.view.addSubview(self.scrollView)
        
        self.segmentedControl.indexChangeBlock = { [weak self] index in
            self?.scrollView.scrollRectToVisible(CGRect(x: (self?.view.bounds.width)! * CGFloat(index), y: 0, width: (self?.view.bounds.width)!, height: (self?.scrollView.frame.height)!), animated: true)
        }
        
        let segmentedControl2 = self.setupSegmentedControl(index: 0, sectionTitleArray: self.sectionTitles2)
        let segmentedControl3 = self.setupSegmentedControl(index: 1, sectionTitleArray: self.sectionTitles3)
        
        self.segmentedControlArray.append(segmentedControl2)
        self.segmentedControlArray.append(segmentedControl3)
        
        self.scrollView.addSubview(segmentedControl2)
        self.scrollView.addSubview(segmentedControl3)
        
    }
}

extension ViewController2 {
    
    func setupSegmentedControl(index: Int, sectionTitleArray: [String]) -> FWSegmentedControl {
        
        let segmentedControl2 = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.dynamicFixedSuper, sectionTitleArray: sectionTitleArray, sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: Int(self.view.frame.width * CGFloat(index)), y: 0, width: Int(UIScreen.main.bounds.width), height: Int(segmentedControl2Height)))
        
        segmentedControl2.scSelectionIndicatorStyle = .fullWidthStripe
        segmentedControl2.scSelectionIndicatorLocation = .down
        segmentedControl2.segmentEdgeInset = UIEdgeInsetsMake(0, CGFloat(10), 0, CGFloat(10))
        
        segmentedControl2.selectionIndicatorColor = UIColor.red
        segmentedControl2.selectionIndicatorHeight = 3
        
        segmentedControl2.verticalDividerEnabled = true
        segmentedControl2.verticalDividerColor = UIColor.lightGray
        segmentedControl2.verticalDividerWidth = 1.0
        
        segmentedControl2.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(13.0))]
        segmentedControl2.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.clear, NSAttributedStringKey.font: UIFont.systemFont(ofSize: CGFloat(13.0))]
        
        segmentedControl2.autoresizingMask = .flexibleRightMargin
        
        let scrollView2 = self.setupScrollView(index: index, sectionTitleArray: sectionTitleArray)
        
        segmentedControl2.indexChangeBlock = { [weak self] index in
            scrollView2.scrollRectToVisible(CGRect(x: (self?.view.bounds.width)! * CGFloat(index), y: 0, width: (self?.view.bounds.width)!, height: (self?.scrollView.frame.height)!), animated: true)
        }
        
        self.scrollView.addSubview(scrollView2)
        
        return segmentedControl2
    }
    
    func setupScrollView(index: Int, sectionTitleArray: [String]) -> UIScrollView {
        
        let scrollView2 = UIScrollView.init(frame: CGRect(x: self.view.frame.width * CGFloat(index), y: segmentedControl2Height, width: self.view.bounds.width, height: self.view.bounds.height-self.segmentedControl.frame.maxY - segmentedControl2Height))
        scrollView2.tag = 1 + index
        scrollView2.backgroundColor = UIColor.clear
        scrollView2.delegate = self
        scrollView2.isPagingEnabled = true
        scrollView2.showsHorizontalScrollIndicator = false
        scrollView2.bounces = false
        scrollView2.contentSize = CGSize(width: self.view.bounds.width * CGFloat(sectionTitleArray.count), height: self.segmentedControl.frame.height)
        scrollView2.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.view.bounds.width, height: scrollView2.frame.height), animated: false)
        
        var tmpIndex = -1
        for title in sectionTitleArray {
            tmpIndex += 1
            scrollView2.addSubview(self.setupLabel(index: tmpIndex, title: title))
        }
        
        return scrollView2
    }
    
    func setupLabel(index: Int, title: String) -> UILabel {
        
        let label = UILabel(frame: CGRect(x: self.view.frame.width * CGFloat(index), y: 0, width: self.view.frame.width, height: self.scrollView.frame.height))
        label.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
        label.textColor = UIColor.white
        label.text = title
        label.textAlignment = .center
        return label
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.width
        let tmpPage = scrollView.contentOffset.x / pageWidth
        let tmpPage2 = scrollView.contentOffset.x / pageWidth
        let page = tmpPage2-tmpPage>=0.5 ? tmpPage+1 : tmpPage
        
        if scrollView.tag == 0 {
            self.segmentedControl.setSelectedSegmentIndex(index: Int(page), animated: true)
        } else {
            let segmentedControl = segmentedControlArray[scrollView.tag-1]
            segmentedControl.setSelectedSegmentIndex(index: Int(page), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.width
        let page = scrollView.contentOffset.x / pageWidth
        
        if scrollView.tag == 0 {
            self.segmentedControl.setSelectedSegmentIndex(index: Int(page), animated: true)
        } else {
            let segmentedControl = segmentedControlArray[scrollView.tag-1]
            segmentedControl.setSelectedSegmentIndex(index: Int(page), animated: true)
        }
    }
}
