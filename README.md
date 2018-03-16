IOS之分段控制器 -- OC/Swift通用  
===================================  

支持pod导入：
-----------------------------------
pod 'FWSegmentedControl'<br>

简单使用：  
-----------------------------------  

### OC：<br>
FWSegmentedControl *segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:@[@"关注", @"游戏", @"附近"] sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, 40, self.view.frame.size.width, 50)];

### Swift: <br>
let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: ["关注", "游戏", "附近"], sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50))<br>


效果：
-----------------------------------
[image]: https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B.gif
