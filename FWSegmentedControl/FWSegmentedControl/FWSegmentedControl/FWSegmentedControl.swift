/**
 MIT License
 
 Copyright (c) [2018年] [xfg]
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

/** ************************************************
 
 github地址：https://github.com/choiceyou/FWSegmentedControl
 bug反馈、交流群：670698309
 
 ***************************************************
 */

import Foundation
import UIKit

/**
 *  SC：FWSegmentedControl的缩写
 *  segment：段，指的是单个控件
 */

/// segment类型
///
/// - text: 纯文字
/// - images: 纯图片
/// - textImages: 文字、图片混合
@objc public enum SCType: Int {
    case text
    case images
    case textImages
}

/// segment宽度类型
///
/// - fixed: 1、当控件总宽度小于等于父视图宽度时，segment宽度等于均等分父视图宽度；2、当控件总宽度大于父视图宽度时，取其中最大宽度的segment的宽度值，来作为segment的宽度
/// - dynamic: 控件的宽度等于文字或者图片的最大宽度
/// - dynamicFixedSuper: 1、当控件总宽度小于等于父视图宽度时，segment宽度等于均等分父视图宽度；2、当控件总宽度大于父视图宽度时，控件的宽度等于文字或者图片的最大宽度。
@objc public enum SCWidthStyle: Int {
    case fixed
    case dynamic
    case dynamicFixedSuper
}

/// 当 SCType == textImages 时，图片相对于文字的位置
///
/// - behindText: 图片在文字的背后
/// - aboveText: 图片在文字的上边
/// - leftOfText: 图片在文字的左边
/// - belowOfText: 图片在文字的下边
/// - rightOfText: 图片在文字的右边
@objc public enum SCImagePosition: Int {
    case behindText
    case aboveText
    case leftOfText
    case belowOfText
    case rightOfText
}

/// 选中标识符类型
///
/// - none: 无选中标识符
/// - contentWidthStripe: 选中标识符为线条类型，并且宽度等于内容的宽度
/// - fullWidthStripe: 选中标识符为线条类型，并且宽度等于当前控件的宽度
/// - box: 选中标识符带矩形背景
/// - arrowUp: 选中标识符为箭头，箭头向上
/// - arrowDown: 选中标识符为箭头，箭头向下
@objc public enum SCSelectionIndicatorStyle: Int {
    case none
    case contentWidthStripe
    case fullWidthStripe
    case box
    case arrowUp
    case arrowDown
}

/// 选中标识符位置，注意：当 SCSelectionStyle == box 时无效
///
/// - up: 当前控件上面
/// - down: 当前控件下面
@objc public enum SCSelectionIndicatorLocation: Int {
    case up
    case down
}

/// SC边框，注意：OC代码调用时暂时不支持
public struct SCBorderType : OptionSet {
    
    public var rawValue:Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// 无边框
    static var none = SCBorderType(rawValue: 1 << 0)
    /// 上面有边框
    static var top = SCBorderType(rawValue: 1 << 1)
    /// 左边有边框
    static var left = SCBorderType(rawValue: 1 << 2)
    /// 下面有边框
    static var bottom = SCBorderType(rawValue: 1 << 3)
    /// 右边有边框
    static var right = SCBorderType(rawValue: 1 << 4)
}

/// 滑动或者选中回调
public typealias SCIndexChangeBlock = (_ index: Int) -> Void
/// 已经选中了某个index后再次点击的回调
public typealias SCIndexSecondClickedBlock = (_ index: Int) -> Void
/// 标题NSAttributedString回调
public typealias SCTitleFormatterBlock = (_ segmentedControl: FWSegmentedControl, _ title: String, _ index: Int, _ selected: Bool) -> NSAttributedString


open class FWSegmentedControl: UIControl {
    
