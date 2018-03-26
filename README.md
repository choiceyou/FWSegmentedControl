IOS之分段控制器 -- OC/Swift4.0  
===================================  

支持pod导入：
-----------------------------------
pod 'FWSegmentedControl'<br>
注意：如出现 Unable to find a specification for 'FWSegmentedControl' 错误，可执行 pod repo update 命令。

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
![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B1.gif)
![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B2.gif)

注意点：
-----------------------------------
本UI库是用Swift4.0编写的，所以安装或者拖入文件后需要把对应的Swift设置为4.0版本： <br>
（1）pod安装方式：![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E8%AE%BE%E7%BD%AE1.jpg)
（2）文件拖入方式：Targets --> Build Setting 做相同的设置

结尾语：
-----------------------------------
使用过程中有任何问题或者新的需求都可以issues我哦，谢谢！
