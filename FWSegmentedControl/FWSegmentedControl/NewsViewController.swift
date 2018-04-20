//
//  NewsViewController.swift
//  FWSegmentedControl
//
//  Created by xfg on 2018/4/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    public var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel = UILabel(frame: self.view.bounds)
        textLabel.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        self.view.addSubview(textLabel)
    }
}