    /// 标题
    @objc public var sectionTitleArray: [String]? {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    /// 图片
    @objc public var sectionImageArray: [UIImage]? {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    /// 选中图片
    @objc public var sectionSelectedImageArray: [UIImage]? {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    /// 选中图片：key为下标 value为FWSectionImageItem
    @objc public var sectionSelectedImageDict: Dictionary<Int, FWSectionImageItem>? {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }
    
    /// segment类型
    @objc public var scType = SCType.text
    /// segment宽度类型
    @objc public var scWidthStyle = SCWidthStyle.fixed
    /// 图片相对于文字的位置
    @objc public var scImagePosition: SCImagePosition = .leftOfText
    /// 选中标识符类型
    @objc public var scSelectionIndicatorStyle = SCSelectionIndicatorStyle.contentWidthStripe {
        willSet {
            if newValue == .none {
                self.selectionIndicatorHeight = 0.0
            }
        }
    }
    /// 选中标识符位置
    @objc public var scSelectionIndicatorLocation = SCSelectionIndicatorLocation.down
    /// 边框类型
    public var scBorderType: SCBorderType = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 选中标识符高度，注意：self.scSelectionIndicatorStyle == .box || self.scSelectionIndicatorStyle == .none 时无效
    @objc public var selectionIndicatorHeight: CGFloat = 3.0
    /// 选中标识符圆角半径
    @objc public var selectionIndicatorCornerRadius: CGFloat = 1.5
    /// 选中标识符，当 SCSelectionIndicatorLocation == up 时，底部edge无效；反之，顶部edge无效；
    @objc public var selectionIndicatorEdgeInsets = UIEdgeInsets.zero
    /// 选中标识符颜色
    @objc public var selectionIndicatorColor = UIColor(red: 52.0/255.0, green: 181.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    /// 选中滑块颜色
    @objc public var selectionIndicatorBoxColor = UIColor(red: 52.0/255.0, green: 181.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    /// 选中滑块偏移量
    @objc public var selectionIndicatorBoxEdgeInset = UIEdgeInsets.zero
    /// 选中滑块偏移量是受到segmentEdgeInset影响
    @objc public var selectionIndicatorBoxFollowEdgeInset: Bool = false
    
    /// 选中标识符只跟随文字的宽度（当self.scType == .textImages 并且 (self.scImagePosition == .leftOfText 或 .rightOfText)时有效）
    @objc public var selectionIndicatorFollowText: Bool = false
    /// 选中标识符为箭头的宽度
    @objc public var arrowWidth: CGFloat = 6.0
    
    /// 滑动或者选中回调
    @objc public var indexChangeBlock: SCIndexChangeBlock?
    /// 已经选中了某个index后再次点击的回调
    @objc public var indexSecondClickedBlock: SCIndexSecondClickedBlock?
    /// 标题NSAttributedString回调
    @objc public var titleFormatterBlock: SCTitleFormatterBlock?
    /// segment的Inset属性
    @objc public var segmentEdgeInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    /// segment背景与真正的内容块的偏移量
    @objc public var segmentBackgroundEdgeInset = UIEdgeInsets.zero
    /// Segment的背景颜色
    @objc public var segmentBackgroundColor: UIColor = UIColor.clear
    /// Segment的背景圆角值
    @objc public var segmentBackgroundCornerRadius: CGFloat = 0
    /// 扩大点击区域（这个一般不用设置）
    @objc public var enlargetouchesEdgeInset = UIEdgeInsets.zero
    
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
    
    /// 选中表示符为box时的opacity值
    @objc public var selectionIndicatorBoxOpacity: CGFloat = 0.2 {
        willSet {
            selectionIndicatorBoxLayer.opacity = Float(newValue)
        }
    }
    
    /// segment之间的间隔竖线的宽度
    @objc public var verticalDividerWidth: CGFloat = 1.0
    /// 是否需要segment之间的间隔竖线
    @objc public var verticalDividerEnabled = false
    /// segment之间的间隔竖线的颜色
    @objc public var verticalDividerColor = UIColor.black
    /// segment之间的间隔竖线的偏移量
    @objc public var verticalDividerEdgeInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    
    /// 选中标识符滑动的时间
    @objc public var indicatorAnimatedTimes: CFTimeInterval = 0.15
    
    /// self.scType == .textImages 时，文字、图片的间隔
    @objc public var textImageSpacing: CGFloat = 4.0
    
    /// 选中项的下标
    @objc public var selectedSegmentIndex: Int = 0
    
    
    /// 选中标识符 横线
    fileprivate var selectionIndicatorStripLayer = CALayer()
    /// 选中标识符 矩形背景
    fileprivate var selectionIndicatorBoxLayer = CALayer()
    /// 选中标识符 上、下箭头
    fileprivate var selectionIndicatorArrowLayer = CALayer()
    
    /// segment宽度
    fileprivate var segmentWidth: CGFloat = 0
    /// segment的宽度数组
    fileprivate var segmentWidthsArray: [NSNumber]?
    
    /// SC数量
    fileprivate var sectionCount: Int {
        get {
            if self.scType == .text || self.scType == .textImages {
                return (self.sectionTitleArray?.count)!
            } else if self.scType == .images {
                return (self.sectionImageArray?.count)!
            } else {
                // 后续拓展需要在这边添加...
                return 0
            }
        }
    }
    
    fileprivate var scrollView: FWScrollView = {
        
        let scrollView = FWScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override open var frame: CGRect {
        didSet {
            super.frame = frame
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawSegments(rect)
    }
}

// MARK: - 初始化
extension FWSegmentedControl {
    
    /// 初始化UI
    func setupUI() {
        self.addSubview(scrollView)
        
        self.isOpaque = false
        self.backgroundColor = UIColor.white
        
        self.selectionIndicatorBoxLayer.borderWidth = 1.0
        self.selectionIndicatorBoxLayer.borderColor = UIColor.red.cgColor
        
        self.contentMode = .redraw
    }
    
    /// 类初始化方法1
    ///
    /// - Parameters:
    ///   - scType: segment类型
    ///   - sectionTitleArray: 标题，可传nil，后续再设置
    ///   - sectionImageArray: 图片，可传nil，后续再设置
    ///   - sectionSelectedImageArray: 选中图片，可传nil，后续再设置
    ///   - frame: frame
    @objc open class func segmentedWith(scType: SCType, scWidthStyle: SCWidthStyle, sectionTitleArray: [String]?, sectionImageArray: [UIImage]?, sectionSelectedImageArray: [UIImage]?, frame: CGRect) -> FWSegmentedControl {
        let segmentedControl = FWSegmentedControl()
        segmentedControl.scType = scType
        segmentedControl.scWidthStyle = scWidthStyle
        segmentedControl.sectionTitleArray = sectionTitleArray
        segmentedControl.sectionImageArray = sectionImageArray
        segmentedControl.sectionSelectedImageArray = sectionSelectedImageArray
        segmentedControl.frame = frame
        segmentedControl.setupUI()
        return segmentedControl
    }
    
    /// 类初始化方法2
    ///
    /// - Parameters:
    ///   - scType: segment类型
    ///   - sectionTitleArray: 标题，可传nil，后续再设置
    ///   - sectionSelectedImageDict: 图片，可传nil，后续再设置
    ///   - frame: frame
    @objc open class func segmentedWith(scType: SCType, scWidthStyle: SCWidthStyle, sectionTitleArray: [String]?, sectionSelectedImageDict: Dictionary<Int, FWSectionImageItem>?, frame: CGRect) -> FWSegmentedControl {
        let segmentedControl = FWSegmentedControl()
        segmentedControl.scType = scType
        segmentedControl.scWidthStyle = scWidthStyle
        segmentedControl.sectionTitleArray = sectionTitleArray
        segmentedControl.sectionSelectedImageDict = sectionSelectedImageDict
        segmentedControl.frame = frame
        segmentedControl.setupUI()
        return segmentedControl
    }
}

// MARK: - 更新、绘制segment
extension FWSegmentedControl {
    
    /// 计算SC中各个segment的宽度
    fileprivate func updateSegmentsRects() {
        
        self.scrollView.frame = self.bounds
        
        if self.sectionTitleArray == nil && self.sectionImageArray == nil && self.sectionSelectedImageArray == nil {
            return
        }
        
        if self.scType == .text && self.sectionTitleArray == nil {
            return
        } else if self.scType == .images && self.sectionImageArray == nil {
            return
        } else if self.scType == .textImages && self.sectionImageArray == nil && self.sectionTitleArray != nil && self.sectionSelectedImageDict == nil {
            self.scType = .text
        } else if self.scType == .textImages && self.sectionImageArray == nil && self.sectionSelectedImageDict == nil {
            return
        }
        
        if self.sectionCount > 0 {
            self.segmentWidth = self.frame.width / CGFloat(self.sectionCount)
        }
        
        /// 开始计算
        var sectionContentArray = [AnyObject]()
        
        if self.scType == .text {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        } else if self.scType == .images {
            sectionContentArray = self.sectionImageArray! as [AnyObject]
        } else if self.scType == .textImages {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        }
        
        if self.scWidthStyle == .fixed {
            for (index, object) in sectionContentArray.enumerated() {
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true, isOnlyTextWidth: false)
                self.segmentWidth = max(contentWidth, self.segmentWidth)
            }
        }
        else if self.scWidthStyle == .dynamic {
            var tmpWidthsArray = [NSNumber]()
            for (index, object) in sectionContentArray.enumerated() {
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true, isOnlyTextWidth: false)
                tmpWidthsArray.append(NSNumber(value: Float(contentWidth)))
            }
            self.segmentWidthsArray = tmpWidthsArray
        }
        else if self.scWidthStyle == .dynamicFixedSuper {
            var tmpWidthsArray = [NSNumber]()
            var totoalContentWidth: CGFloat = 0
            for (index, object) in sectionContentArray.enumerated() {
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true, isOnlyTextWidth: false)
                tmpWidthsArray.append(NSNumber(value: Float(contentWidth)))
                totoalContentWidth += contentWidth
            }
            if totoalContentWidth < self.frame.width {
                let moreWidth = (self.frame.width - totoalContentWidth) / CGFloat(self.sectionCount)
                for index in 0...self.sectionCount-1 {
                    let tmpWidth = tmpWidthsArray[index].floatValue
                    tmpWidthsArray.replaceSubrange(index..<index+1, with: [NSNumber(value: tmpWidth + Float(moreWidth))])
                }
            }
            self.segmentWidthsArray = tmpWidthsArray
        }
        
        self.scrollView.isScrollEnabled = self.userDraggable
        self.scrollView.contentSize = CGSize(width: self.totalSegmentedControlWidth(), height: self.frame.height)
    }
    
    /// 计算segment的宽度
    ///
    /// - Parameters:
    ///   - index: segment所在下标
    ///   - object: segment标题或者图片
    ///   - isNeedEdgeInset: 是否需要计算左右Inset
    ///   - isOnlyTextWidth: self.scType == .textImages时，是否只返回文字的宽度
    /// - Returns: 宽度
    fileprivate func configSegmentsWidth(index: Int, object: AnyObject, isNeedEdgeInset: Bool, isOnlyTextWidth: Bool) -> CGFloat {
        
        var contentWidth: CGFloat = 0.0
        if self.scType == .text {
            contentWidth = self.measureTitleAtIndex(index: index).width
        } else if self.scType == .images {
            let icon = object as! UIImage
            contentWidth = icon.size.width
        } else if self.scType == .textImages {
            let strWidth = self.measureTitleAtIndex(index: index).width
            var imageWidth: CGFloat = 0.0
            
            if !isOnlyTextWidth || strWidth == 0 {
                if self.sectionImageArray != nil {
                    let icon = self.sectionImageArray![index]
                    imageWidth = icon.size.width
                } else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[index] != nil {
                    let item = self.sectionSelectedImageDict![index]
                    imageWidth = item!.itemImage.size.width
                }
            }
            
            var tmpSpacing: CGFloat = 0
            if strWidth != 0 && imageWidth != 0 {
                tmpSpacing = self.textImageSpacing
            }
            
            if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText {
                contentWidth = strWidth + imageWidth + tmpSpacing
            } else {
                contentWidth = max(strWidth, imageWidth)
            }
        }
        if isNeedEdgeInset {
            contentWidth += self.segmentEdgeInset.left + self.segmentEdgeInset.right + self.segmentBackgroundEdgeInset.left + self.segmentBackgroundEdgeInset.right
        }
        return contentWidth
    }
    
    /// 真正绘制组件
    ///
    /// - Parameter rect: rect
    fileprivate func drawSegments(_ rect: CGRect) {
        
        self.backgroundColor?.setFill()
        UIRectFill(self.bounds)
        
        self.updateSegmentsRects()
        
        self.selectionIndicatorArrowLayer.backgroundColor = self.selectionIndicatorColor.cgColor
        
        self.selectionIndicatorStripLayer.backgroundColor = self.selectionIndicatorColor.cgColor
        self.selectionIndicatorStripLayer.masksToBounds = true
        self.selectionIndicatorStripLayer.cornerRadius = self.selectionIndicatorCornerRadius
        
        self.selectionIndicatorBoxLayer.backgroundColor = self.selectionIndicatorBoxColor.cgColor
        self.selectionIndicatorBoxLayer.borderColor = self.selectionIndicatorBoxColor.cgColor
        self.selectionIndicatorBoxLayer.cornerRadius = self.segmentBackgroundCornerRadius
        
        self.scrollView.layer.sublayers = nil
        
        var sectionContentArray = [AnyObject]()
        
        if self.scType == .text {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        } else if self.scType == .images {
            sectionContentArray = self.sectionImageArray! as [AnyObject]
        } else if self.scType == .textImages {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        }
        
        for (index, object) in sectionContentArray.enumerated() {
            
            var contentWidth: CGFloat = 0.0
            var contentHeight: CGFloat = 0.0
            
            /// 当 self.scType == .textImages 时用到
            var strSize: CGSize = CGSize.zero
            var iconSize: CGSize = CGSize.zero
            
            if self.scType == .text {
                let size = self.measureTitleAtIndex(index: index)
                contentHeight = size.height
            }
            else if self.scType == .images {
                let icon = object as! UIImage
                contentHeight = icon.size.height
            }
            else if self.scType == .textImages {
                strSize = self.measureTitleAtIndex(index: index)
                if self.sectionImageArray != nil {
                    iconSize = self.sectionImageArray![index].size
                } else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[index] != nil {
                    let item = self.sectionSelectedImageDict![index]
                    iconSize = item!.itemImage.size
                }
                
                if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText || self.scImagePosition == .behindText {
                    contentHeight = max(iconSize.height, strSize.height)
                } else {
                    var tmpSpacing: CGFloat = 0
                    if strSize.height != 0 && iconSize.height != 0 {
                        tmpSpacing = self.textImageSpacing
                    }
                    contentHeight = strSize.height + iconSize.height + tmpSpacing
                }
            }
            contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: false, isOnlyTextWidth: false)
            
            var backgroundRect = CGRect.zero
            var contentRect = CGRect.zero
            var dividerRect = CGRect.zero
            
            var xOffset: CGFloat = 0.0
            var widthForIndex: CGFloat = 0.0
            if self.scWidthStyle == .fixed {
                widthForIndex = self.segmentWidth
                xOffset = widthForIndex * CGFloat(index)
            } else {
                var tmpIndex = 0
                for width in self.segmentWidthsArray! {
                    if index == tmpIndex {
                        break
                    }
                    xOffset += CGFloat(width.floatValue)
                    tmpIndex += 1
                }
                widthForIndex = CGFloat(self.segmentWidthsArray![index].floatValue)
            }
            
            backgroundRect = CGRect(x: xOffset + self.segmentEdgeInset.left, y: self.segmentEdgeInset.top, width: widthForIndex - self.segmentEdgeInset.left - self.segmentEdgeInset.right, height: rect.height - self.segmentEdgeInset.top - self.segmentEdgeInset.bottom)
            
            // 向下取整
            backgroundRect = CGRect(x: CGFloat(ceilf(Float(backgroundRect.origin.x))), y: CGFloat(ceilf(Float(backgroundRect.origin.y))), width: CGFloat(ceilf(Float(backgroundRect.width))), height: CGFloat(ceilf(Float(backgroundRect.height))))
            
            contentRect = CGRect(x: (backgroundRect.width - contentWidth) / 2, y: (backgroundRect.height - contentHeight) / 2, width: contentWidth, height: contentHeight)
            
            dividerRect = CGRect(x: backgroundRect.origin.x - self.segmentEdgeInset.left - (self.verticalDividerWidth / 2), y: self.verticalDividerEdgeInset.top, width: self.verticalDividerWidth, height: rect.height - self.verticalDividerEdgeInset.top - self.verticalDividerEdgeInset.bottom)
            
            // 添加组件的背景（这个默认是透明的）
            let backgroundLayer = CALayer()
            backgroundLayer.frame = backgroundRect
            if index == self.selectedSegmentIndex {
                backgroundLayer.backgroundColor = UIColor.clear.cgColor
            } else {
                backgroundLayer.backgroundColor = self.segmentBackgroundColor.cgColor
            }
            backgroundLayer.cornerRadius = self.segmentBackgroundCornerRadius
            self.scrollView.layer.addSublayer(backgroundLayer)
            
            if self.scType == .text {
                let titleLayer = CATextLayer()
                titleLayer.frame = contentRect
                titleLayer.alignmentMode = kCAAlignmentCenter
                if (UIDevice.current.systemVersion as NSString).doubleValue < 10.0 {
                    titleLayer.truncationMode = kCATruncationEnd
                }
                titleLayer.string = self.attributedTitleAtIndex(index: index)
                titleLayer.contentsScale = UIScreen.main.scale
                backgroundLayer.insertSublayer(titleLayer, at: 0)
            } else if self.scType == .images {
                let icon = object as! UIImage
                let imageLayer = CALayer()
                imageLayer.frame = contentRect
                if self.selectedSegmentIndex == index {
                    if self.sectionSelectedImageArray != nil {
                        let highlightIcon = self.sectionSelectedImageArray![index]
                        imageLayer.contents = highlightIcon.cgImage
                    }  else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[index] != nil {
                        let item = self.sectionSelectedImageDict![index]
                        if item?.itemSelectedImage != nil {
                            imageLayer.contents = item!.itemSelectedImage!.cgImage
                        } else {
                            imageLayer.contents = icon.cgImage
                        }
                    } else {
                        imageLayer.contents = icon.cgImage
                    }
                }else {
                    imageLayer.contents = icon.cgImage
                }
                imageLayer.contentsScale = UIScreen.main.scale
                backgroundLayer.addSublayer(imageLayer)
            } else if self.scType == .textImages {
                let title = self.sectionTitleArray![index]
                var icon: UIImage?
                if self.sectionImageArray != nil {
                    icon = self.sectionImageArray![index]
                } else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[index] != nil {
                    let item = self.sectionSelectedImageDict![index]
                    icon = item!.itemImage
                }
                var tmpSpacing: CGFloat = 0
                if !title.isEmpty && icon != nil {
                    tmpSpacing = self.textImageSpacing
                }
                if !title.isEmpty {
                    /// 绘制title
                    let titleLayer = CATextLayer()
                    var titleRect = CGRect.zero
                    if self.scImagePosition == .behindText {
                        titleRect = contentRect
                    } else if self.scImagePosition == .aboveText {
                        titleRect = CGRect(x: contentRect.origin.x, y: contentRect.origin.y + iconSize.height + tmpSpacing, width: contentRect.width, height: strSize.height)
                    } else if self.scImagePosition == .leftOfText {
                        titleRect = CGRect(x: contentRect.origin.x + iconSize.width + tmpSpacing, y: contentRect.origin.y + (contentRect.height - strSize.height) / 2, width: strSize.width, height: strSize.height)
                    } else if self.scImagePosition == .belowOfText {
                        titleRect = CGRect(x: contentRect.origin.x, y: contentRect.origin.y, width: contentRect.width, height: strSize.height)
                    } else if self.scImagePosition == .rightOfText {
                        titleRect = CGRect(x: contentRect.origin.x, y: contentRect.origin.y + (contentRect.height - strSize.height) / 2, width: strSize.width, height: strSize.height)
                    }
                    titleLayer.frame = titleRect
                    titleLayer.alignmentMode = kCAAlignmentCenter
                    if (UIDevice.current.systemVersion as NSString).doubleValue < 10.0 {
                        titleLayer.truncationMode = kCATruncationEnd
                    }
                    titleLayer.string = self.attributedTitleAtIndex(index: index)
                    titleLayer.contentsScale = UIScreen.main.scale
                    backgroundLayer.addSublayer(titleLayer)
                }
                
                /// 绘制图片
                if icon != nil {
                    var imageRect = CGRect.zero
                    if self.scImagePosition == .behindText {
                        imageRect = CGRect(x: contentRect.origin.x + (contentRect.width - iconSize.width) / 2, y: contentRect.origin.y + (contentRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                    } else if self.scImagePosition == .aboveText {
                        imageRect = CGRect(x: contentRect.origin.x + (contentRect.width - iconSize.width) / 2, y: contentRect.origin.y, width: iconSize.width, height: iconSize.height)
                    } else if self.scImagePosition == .leftOfText {
                        imageRect = CGRect(x: contentRect.origin.x, y: contentRect.origin.y + (contentRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                    } else if self.scImagePosition == .belowOfText {
                        imageRect = CGRect(x: contentRect.origin.x + (contentRect.width - iconSize.width) / 2, y: contentRect.origin.y + strSize.height + tmpSpacing, width: iconSize.width, height: iconSize.height)
                    } else if self.scImagePosition == .rightOfText {
                        imageRect = CGRect(x: contentRect.origin.x + strSize.width + tmpSpacing, y: contentRect.origin.y + (contentRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                    }
                    let imageLayer = CALayer()
                    imageLayer.frame = imageRect
                    
                    if self.selectedSegmentIndex == index {
                        if self.sectionSelectedImageArray != nil {
                            let highlightIcon = self.sectionSelectedImageArray![index]
                            imageLayer.contents = highlightIcon.cgImage
                        }  else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[index] != nil {
                            let item = self.sectionSelectedImageDict![index]
                            if item?.itemSelectedImage != nil {
                                imageLayer.contents = item!.itemSelectedImage!.cgImage
                            } else {
                                imageLayer.contents = icon!.cgImage
                            }
                        }  else {
                            imageLayer.contents = icon!.cgImage
                        }
                    } else {
                        imageLayer.contents = icon!.cgImage
                    }
                    imageLayer.contentsScale = UIScreen.main.scale
                    backgroundLayer.addSublayer(imageLayer)
                }
            }
            
            if self.verticalDividerEnabled && index > 0 {
                let verticalDividerLayer = CALayer()
                verticalDividerLayer.frame = dividerRect
                verticalDividerLayer.backgroundColor = self.verticalDividerColor.cgColor
                self.scrollView.layer.addSublayer(verticalDividerLayer)
            }
            self.addBackgroundBorderLayer(backgroundLayer: backgroundLayer, backgroundRect: backgroundRect, index: index)
        }
        
        if self.scSelectionIndicatorStyle != .none {
            if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                if self.selectionIndicatorArrowLayer.superlayer == nil {
                    self.setArrowFrame()
                    self.scrollView.layer.addSublayer(self.selectionIndicatorArrowLayer)
                }
            } else if self.scSelectionIndicatorStyle == .box {
                if self.selectionIndicatorBoxLayer.superlayer == nil {
                    self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                    self.scrollView.layer.insertSublayer(self.selectionIndicatorBoxLayer, at: 0)
                }
                if self.selectionIndicatorStripLayer.superlayer == nil {
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                    self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                }
            } else {
                if self.selectionIndicatorStripLayer.superlayer == nil {
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                    self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                }
            }
        }
    }
    
    fileprivate func addBackgroundBorderLayer(backgroundLayer: CALayer, backgroundRect: CGRect, index: Int) {
        
        if self.scBorderType == .none {
            return
        }
        
        if self.scBorderType.contains(SCBorderType.top) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: 0, width: backgroundRect.width, height: self.segmentBorderWidth)
            backgroundLayer.addSublayer(borderLayer)
        }
        if self.scBorderType.contains(SCBorderType.left){
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: 0, width: self.segmentBorderWidth, height: backgroundRect.height)
            backgroundLayer.addSublayer(borderLayer)
        }
        if self.scBorderType.contains(SCBorderType.bottom) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: backgroundRect.height - self.segmentBorderWidth, width: backgroundRect.width, height: self.segmentBorderWidth)
            backgroundLayer.addSublayer(borderLayer)
        }
        if self.scBorderType.contains(SCBorderType.right) {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: backgroundRect.width - self.segmentBorderWidth, y: 0, width: self.segmentBorderWidth, height: backgroundRect.height)
            backgroundLayer.addSublayer(borderLayer)
        }
        
        if self.scBorderType.contains(SCBorderType.left) && !self.scBorderType.contains(SCBorderType.right) && index == self.sectionCount - 1 {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: backgroundRect.width - self.segmentBorderWidth, y: 0, width: self.segmentBorderWidth, height: backgroundRect.height)
            backgroundLayer.addSublayer(borderLayer)
        }
        
        if !self.scBorderType.contains(SCBorderType.left) && self.scBorderType.contains(SCBorderType.right) && index == 0 {
            let borderLayer = CALayer()
            borderLayer.backgroundColor = self.segmentBorderColor.cgColor
            borderLayer.frame = CGRect(x: 0, y: 0, width: self.segmentBorderWidth, height: backgroundRect.height)
            backgroundLayer.addSublayer(borderLayer)
        }
    }
}

// MARK: - 滑动或者选中操作
extension FWSegmentedControl {
    
