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

/// segment宽度
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

/// 边框类型
///
/// - none: 无边框
/// - top: 上面有边框
/// - left: 左边有边框
/// - bottom: 下面有边框
/// - right: 右边有边框
@objc public enum SCBorderType: Int {
    case none
    case top
    case left
    case bottom
    case right
}

/// 滑动或者选中回调
public typealias SCIndexChangeBlock = (_ index: Int) -> Void
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
    
    /// segment类型
    @objc public var scType = SCType.text
    
    /// segment宽度
    @objc public var scWidthStyle = SCWidthStyle.fixed
    
    /// 图片相对于文字的位置
    @objc public var scImagePosition: SCImagePosition = .leftOfText
    
    /// 选中标识符类型
    @objc public var scSelectionIndicatorStyle = SCSelectionIndicatorStyle.contentWidthStripe {
        didSet {
            if oldValue == .none {
                self.selectionIndicatorHeight = 0.0
            }
        }
    }
    /// 选中标识符位置
    @objc public var scSelectionIndicatorLocation = SCSelectionIndicatorLocation.down
    /// 选中标识符高度，注意：self.scSelectionIndicatorStyle == .box || self.scSelectionIndicatorStyle == .none 时无效
    @objc public var selectionIndicatorHeight: CGFloat = 3.0
    /// 选中标识符，当 SCSelectionIndicatorLocation == up 时，底部edge无效；反之，顶部edge无效；
    @objc public var selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    /// 选中标识符颜色
    @objc public var selectionIndicatorColor = UIColor(red: 52.0/255.0, green: 181.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    @objc public var selectionIndicatorBoxColor = UIColor(red: 52.0/255.0, green: 181.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    
    /// 边框类型
    @objc public var scBorderType: SCBorderType = .none {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 滑动或者选中回调
    @objc public var indexChangeBlock: SCIndexChangeBlock?
    /// 标题NSAttributedString回调
    @objc public var titleFormatterBlock: SCTitleFormatterBlock?
    /// 控件Inset属性
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
    
    /// 边框颜色
    @objc public var borderColor = UIColor.black
    /// 边框大小
    @objc public var borderWidth: CGFloat = 1.0
    
    /// 选中或者滑动时是否需要动画
    @objc public var shouldAnimateUserSelection = true
    
    /// 选中标识符为箭头的宽度
    @objc public var arrowWidth: CGFloat = 6.0
    
    /// 选中表示符为box时的opacity值
    @objc public var selectionIndicatorBoxOpacity: CGFloat = 0.2 {
        didSet {
            selectionIndicatorBoxLayer.opacity = Float(oldValue)
        }
    }
    
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
            if self.scType == .text {
                return (self.sectionTitleArray?.count)!
            } else if self.scType == .images || self.scType == .textImages {
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
            self.updateSegmentsRects()
            super.frame = frame
        }
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            return
        }
        
        self.updateSegmentsRects()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateSegmentsRects()
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawSegments(rect)
    }
}

extension FWSegmentedControl {
    
    /// 初始化UI
    func setupUI() {
        self.addSubview(scrollView)
        
        self.isOpaque = false
        self.backgroundColor = UIColor.white
        
        self.selectionIndicatorBoxOpacity = 0.2
        self.selectionIndicatorBoxLayer.borderWidth = 1.0
        
        self.contentMode = .redraw
    }
    
