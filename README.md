# IOS之分段控制器 -- OC/Swift4.0  

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](http://cocoapods.org/?q=FWSegmentedControl)&nbsp;
![Language](https://img.shields.io/badge/language-swift-orange.svg?style=flat)&nbsp;
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/choiceyou/FWSegmentedControl/blob/master/FWSegmentedControl/LICENSE)



## 支持pod导入：

```cocoaPods
pod 'FWSegmentedControl'
注意：如出现 Unable to find a specification for 'FWSegmentedControl' 错误，可执行 pod repo update 命令。
```


## 可设置参数：
```参数
/// 标题
@objc public var sectionTitleArray: [String]?
/// 图片
@objc public var sectionImageArray: [UIImage]?
/// 选中图片
@objc public var sectionSelectedImageArray: [UIImage]?

/// segment类型
@objc public var scType = SCType.text
/// segment宽度
@objc public var scWidthStyle = SCWidthStyle.fixed
/// 图片相对于文字的位置
@objc public var scImagePosition: SCImagePosition = .leftOfText
/// 选中标识符类型
@objc public var scSelectionIndicatorStyle = SCSelectionIndicatorStyle.contentWidthStripe
/// 选中标识符位置
@objc public var scSelectionIndicatorLocation = SCSelectionIndicatorLocation.down
/// 边框类型
public var scBorderType: SCBorderType = .none

/// 选中标识符高度，注意：self.scSelectionIndicatorStyle == .box || self.scSelectionIndicatorStyle == .none 时无效
@objc public var selectionIndicatorHeight: CGFloat = 3.0
/// 选中标识符，当 SCSelectionIndicatorLocation == up 时，底部edge无效；反之，顶部edge无效；
@objc public var selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
/// 选中标识符颜色
@objc public var selectionIndicatorColor = UIColor.red
@objc public var selectionIndicatorBoxColor = UIColor.gray

/// 滑动或者选中回调
@objc public var indexChangeBlock: SCIndexChangeBlock?
/// 标题NSAttributedString回调
@objc public var titleFormatterBlock: SCTitleFormatterBlock?
/// segment的Inset属性
@objc public var segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5)
@objc public var enlargeEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0)

/// 未选中的标题属性
@objc public var titleTextAttributes: [NSAttributedStringKey: Any]?
/// 选中的标题属性
@objc public var selectedTitleTextAttributes: [NSAttributedStringKey: Any]?

/// 是否可以拖动
@objc public var userDraggable = true
/// 是否可以点击
@objc public var touchEnabled = true

/// segment的边框颜色
@objc public var segmentBorderColor = UIColor.black
/// segment的边框大小
@objc public var segmentBorderWidth: CGFloat = 1.0

/// 选中或者滑动时是否需要动画
@objc public var shouldAnimateUserSelection = true

/// 选中标识符为箭头的宽度
@objc public var arrowWidth: CGFloat = 6.0

/// 选中表示符为box时的opacity值
@objc public var selectionIndicatorBoxOpacity: CGFloat = 0.2

/// segment之间的间隔竖线的宽度
@objc public var verticalDividerWidth: CGFloat = 1.0
/// 是否需要segment之间的间隔竖线
@objc public var verticalDividerEnabled = false
/// segment之间的间隔竖线的颜色
@objc public var verticalDividerColor = UIColor.black

/// 选中标识符滑动的时间
@objc public var indicatorAnimatedTimes: CFTimeInterval = 0.15

/// self.scType == .textImages 时，文字、图片的间隔
@objc public var textImageSpacing: CGFloat = 4.0

/// 选中项的下标
@objc public var selectedSegmentIndex: Int = 0
```



## 简单使用：（注：可下载demo具体查看，分别有OC、Swift的demo）

```swift
/// 类初始化方法
///
/// - Parameters:
///   - scType: segment类型
///   - sectionTitleArray: 标题，可传nil，后续再设置
///   - sectionImageArray: 图片，可传nil，后续再设置
///   - sectionSelectedImageArray: 选中图片，可传nil，后续再设置
///   - frame: frame
@objc open class func segmentedWith(scType: SCType,
                              scWidthStyle: SCWidthStyle,
                         sectionTitleArray: [String]?,
                         sectionImageArray: [UIImage]?,
                 sectionSelectedImageArray: [UIImage]?,
                                     frame: CGRect) -> FWSegmentedControl
```

### OC：
```oc
[FWSegmentedControl segmentedWithScType: SCTypeText
                           scWidthStyle: SCWidthStyleDynamicFixedSuper
                      sectionTitleArray: @[@"关注", @"游戏", @"附近"]
                      sectionImageArray: nil 
              sectionSelectedImageArray: nil
                                  frame: CGRectMake(0, 40, self.view.frame.size.width, 50)];
```


### Swift: <br>
```swift
FWSegmentedControl.segmentedWith(scType: SCType.text,
                           scWidthStyle: SCWidthStyle.fixed,
                      sectionTitleArray: ["关注", "游戏", "附近"],
                      sectionImageArray: nil,
              sectionSelectedImageArray: nil,
                                  frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50)) 

```



## 效果：

![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E6%95%88%E6%9E%9C/%E7%A4%BA%E4%BE%8B1.gif)
![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E6%95%88%E6%9E%9C/%E7%A4%BA%E4%BE%8B2.gif)



## 注意点：

一、本UI库是用Swift4.0编写的，所以安装或者拖入文件后需要把对应的Swift设置为4.0版本： <br>
（1）pod安装方式：![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E6%95%88%E6%9E%9C/%E8%AE%BE%E7%BD%AE1.jpg)
（2）文件拖入方式：Targets --> Build Setting 做相同的设置

二、如果是文件拖入方式，需要设置OC、Swift混编等，相关问题网上有很多解答，我这边就不再重复了



## 结尾语：

- 使用过程中发现bug请issues或（QQ群：670698309）；
- 有新的需求欢迎提出；