    @objc open func setSelectedSegmentIndex(index: Int, animated: Bool) {
        self.setSelectedSegmentIndex(index: index, animated: animated, notify: false)
    }
    
    fileprivate func setSelectedSegmentIndex(index: Int, animated: Bool, notify: Bool) {
        
        self.selectedSegmentIndex = index
        
        self.setNeedsDisplay()
        
        if index < 0 || self.scSelectionIndicatorStyle == .none {
            self.selectionIndicatorArrowLayer.removeFromSuperlayer()
            self.selectionIndicatorStripLayer.removeFromSuperlayer()
            self.selectionIndicatorBoxLayer.removeFromSuperlayer()
        } else {
            self.scrollToSelectedSegmentIndex(animated: animated)
            
            if animated {
                if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                    if self.selectionIndicatorArrowLayer.superlayer == nil {
                        self.scrollView.layer.addSublayer(self.selectionIndicatorArrowLayer)
                        self.setSelectedSegmentIndex(index: index, animated: false, notify: true)
                        return
                    }
                } else if self.scSelectionIndicatorStyle == .box {
                    if self.selectionIndicatorBoxLayer.superlayer == nil {
                        self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                        self.scrollView.layer.insertSublayer(self.selectionIndicatorBoxLayer, at: 0)
                        return
                    }
                    if self.selectionIndicatorStripLayer.superlayer == nil {
                        self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                        self.setSelectedSegmentIndex(index: index, animated: false, notify: true)
                        return
                    }
                }  else {
                    if self.selectionIndicatorStripLayer.superlayer == nil {
                        self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                        self.setSelectedSegmentIndex(index: index, animated: false, notify: true)
                        return
                    }
                }
                
                if notify {
                    self.notifyForSegmentChangeToIndex(index: index)
                }
                
                // 还原CALayer
                if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                    self.selectionIndicatorArrowLayer.actions = nil
                } else if self.scSelectionIndicatorStyle == .box {
                    self.selectionIndicatorBoxLayer.actions = nil
                    self.selectionIndicatorStripLayer.actions = nil
                } else {
                    self.selectionIndicatorStripLayer.actions = nil
                }
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(indicatorAnimatedTimes)
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
                if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                    self.setArrowFrame()
                } else if self.scSelectionIndicatorStyle == .box {
                    self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                }  else {
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                }
                CATransaction.commit()
            } else {
                if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                    self.selectionIndicatorArrowLayer.actions = nil
                    self.setArrowFrame()
                } else if self.scSelectionIndicatorStyle == .box {
                    self.selectionIndicatorBoxLayer.actions = nil
                    self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                    self.selectionIndicatorStripLayer.actions = nil
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                } else {
                    self.selectionIndicatorStripLayer.actions = nil
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                }
                
