//
//  FWNavigationController.swift
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/29.
//  Copyright © 2018年 xfg. All rights reserved.
//

import Foundation
import UIKit

class FWNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        
        self.extendedLayoutIncludesOpaqueBars = false
        let edgeOptions: UIRectEdge = [.left, .bottom, .right] //注意位移多选枚举的使用
        self.edgesForExtendedLayout = edgeOptions
    }
}
