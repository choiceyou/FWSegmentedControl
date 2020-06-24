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
        self.edgesForExtendedLayout = []
    }
}