                if notify {
                    self.notifyForSegmentChangeToIndex(index: index)
                }
            }
        }
    }
    
    fileprivate func notifyForSegmentChangeToIndex(index: Int) {
        
        if self.superview != nil {
            self.sendActions(for: .valueChanged)
        }
        
        if self.indexChangeBlock != nil {
            self.indexChangeBlock!(index)
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch :UITouch in touches {
            let touchLocation = touch.location(in: self)
            let enlargeRect = CGRect(x: self.bounds.origin.x - self.enlargetouchesEdgeInset.left, y: self.bounds.origin.y - self.enlargetouchesEdgeInset.top, width: self.bounds.width + self.enlargetouchesEdgeInset.left + self.enlargetouchesEdgeInset.right, height: self.bounds.height + self.enlargetouchesEdgeInset.top + self.enlargetouchesEdgeInset.bottom)
            
            if enlargeRect.contains(touchLocation) {
                var segment = 0
                if self.scWidthStyle == .fixed {
                    segment = Int((touchLocation.x + self.scrollView.contentOffset.x) / self.segmentWidth)
                } else {
                    var widthLeft = touchLocation.x + self.scrollView.contentOffset.x
                    for width in self.segmentWidthsArray! {
                        widthLeft -= CGFloat(width.floatValue)
                        if widthLeft <= 0 {
                            break
                        }
                        segment += 1
                    }
                }
                
                if segment != self.selectedSegmentIndex && segment < self.sectionCount {
                    if self.touchEnabled {
                        self.setSelectedSegmentIndex(index: Int(segment), animated: self.shouldAnimateUserSelection, notify: true)
                    }
                } else if segment == self.selectedSegmentIndex {
                    if self.indexSecondClickedBlock != nil {
                        self.indexSecondClickedBlock!(segment)
                    }
                }
            }
        }
    }
    
    fileprivate func scrollToSelectedSegmentIndex(animated: Bool) {
        
        var rectForSelectedIndex = CGRect.zero
        var selectedSegmentOffset:CGFloat = 0.0
        if self.scWidthStyle == .fixed {
            rectForSelectedIndex = CGRect(x: self.segmentWidth * CGFloat(self.selectedSegmentIndex), y: 0, width: self.segmentWidth, height: self.frame.height)
            selectedSegmentOffset = self.frame.width/2 - self.segmentWidth/2
        } else {
            var tmpIndex = 0
            var offsetter:CGFloat = 0.0
            for width in self.segmentWidthsArray! {
                if self.selectedSegmentIndex == tmpIndex {
                    break
                }
                offsetter += CGFloat(width.floatValue)
                tmpIndex += 1
            }
            
            rectForSelectedIndex = CGRect(x: offsetter, y: CGFloat(0), width: CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue), height: self.frame.height)
            selectedSegmentOffset = self.frame.width/2 - CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue/2)
        }
        
        rectForSelectedIndex.origin.x -= selectedSegmentOffset
        rectForSelectedIndex.size.width += selectedSegmentOffset * 2
        self.scrollView.scrollRectToVisible(rectForSelectedIndex, animated: animated)
    }
}

