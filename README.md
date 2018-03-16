IOS之分段控制器 -- OC/Swift通用  
===================================  
  大标题一般显示工程名,类似html的\<h1\><br />  
  你只要在标题下面跟上=====即可  


支持pod导入：
pod 'FWSegmentedControl'

简单使用：

OC：
FWSegmentedControl *segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:@[@"关注", @"游戏", @"附近"] sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, 40, self.view.frame.size.width, 50)];

Swift:
let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: ["关注", "游戏", "附近"], sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50))

效果：
