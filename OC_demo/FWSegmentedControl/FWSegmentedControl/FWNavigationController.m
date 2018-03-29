//
//  FWNavigationController.m
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/29.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "FWNavigationController.h"

@interface FWNavigationController ()

@end

@implementation FWNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setTranslucent:NO];
    
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
    self.extendedLayoutIncludesOpaqueBars = NO;
}

@end