// MARK: - 设置选中标识符的Frame
extension FWSegmentedControl {
    
    fileprivate func setArrowFrame() {
        
        self.selectionIndicatorArrowLayer.frame = self.frameForSelectionIndicator()
        self.selectionIndicatorArrowLayer.mask = nil
        
        let arrowPath = UIBezierPath()
        
        var p1 = CGPoint(x: 0, y: 0)
        var p2 = CGPoint(x: 0, y: 0)
        var p3 = CGPoint(x: 0, y: 0)
        
        if self.scSelectionIndicatorStyle == .arrowUp {
            p1 = CGPoint(x: self.selectionIndicatorArrowLayer.bounds.width / 2, y: 0.0)
            p2 = CGPoint(x: 0.0, y: self.selectionIndicatorArrowLayer.bounds.height)
            p3 = CGPoint(x: self.selectionIndicatorArrowLayer.bounds.size.width, y: self.selectionIndicatorArrowLayer.bounds.size.height)
        } else if self.scSelectionIndicatorStyle == .arrowDown {
            p1 = CGPoint(x: self.selectionIndicatorArrowLayer.bounds.width / 2, y: self.selectionIndicatorArrowLayer.bounds.size.height)
            p2 = CGPoint(x: self.selectionIndicatorArrowLayer.bounds.size.width, y: 0.0)
            p3 = CGPoint(x: 0.0, y: 0.0)
        }
        
        arrowPath.move(to: p1)
        arrowPath.addLine(to: p2)
        arrowPath.addLine(to: p3)
        arrowPath.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.selectionIndicatorArrowLayer.bounds
        maskLayer.path = arrowPath.cgPath
        self.selectionIndicatorArrowLayer.mask = maskLayer
    }
    