    /// 类初始化方法
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
        } else if self.scType == .textImages && self.sectionImageArray == nil && self.sectionTitleArray != nil {
            self.scType = .text
        } else if self.scType == .textImages && self.sectionImageArray == nil {
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
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true)
                self.segmentWidth = max(contentWidth, self.segmentWidth)
            }
        }
        else if self.scWidthStyle == .dynamic {
            var tmpWidthsArray = [NSNumber]()
            for (index, object) in sectionContentArray.enumerated() {
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true)
                tmpWidthsArray.append(NSNumber(value: Float(contentWidth)))
            }
            self.segmentWidthsArray = tmpWidthsArray
        }
        else if self.scWidthStyle == .dynamicFixedSuper {
            var tmpWidthsArray = [NSNumber]()
            var totoalContentWidth: CGFloat = 0
            for (index, object) in sectionContentArray.enumerated() {
                let contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: true)
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
    /// - Returns: 宽度
    fileprivate func configSegmentsWidth(index: Int, object: AnyObject, isNeedEdgeInset: Bool) -> CGFloat {
        
        var contentWidth: CGFloat = 0.0
        if self.scType == .text {
            contentWidth = self.measureTitleAtIndex(index: index).width
        } else if self.scType == .images {
            let icon = object as! UIImage
            contentWidth = icon.size.width
        } else if self.scType == .textImages {
            let strWidth = self.measureTitleAtIndex(index: index).width
            let icon = self.sectionImageArray![index]
            let imageWidth = icon.size.width
            if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText {
                contentWidth = strWidth + imageWidth + self.textImageSpacing
            } else {
                contentWidth = max(strWidth, imageWidth)
            }
        }
        if isNeedEdgeInset {
            contentWidth += self.segmentEdgeInset.left + self.segmentEdgeInset.right
        }
        return contentWidth
    }
    
    /// 真正绘制组件
    ///
    /// - Parameter rect: rect
    fileprivate func drawSegments(_ rect: CGRect) {
        
        self.backgroundColor?.setFill()
        UIRectFill(self.bounds)
        
        self.selectionIndicatorArrowLayer.backgroundColor = self.selectionIndicatorColor.cgColor
        
        self.selectionIndicatorStripLayer.backgroundColor = self.selectionIndicatorColor.cgColor
        
        self.selectionIndicatorBoxLayer.backgroundColor = self.selectionIndicatorBoxColor.cgColor
        self.selectionIndicatorBoxLayer.borderColor = self.selectionIndicatorBoxColor.cgColor
        
        self.scrollView.layer.sublayers = nil
        
        let oldRect = rect
        
        var contentWidth: CGFloat = 0.0
        var contentHeight: CGFloat = 0.0
        var sectionContentArray = [AnyObject]()
        
        /// 当 self.scType == .textImages 时用到
        var strSize: CGSize = CGSize(width: 0, height: 0)
        var iconSize: CGSize = CGSize(width: 0, height: 0)
        
        if self.scType == .text {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        } else if self.scType == .images {
            sectionContentArray = self.sectionImageArray! as [AnyObject]
        } else if self.scType == .textImages {
            sectionContentArray = self.sectionTitleArray! as [AnyObject]
        }
        
        for (index, object) in sectionContentArray.enumerated() {
            
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
                iconSize = self.sectionImageArray![index].size
                if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText || self.scImagePosition == .behindText {
                    contentHeight = max(iconSize.height, strSize.height)
                } else {
                    contentHeight = strSize.height + iconSize.height + self.textImageSpacing
                }
            }
            contentWidth = self.configSegmentsWidth(index: index, object: object, isNeedEdgeInset: false)
            
            var rectDiv = CGRect(x: 0, y: 0, width: 0, height: 0)
            var fullRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            
            let locationUp: CGFloat = (self.scSelectionIndicatorLocation == .up) ? 1.0 : 0.0
            let selectionStyleNotBox: CGFloat = (self.scSelectionIndicatorStyle != .box) ? 1.0 : 0.0
            
            let y = roundf(Float((self.frame.height - selectionStyleNotBox * self.selectionIndicatorHeight) / 2 - contentHeight / 2 + self.selectionIndicatorHeight * locationUp))
            var tmpRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            if self.scWidthStyle == .fixed {
                tmpRect = CGRect(x: (self.segmentWidth * CGFloat(index)) + (self.segmentWidth - contentWidth) / 2, y: CGFloat(y), width: contentWidth, height: contentHeight)
                rectDiv = CGRect(x: (self.segmentWidth * CGFloat(index)) - (self.verticalDividerWidth / 2), y: self.selectionIndicatorHeight * 2, width: self.verticalDividerWidth, height: self.frame.height - (self.selectionIndicatorHeight * 4))
                fullRect = CGRect(x: self.segmentWidth * CGFloat(index), y: 0, width: self.segmentWidth, height: oldRect.height)
            } else {
                var xOffset: CGFloat = 0.0
                var tmpIndex = 0
                for width in self.segmentWidthsArray! {
                    if index == tmpIndex {
                        break
                    }
                    xOffset += CGFloat(width.floatValue)
                    tmpIndex += 1
                }
                let widthForIndex = CGFloat(self.segmentWidthsArray![index].floatValue)
                tmpRect = CGRect(x: xOffset + (widthForIndex - contentWidth) / 2, y: CGFloat(y), width: contentWidth, height: contentHeight)
                fullRect = CGRect(x: self.segmentWidth * CGFloat(index), y: 0, width: widthForIndex, height: oldRect.height)
                rectDiv = CGRect(x: xOffset - (self.verticalDividerWidth / 2), y: self.selectionIndicatorHeight * 2, width: self.verticalDividerWidth, height: self.frame.height - (self.selectionIndicatorHeight * 4))
            }
            
            tmpRect = CGRect(x: CGFloat(ceilf(Float(tmpRect.origin.x))), y: CGFloat(ceilf(Float(tmpRect.origin.y))), width: CGFloat(ceilf(Float(tmpRect.width))), height: CGFloat(ceilf(Float(tmpRect.height))))
            
            if self.scType == .text {
                let titleLayer = CATextLayer()
                titleLayer.frame = tmpRect
                titleLayer.alignmentMode = kCAAlignmentCenter
                if Double(UIDevice.current.systemVersion)! < 10.0 {
                    titleLayer.truncationMode = kCATruncationEnd
                }
                titleLayer.string = self.attributedTitleAtIndex(index: index)
                titleLayer.contentsScale = UIScreen.main.scale
                
                self.scrollView.layer.addSublayer(titleLayer)
            }
            else if self.scType == .images {
                let icon = object as! UIImage
                let imageRect = CGRect(x: tmpRect.origin.x, y: tmpRect.origin.y, width: contentWidth, height: contentHeight)
                
                let imageLayer = CALayer()
                imageLayer.frame = imageRect
                
                if self.selectedSegmentIndex == index {
                    if self.sectionSelectedImageArray != nil {
                        let highlightIcon = self.sectionSelectedImageArray![index]
                        imageLayer.contents = highlightIcon.cgImage
                    } else {
                        imageLayer.contents = icon.cgImage
                    }
                } else {
                    imageLayer.contents = icon.cgImage
                }
                imageLayer.contentsScale = UIScreen.main.scale
                self.scrollView.layer.addSublayer(imageLayer)
            }
            else if self.scType == .textImages {
                /// 绘制title
                let titleLayer = CATextLayer()
                var titleRect = CGRect(x: 0, y: 0, width: 0, height: 0)
                if self.scImagePosition == .behindText {
                    titleRect = tmpRect
                } else if self.scImagePosition == .aboveText {
                    titleRect = CGRect(x: tmpRect.origin.x, y: tmpRect.origin.y + iconSize.height + self.textImageSpacing, width: tmpRect.width, height: strSize.height)
                } else if self.scImagePosition == .leftOfText {
                    titleRect = CGRect(x: tmpRect.origin.x + iconSize.width + self.textImageSpacing, y: tmpRect.origin.y + (tmpRect.height - strSize.height) / 2, width: strSize.width, height: strSize.height)
                } else if self.scImagePosition == .belowOfText {
                    titleRect = CGRect(x: tmpRect.origin.x, y: tmpRect.origin.y, width: tmpRect.width, height: strSize.height)
                } else if self.scImagePosition == .rightOfText {
                    titleRect = CGRect(x: tmpRect.origin.x, y: tmpRect.origin.y + (tmpRect.height - strSize.height) / 2, width: strSize.width, height: strSize.height)
                }
                titleLayer.frame = titleRect
                titleLayer.alignmentMode = kCAAlignmentCenter
                if Double(UIDevice.current.systemVersion)! < 10.0 {
                    titleLayer.truncationMode = kCATruncationEnd
                }
                titleLayer.string = self.attributedTitleAtIndex(index: index)
                titleLayer.contentsScale = UIScreen.main.scale
                
                self.scrollView.layer.addSublayer(titleLayer)
                
                /// 绘制图片
                let icon = self.sectionImageArray![index]
                var imageRect = CGRect(x: 0, y: 0, width: 0, height: 0)
                if self.scImagePosition == .behindText {
                    imageRect = CGRect(x: tmpRect.origin.x + (tmpRect.width - iconSize.width) / 2, y: tmpRect.origin.y + (tmpRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                } else if self.scImagePosition == .aboveText {
                    imageRect = CGRect(x: tmpRect.origin.x + (tmpRect.width - iconSize.width) / 2, y: tmpRect.origin.y, width: iconSize.width, height: iconSize.height)
                } else if self.scImagePosition == .leftOfText {
                    imageRect = CGRect(x: tmpRect.origin.x, y: tmpRect.origin.y + (tmpRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                } else if self.scImagePosition == .belowOfText {
                    imageRect = CGRect(x: tmpRect.origin.x + (tmpRect.width - iconSize.width) / 2, y: tmpRect.origin.y + strSize.height + self.textImageSpacing, width: iconSize.width, height: iconSize.height)
                } else if self.scImagePosition == .rightOfText {
                    imageRect = CGRect(x: tmpRect.origin.x + strSize.width + self.textImageSpacing, y: tmpRect.origin.y + (tmpRect.height - iconSize.height) / 2, width: iconSize.width, height: iconSize.height)
                }
                let imageLayer = CALayer()
                imageLayer.frame = imageRect
                
                if self.selectedSegmentIndex == index {
                    if self.sectionSelectedImageArray != nil {
                        let highlightIcon = self.sectionSelectedImageArray![index]
                        imageLayer.contents = highlightIcon.cgImage
                    } else {
                        imageLayer.contents = icon.cgImage
                    }
                } else {
                    imageLayer.contents = icon.cgImage
                }
                imageLayer.contentsScale = UIScreen.main.scale
                self.scrollView.layer.addSublayer(imageLayer)
            }
            
            if self.verticalDividerEnabled && index > 0 {
                let verticalDividerLayer = CALayer()
                verticalDividerLayer.frame = rectDiv
                verticalDividerLayer.backgroundColor = self.verticalDividerColor.cgColor
                self.scrollView.layer.addSublayer(verticalDividerLayer)
            }
            self.addBackgroundAndBorderLayerWithRect(fullRect: fullRect)
        }
        
        if self.scSelectionIndicatorStyle != .none {
            if self.scSelectionIndicatorStyle == .arrowUp || self.scSelectionIndicatorStyle == .arrowDown {
                if self.selectionIndicatorArrowLayer.superlayer == nil {
                    self.setArrowFrame()
                    self.scrollView.layer.addSublayer(self.selectionIndicatorArrowLayer)
                }
            } else {
                if self.selectionIndicatorStripLayer.superlayer == nil {
                    self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                    self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                    
                    if self.scSelectionIndicatorStyle == .box && self.selectionIndicatorBoxLayer.superlayer == nil {
                        self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                        self.scrollView.layer.insertSublayer(self.selectionIndicatorBoxLayer, at: 0)
                    }
                }
            }
        }
    }
    
    fileprivate func addBackgroundAndBorderLayerWithRect(fullRect: CGRect) {
        
        let backgroundLayer = CALayer()
        backgroundLayer.frame = fullRect
        self.layer.insertSublayer(backgroundLayer, at: 0)
        
        if self.scBorderType == .none {
            return
        }
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = self.borderColor.cgColor
        if self.scBorderType == SCBorderType.top {
            borderLayer.frame = CGRect(x: 0, y: 0, width: fullRect.width, height: self.borderWidth)
        }
        else if self.scBorderType == SCBorderType.left {
            borderLayer.frame = CGRect(x: 0, y: 0, width: self.borderWidth, height: fullRect.height)
        }
        else if self.scBorderType == SCBorderType.bottom {
            borderLayer.frame = CGRect(x: 0, y: fullRect.height - self.borderWidth, width: fullRect.width, height: self.borderWidth)
        }
        else if self.scBorderType == SCBorderType.right {
            borderLayer.frame = CGRect(x: fullRect.width - self.borderWidth, y: 0, width: self.borderWidth, height: fullRect.height)
        }
        backgroundLayer.addSublayer(borderLayer)
    }
}

// MARK: - 滑动或者选中操作
extension FWSegmentedControl {
    
    public func setSelectedSegmentIndex(index: Int, animated: Bool) {
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
                } else {
                    if self.selectionIndicatorStripLayer.superlayer == nil {
                        self.scrollView.layer.addSublayer(self.selectionIndicatorStripLayer)
                        if self.scSelectionIndicatorStyle == .box && self.selectionIndicatorBoxLayer.superlayer == nil {
                            self.scrollView.layer.insertSublayer(self.selectionIndicatorBoxLayer, at: 0)
                        }
                        self.setSelectedSegmentIndex(index: index, animated: false, notify: true)
                        return
                    }
                }
                
                if notify {
                    self.notifyForSegmentChangeToIndex(index: index)
                }
                
                // 还原CALayer
                self.selectionIndicatorArrowLayer.actions = nil
                self.selectionIndicatorStripLayer.actions = nil
                self.selectionIndicatorBoxLayer.actions = nil
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(indicatorAnimatedTimes)
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
                self.setArrowFrame()
                self.selectionIndicatorBoxLayer.frame = self.frameForSelectionIndicator()
                self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                CATransaction.commit()
            } else {
                self.selectionIndicatorArrowLayer.actions = nil
                self.setArrowFrame()
                
                self.selectionIndicatorStripLayer.actions = nil
                self.selectionIndicatorStripLayer.frame = self.frameForSelectionIndicator()
                
                self.selectionIndicatorBoxLayer.actions = nil
                self.selectionIndicatorBoxLayer.frame = self.frameForFillerSelectionIndicator()
                
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
            let enlargeRect = CGRect(x: self.bounds.origin.x - self.enlargeEdgeInset.left, y: self.bounds.origin.y - self.enlargeEdgeInset.top, width: self.bounds.width + self.enlargeEdgeInset.left + self.enlargeEdgeInset.right, height: self.bounds.height + self.enlargeEdgeInset.top + self.enlargeEdgeInset.bottom)
            
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
                }
            }
        }
    }
    
    fileprivate func scrollToSelectedSegmentIndex(animated: Bool) {
        
        var rectForSelectedIndex = CGRect(x: 0, y: 0, width: 0, height: 0)
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
            let sectionImage = self.sectionImageArray![self.selectedSegmentIndex]
            let imageWidth = sectionImage.size.width
            if self.scImagePosition == .leftOfText || self.scImagePosition == .rightOfText {
                sectionWidth = stringWidth + imageWidth + textImageSpacing
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
                
                return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left + (CGFloat(currentSegmentWidth) - tmpArrowWidth) / 2, y: indicatorYOffset, width:tmpArrowWidth  - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
            }
        } else {
            if self.scSelectionIndicatorStyle == .contentWidthStripe && sectionWidth <= self.segmentWidth && self.scWidthStyle == .fixed {
                let widthToEndOfSelectedSegment = (self.segmentWidth * CGFloat(self.selectedSegmentIndex)) + self.segmentWidth
                let widthToStartOfSelectedIndex = self.segmentWidth * CGFloat(self.selectedSegmentIndex)
                let x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) + (widthToStartOfSelectedIndex - sectionWidth / 2)
                return CGRect(x: x + self.selectionIndicatorEdgeInsets.left, y: indicatorYOffset, width: sectionWidth - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight)
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
                        if self.scType == .text {
                            contentWidth = self.measureTitleAtIndex(index: self.selectedSegmentIndex).width
                        } else if self.scType == .images {
                            let icon = self.sectionImageArray![self.selectedSegmentIndex]
                            contentWidth = icon.size.width
                        } else if self.scType == .textImages {
                            contentWidth = self.configSegmentsWidth(index: self.selectedSegmentIndex, object: self.sectionTitleArray![self.selectedSegmentIndex] as AnyObject, isNeedEdgeInset: false)
                        }
                        return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left + (CGFloat(currentSegmentWidth) - contentWidth) / 2, y: indicatorYOffset, width: contentWidth - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
                    }
                    else if self.scSelectionIndicatorStyle == .fullWidthStripe {
                        return CGRect(x: selectedSegmentOffset + self.selectionIndicatorEdgeInsets.left, y: indicatorYOffset, width: CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue) - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight + self.selectionIndicatorEdgeInsets.bottom)
                    }
                }
                return CGRect(x: (self.segmentWidth + self.selectionIndicatorEdgeInsets.left) * CGFloat(self.selectedSegmentIndex), y: indicatorYOffset, width: self.segmentWidth - self.selectionIndicatorEdgeInsets.right, height: self.selectionIndicatorHeight)
            }
        }
    }
    
    fileprivate func frameForFillerSelectionIndicator() -> CGRect {
        
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
            
            return CGRect(x: selectedSegmentOffset, y: 0, width: CGFloat(self.segmentWidthsArray![self.selectedSegmentIndex].floatValue), height: self.frame.height)
        }
        return CGRect(x: self.segmentWidth * CGFloat(self.selectedSegmentIndex), y: 0.0, width: self.segmentWidth, height: self.frame.height)
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
            return CGSize(width: 0, height: 0)
        }
        
        let title: String = self.sectionTitleArray![index]
        var size = CGSize(width: 0, height: 0)
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

