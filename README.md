IOS之分段控制器 -- OC/Swift通用  
===================================  

支持pod导入：
-----------------------------------
pod 'FWSegmentedControl'<br>

简单使用：  
-----------------------------------  

/// 类初始化方法<br>
///<br>
/// - Parameters:<br>
///   - scType: segment类型<br>
///   - sectionTitleArray: 标题，可传nil，后续再设置<br>
///   - sectionImageArray: 图片，可传nil，后续再设置<br>
///   - sectionSelectedImageArray: 选中图片，可传nil，后续再设置<br>
///   - frame: frame<br>
@objc open class func segmentedWith(scType: SCType, scWidthStyle: SCWidthStyle, sectionTitleArray: [String]?, sectionImageArray: [UIImage]?, sectionSelectedImageArray: [UIImage]?, frame: CGRect) -> FWSegmentedControl<br>

### OC：<br>
FWSegmentedControl *segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:@[@"关注", @"游戏", @"附近"] sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, 40, self.view.frame.size.width, 50)];

### Swift: <br>
let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text, scWidthStyle: SCWidthStyle.fixed, sectionTitleArray: ["关注", "游戏", "附近"], sectionImageArray: nil, sectionSelectedImageArray: nil, frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50))<br>


效果：
-----------------------------------
![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B.gif)


结尾语：
-----------------------------------
使用过程中有任何问题可以issues我哦，或者有其他问题都可以加群哦，谢谢！

欢迎有问题的小伙伴入群讨论：670698309