    fileprivate func frameForSelectionIndicator() -> CGRect {
        
        var indicatorYOffset: CGFloat = 0.0
        if self.scSelectionIndicatorLocation == .down {
            indicatorYOffset = self.bounds.height - self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom
        } else if self.scSelectionIndicatorLocation == .up {
            indicatorYOffset = self.selectionIndicatorEdgeInsets.top
        }
        
        var sectionWidth: CGFloat = 0.0
        if self.scType == .text {
            let stringWidth = self.measureTitleAtIndex(index: self.selectedSegmentIndex).width
            sectionWidth = stringWidth
        } else if self.scType == .images {
            let sectionImage = self.sectionImageArray![self.selectedSegmentIndex]
            let imageWidth = sectionImage.size.width
            sectionWidth = imageWidth
        } else if self.scType == .textImages {
            let stringWidth = self.measureTitleAtIndex(index: self.selectedSegmentIndex).width
            var sectionImage: UIImage?
            var imageWidth: CGFloat = 0.0
            if self.sectionImageArray != nil {
                sectionImage = self.sectionImageArray![self.selectedSegmentIndex]
                imageWidth = sectionImage!.size.width
            } else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[self.selectedSegmentIndex] != nil {
                let item = self.sectionSelectedImageDict![self.selectedSegmentIndex]
                sectionImage = item!.itemImage
                imageWidth = sectionImage!.size.width
            }
            
            if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText {
                var tmpSpacing: CGFloat = 0
                if stringWidth != 0 && imageWidth != 0 {
                    tmpSpacing = self.textImageSpacing
                }
                sectionWidth = stringWidth + imageWidth + tmpSpacing
            } else {
                sectionWidth = max(stringWidth, imageWidth)
            }
        }
        
        if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
            if self.scWidthStyle == .fixed {
                let widthToEndOfSelectedSegment = (self.segmentWidth * CGFloat(self.selectedSegmentIndex)) + self.segmentWidth
                let widthToStartOfSelectedIndex = self.segmentWidth * CGFloat(self.selectedSegmentIndex)
                let x = widthToStartOfSelectedIndex + ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) - (self.selectionIndicatorHeight/2)
                return CGRect(x: x - (self.selectionIndicatorHeight / 2), y: indicatorYOffset, width: self.selectionIndicatorHeight * 2, height: self.selectionIndicatorHeight)
            } else {
                var selectedSegmentOffset: CGFloat = 0.0
                
                var tmpIndex = 0
                for width in self.segmentWidthsArray! {
                    if self.selectedSegmentIndex == tmpIndex {
                        break
                    }
                    selectedSegmentOffset += CGFloat(width.floatValue)
                    tmpIndex += 1
                }
                
                let currentSegmentWidth = self.segmentWidthsArray![self.selectedSegmentIndex].floatValue
                let tmpArrowWidth = (self.arrowWidth != 0) ? self.arrowWidth : self.selectionIndicatorHeight * 2
                
                return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left + (CGFloat(currentSegmentWidth) - tmpArrowWidth) / 2, y: indicatorYOffset, width:tmpArrowWidth - self.selectionIndicatorEdgeInsets.left - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
            }
        } else {
            if self.scSelectionIndicatorStyle == .contentWidthStripe && sectionWidth <= self.segmentWidth && self.scWidthStyle == .fixed {
                let widthToEndOfSelectedSegment = (self.segmentWidth * CGFloat(self.selectedSegmentIndex)) + self.segmentWidth
                let widthToStartOfSelectedIndex = self.segmentWidth * CGFloat(self.selectedSegmentIndex)
                let x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) + (widthToStartOfSelectedIndex - sectionWidth / 2)
                return CGRect(x: x + self.selectionIndicatorEdgeInsets.left, y: indicatorYOffset, width: sectionWidth - self.selectionIndicatorEdgeInsets.left - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight)
            } else {
                if self.scWidthStyle == .dynamic || self.scWidthStyle == .dynamicFixedSuper {
                    var selectedSegmentOffset: CGFloat = 0.0
                    
                    var tmpIndex = 0
                    for width in self.segmentWidthsArray! {
                        if self.selectedSegmentIndex == tmpIndex {
                            break
                        }
                        selectedSegmentOffset += CGFloat(width.floatValue)
                        tmpIndex += 1
                    }
                    
                    if self.scSelectionIndicatorStyle == .contentWidthStripe {
                        let currentSegmentWidth = self.segmentWidthsArray![self.selectedSegmentIndex].floatValue
                        
                        var contentWidth: CGFloat = 0.0
                        var tmpContentWidth: CGFloat = 0.0
                        if self.scType == .text {
                            contentWidth = self.measureTitleAtIndex(index: self.selectedSegmentIndex).width
                        } else if self.scType == .images {
                            let icon = self.sectionImageArray![self.selectedSegmentIndex]
                            contentWidth = icon.size.width
                        } else if self.scType == .textImages {
                            var icon: UIImage?
                            if self.sectionImageArray != nil {
                                icon = self.sectionImageArray![self.selectedSegmentIndex]
                            } else if self.sectionSelectedImageDict != nil && self.sectionSelectedImageDict?[self.selectedSegmentIndex] != nil {
                                let item = self.sectionSelectedImageDict![self.selectedSegmentIndex]
                                icon = item!.itemImage
                            }
                            contentWidth = self.configSegmentsWidth(index: self.selectedSegmentIndex, object: icon as AnyObject, isNeedEdgeInset: false, isOnlyTextWidth: self.selectionIndicatorFollowText)
                            tmpContentWidth = self.configSegmentsWidth(index: self.selectedSegmentIndex, object: icon as AnyObject, isNeedEdgeInset: false, isOnlyTextWidth: false)
                        }
                        var tmpWidth: CGFloat = (CGFloat(currentSegmentWidth) - contentWidth) / 2
                        if self.scType == .textImages && self.selectionIndicatorFollowText {
                            tmpWidth = (CGFloat(currentSegmentWidth) - tmpContentWidth) / 2
                        }
                        return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left + tmpWidth, y: indicatorYOffset, width: contentWidth - self.selectionIndicatorEdgeInsets.left - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
                    }
                    else if self.scSelectionIndicatorStyle == .fullWidthStripe || self.scSelectionIndicatorStyle == .box {
                        return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left, y: indicatorYOffset, width: CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue) - self.selectionIndicatorEdgeInsets.left - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
                    }
                }
                return CGRect(x: (self.segmentWidth + self.selectionIndicatorEdgeInsets.left) * CGFloat(self.selectedSegmentIndex), y: indicatorYOffset, width: self.segmentWidth - self.selectionIndicatorEdgeInsets.left - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight)
            }
        }
    }
    
    fileprivate func frameForFillerSelectionIndicator() -> CGRect {
        
        var selectedSegmentOffset: CGFloat = 0.0
        var tmpSegmentWidth:CGFloat = 0.0
        if self.scWidthStyle == .dynamic || self.scWidthStyle == .dynamicFixedSuper {
            var tmpIndex = 0
            for width in self.segmentWidthsArray! {
                if self.selectedSegmentIndex == tmpIndex {
                    break
                }
                selectedSegmentOffset += CGFloat(width.floatValue)
                tmpIndex += 1
            }
            
            tmpSegmentWidth = CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue)
        } else {
            selectedSegmentOffset = self.segmentWidth * CGFloat(self.selectedSegmentIndex)
            tmpSegmentWidth = self.segmentWidth
        }
        
        var tmpY:CGFloat = 0.0
        var tmpHeight:CGFloat = self.frame.height
        if self.selectionIndicatorBoxFollowEdgeInset == true {
            selectedSegmentOffset += self.segmentEdgeInset.left
            tmpSegmentWidth = tmpSegmentWidth - self.segmentEdgeInset.left - self.segmentEdgeInset.right
            tmpY = self.segmentEdgeInset.top
            tmpHeight = tmpHeight - self.segmentEdgeInset.top - self.segmentEdgeInset.bottom
        }
        
        return CGRect(x: selectedSegmentOffset, y: tmpY, width: tmpSegmentWidth, height: tmpHeight)
    }
}

