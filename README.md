IOS之分段控制器 -- OC/Swift4.0  
===================================  

### 支持pod导入：

pod 'FWSegmentedControl'<br>
注意：如出现 Unable to find a specification for 'FWSegmentedControl' 错误，可执行 pod repo update 命令。

-----------------------------------

### 简单使用：  

```python
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
```python
FWSegmentedControl *segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText
                                                                      scWidthStyle:SCWidthStyleDynamicFixedSuper
                                                                 sectionTitleArray:@[@"关注", @"游戏", @"附近"]
                                                                 sectionImageArray:nil sectionSelectedImageArray:nil
                                                                             frame:CGRectMake(0, 40, self.view.frame.size.width, 50)];
```


### Swift: <br>
```python
let segmentedControl = FWSegmentedControl.segmentedWith(scType: SCType.text,
                                                                scWidthStyle: SCWidthStyle.fixed,
                                                                sectionTitleArray: ["关注", "游戏", "附近"],
                                                                sectionImageArray: nil,
                                                                sectionSelectedImageArray: nil,
                                                                frame: CGRect(x: 0, y: 40, width: Int(UIScreen.main.bounds.width), height: 50))                                                             
```

-----------------------------------  

### 效果：

![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B1.gif)
![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E7%A4%BA%E4%BE%8B2.gif)

-----------------------------------

### 注意点：

本UI库是用Swift4.0编写的，所以安装或者拖入文件后需要把对应的Swift设置为4.0版本： <br>
（1）pod安装方式：![](https://github.com/choiceyou/FWSegmentedControl/blob/master/%E8%AE%BE%E7%BD%AE1.jpg)
（2）文件拖入方式：Targets --> Build Setting 做相同的设置

-----------------------------------

### 结尾语：

> 使用过程中有任何问题或者新的需求都可以issues我哦，谢谢！


```gantt
    title 项目开发流程
    section 项目确定
        需求分析       :a1, 2016-06-22, 3d
        可行性报告     :after a1, 5d
        概念验证       : 5d
    section 项目实施
        概要设计      :2016-07-05  , 5d
        详细设计      :2016-07-08, 10d
        编码          :2016-07-15, 10d
        测试          :2016-07-22, 5d
    section 发布验收
        发布: 2d
        验收: 3d
```

