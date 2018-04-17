//
//  ViewController2.m
//  FWSegmentedControl
//
//  Created by 叶子 on 2018/3/20.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "ViewController2.h"
#import <FWSegmentedControl/FWSegmentedControl-Swift.h>

#define segmentedControlHeight 40
#define segmentedControl2Height 40

@interface ViewController2 () <UIScrollViewDelegate>

@property (nonatomic, strong) FWSegmentedControl    *segmentedControl;
@property (nonatomic, strong) UIScrollView          *scrollView;                // ScrollView

@property (nonatomic, strong) NSArray               *sectionTitles;
@property (nonatomic, strong) NSArray               *sectionTitles2;
@property (nonatomic, strong) NSArray               *sectionTitles3;

@property (nonatomic, strong) NSMutableArray        *segmentedControlArray;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    self.sectionTitles = @[@"yezi", @"开发语言"];
    self.sectionTitles2 = @[@"叶子", @"椰子啦", @"叶紫", @"叶梓"];
    self.sectionTitles3 = @[@"Swift", @"OC", @"Android", @"RN"];
    
    self.segmentedControlArray = [NSMutableArray array];
    
    
    self.segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:self.sectionTitles sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, 0, self.view.frame.size.width, segmentedControlHeight)];
    
    self.segmentedControl.scSelectionIndicatorStyle = SCSelectionIndicatorStyleFullWidthStripe;
    self.segmentedControl.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    self.segmentedControl.selectionIndicatorColor = UIColor.redColor;
    self.segmentedControl.selectionIndicatorHeight = 3;
    
    self.segmentedControl.verticalDividerEnabled = YES;
    self.segmentedControl.verticalDividerColor = UIColor.lightGrayColor;
    self.segmentedControl.verticalDividerWidth = 1.0;
    
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    
    __weak typeof(self) ws = self;
    self.segmentedControl.indexChangeBlock = ^(NSInteger index) {
        
        [ws.scrollView scrollRectToVisible:CGRectMake(ws.view.frame.size.width * index, 0, ws.view.frame.size.width, CGRectGetHeight(ws.scrollView.frame)) animated:YES];
    };
    
    [self.view addSubview:self.segmentedControl];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), self.view.frame.size.width, 1)];
    lineView.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:lineView];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame)+1, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.segmentedControl.frame))];
    self.scrollView.tag = 0;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * [self.sectionTitles count], CGRectGetHeight(self.scrollView.frame));
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(self.scrollView.frame)) animated:NO];
    [self.view addSubview:self.scrollView];
    
    FWSegmentedControl *segmentedControl2 = [self setupSegmentedControl:0 sectionTitleArray:self.sectionTitles2];
    FWSegmentedControl *segmentedControl3 = [self setupSegmentedControl:1 sectionTitleArray:self.sectionTitles3];
    
    [self.segmentedControlArray addObject:segmentedControl2];
    [self.segmentedControlArray addObject:segmentedControl3];
    
    [self.scrollView addSubview:segmentedControl2];
    [self.scrollView addSubview:segmentedControl3];
    
}

- (FWSegmentedControl *)setupSegmentedControl:(int)index sectionTitleArray:(NSArray *)sectionTitleArray
{
    FWSegmentedControl *segmentedControl2 = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:sectionTitleArray sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(self.view.frame.size.width * index, 0, self.view.frame.size.width, segmentedControl2Height)];
    
    segmentedControl2.scSelectionIndicatorStyle = SCSelectionIndicatorStyleFullWidthStripe;
    segmentedControl2.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    segmentedControl2.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    segmentedControl2.selectionIndicatorColor = UIColor.redColor;
    segmentedControl2.selectionIndicatorHeight = 3;
    
    segmentedControl2.verticalDividerEnabled = YES;
    segmentedControl2.verticalDividerColor = UIColor.lightGrayColor;
    segmentedControl2.verticalDividerWidth = 1.0;
    
    segmentedControl2.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    segmentedControl2.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    
    UIScrollView *scrollView2 = [self setupScrollView:index sectionTitleArray:sectionTitleArray];
    [self.scrollView addSubview:scrollView2];
    
    __weak typeof(self) ws = self;
    segmentedControl2.indexChangeBlock = ^(NSInteger index) {
        
        [scrollView2 scrollRectToVisible:CGRectMake(ws.view.frame.size.width * index, 0, ws.view.frame.size.width, CGRectGetHeight(scrollView2.frame)) animated:YES];
    };
    
    return segmentedControl2;
}

- (UIScrollView *)setupScrollView:(int)index sectionTitleArray:(NSArray *)sectionTitleArray
{
    UIScrollView *scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * index, segmentedControl2Height, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.segmentedControl.frame) - segmentedControl2Height)];
    
    scrollView2.tag = 1 + index;
    
    scrollView2.delegate = self;
    scrollView2.backgroundColor = UIColor.clearColor;
    scrollView2.pagingEnabled = YES;
    scrollView2.showsHorizontalScrollIndicator = NO;
    scrollView2.bounces = NO;
    scrollView2.contentSize = CGSizeMake(self.view.frame.size.width * [sectionTitleArray count], CGRectGetHeight(scrollView2.frame));
    [scrollView2 scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(scrollView2.frame)) animated:NO];
    [self.view addSubview:scrollView2];
    
    for (int i = 0; i < sectionTitleArray.count; i++) {
        [scrollView2 addSubview:[self setupLabel:i title:sectionTitleArray[i]]];
    }
    
    return scrollView2;
}

- (UILabel *)setupLabel:(int)index title:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * index, 0, self.view.frame.size.width, CGRectGetHeight(self.scrollView.frame))];
    label.text = self.sectionTitles3[index];
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
    return label;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = scrollView.frame.size.width;
//    NSInteger tmpPage = scrollView.contentOffset.x / pageWidth;
//    float tmpPage2 = scrollView.contentOffset.x / pageWidth;
//    NSInteger page = tmpPage2-tmpPage>=0.5 ? tmpPage+1 : tmpPage;
//    if (scrollView.tag == 0) {
//        [self.segmentedControl setSelectedSegmentIndexWithIndex:page animated:YES];
//    } else {
//        FWSegmentedControl *segmentedControll = self.segmentedControlArray[scrollView.tag-1];
//        [segmentedControll setSelectedSegmentIndexWithIndex:page animated:YES];
//    }
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    if (scrollView.tag == 0) {
        [self.segmentedControl setSelectedSegmentIndexWithIndex:page animated:YES];
    } else {
        FWSegmentedControl *segmentedControll = self.segmentedControlArray[scrollView.tag-1];
        [segmentedControll setSelectedSegmentIndexWithIndex:page animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