// MARK: - 配置
extension FWSegmentedControl {
    
    /// segment的Size
    ///
    /// - Parameter index: segment的下标
    /// - Returns: CGSize
    fileprivate func measureTitleAtIndex(index: Int) -> CGSize {
        
        if self.sectionTitleArray == nil || index >= self.sectionTitleArray!.count {
            return CGSize.zero
        }
        
        let title: String = self.sectionTitleArray![index]
        var size = CGSize.zero
        let selected = (index == self.selectedSegmentIndex) ? true : false
        if self.titleFormatterBlock == nil {
            let titleAttrs = selected ? self.resultingSelectedTitleTextAttributes() : self.resultingTitleTextAttributes()
            size = (title as NSString).size(withAttributes: titleAttrs)
        } else {
            size = self.titleFormatterBlock!(self, title, index, selected).size()
        }
        
        return (CGRect(x: 0, y: 0, width: size.width, height: size.height).integral).size
    }
    
    /// 计算所有segment的总宽度
    ///
    /// - Returns: CGFloat
    fileprivate func totalSegmentedControlWidth() -> CGFloat {
        
        if self.scWidthStyle == .fixed {
            return CGFloat(self.sectionCount) * self.segmentWidth
        } else {
            var tmpTotoalStringWidth: CGFloat = 0
            for index in 0...self.sectionCount-1 {
                let tmpItem = self.segmentWidthsArray![index]
                tmpTotoalStringWidth += CGFloat(tmpItem.floatValue)
            }
            return tmpTotoalStringWidth
        }
    }
    
    /// 选中segment的文字属性
    ///
    /// - Returns: 文字属性
    fileprivate func resultingSelectedTitleTextAttributes() -> [NSAttributedStringKey: Any] {
        
        var resultingAttrs = self.resultingTitleTextAttributes()
        if self.selectedTitleTextAttributes != nil {
            resultingAttrs = self.selectedTitleTextAttributes!
        }
        return resultingAttrs
    }
    
    /// 未选中segment的文字属性
    ///
    /// - Returns: 文字属性
    fileprivate func resultingTitleTextAttributes() -> [NSAttributedStringKey: Any] {
        
        var defaults = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font : UIFont.systemFont(ofSize: CGFloat(16.0))]
        if self.titleTextAttributes != nil {
            defaults = self.titleTextAttributes! as! [NSAttributedStringKey : NSObject]
        }
        return defaults
    }
    
    fileprivate func attributedTitleAtIndex(index: Int) -> NSAttributedString {
        
        let title = self.sectionTitleArray![index]
        let selected = (index == self.selectedSegmentIndex)
        
        if self.titleFormatterBlock != nil {
            return self.titleFormatterBlock!(self, title, index, selected)
        } else {
            var titleAttrs = selected ? self.resultingSelectedTitleTextAttributes() : self.resultingTitleTextAttributes()
            let titleColor = titleAttrs[NSAttributedStringKey.foregroundColor] as? UIColor
            if titleColor != nil {
                var dict = titleAttrs
                dict[NSAttributedStringKey.foregroundColor] = titleColor?.cgColor
                titleAttrs = dict
            }
            return NSAttributedString(string: title, attributes: titleAttrs)
        }
    }
}


/// FWScrollView
class FWScrollView: UIScrollView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isDragging {
            self.next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isDragging {
            self.next?.touchesMoved(touches, with: event)
        } else {
            super.touchesMoved(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isDragging {
            self.next?.touchesEnded(touches, with: event)
        } else {
            super.touchesEnded(touches, with: event)
        }
    }
}


open class FWSectionImageItem: NSObject {
    
    /// 当前Item的下标
    //    @objc open var itemIndex: Int
    /// 当前Item的图标
    @objc open var itemImage: UIImage
    /// 当前Item的选中图标
    @objc open var itemSelectedImage: UIImage?
    
    @objc public init(itemImage: UIImage, itemSelectedImage: UIImage?) {
        //        self.itemIndex = itemIndex
        self.itemImage = itemImage
        self.itemSelectedImage = itemSelectedImage
        
        super.init()
    }
}
