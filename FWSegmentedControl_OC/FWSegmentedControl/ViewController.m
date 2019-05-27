//
//  ViewController.m
//  FWSegmentedControl
//
//  Created by xfg on 2018/3/16.
//  Copyright © 2018年 xfg. All rights reserved.
//

#import "ViewController.h"
#import "FWSegmentedControl-Swift.h"
#import <FWSegmentedControl/FWSegmentedControl-Swift.h>
#import "ViewController2.h"

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView          *scrollView;                // ScrollView
@property (nonatomic, strong) NSArray               *sectionTitles3;

@property (nonatomic, assign) NSInteger             startPage;                  // Segmented的滑块起始页
@property (nonatomic, assign) BOOL                  isClickedSegmented;         // 是否点击了Segmented的滑块

@property (nonatomic, strong) FWSegmentedControl    *segmentedControl7;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.navigationItem.title = @"FWSegmentedControl";
    
    NSArray *images2 = @[[UIImage imageNamed:@"a"], [UIImage imageNamed:@"b"], [UIImage imageNamed:@"c"]];
    
    NSArray *selectedImages2 = @[[UIImage imageNamed:@"a-selected"], [UIImage imageNamed:@"b-selected"], [UIImage imageNamed:@"c-selected"]];
    
    self.sectionTitles3 = @[@"福建", @"直播", @"小视频"];
    
    
    // 例一
    NSArray *sectionTitles = @[@"关注", @"游戏", @"附近", @"体育", @"女神范", @"运动啦啦", @"歌舞", @"吃鸡", @"户外", @"脱口秀"];
    FWSegmentedControl *segmentedControl = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:nil sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, 0, self.view.frame.size.width, 50)];

    segmentedControl.sectionTitleArray = sectionTitles;
    segmentedControl.scSelectionIndicatorStyle = SCSelectionIndicatorStyleFullWidthStripe;

    [self.view addSubview:segmentedControl];



    // 例二
    FWSegmentedControl *segmentedControl2 = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:sectionTitles sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, CGRectGetMaxY(segmentedControl.frame) + 10, self.view.frame.size.width, 40)];

    segmentedControl2.selectedSegmentIndex = 1;

    segmentedControl2.scSelectionIndicatorStyle = SCSelectionIndicatorStyleContentWidthStripe;
    segmentedControl2.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    segmentedControl2.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    segmentedControl2.selectionIndicatorColor = UIColor.redColor;
    segmentedControl2.selectionIndicatorHeight = 3;

    segmentedControl2.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    segmentedControl2.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    [self.view addSubview:segmentedControl2];



    // 例三
    NSArray *sectionTitles2 = @[@"女神", @"运动啦啦", @"歌舞"];

    FWSegmentedControl *segmentedControl3 = [FWSegmentedControl segmentedWithScType:SCTypeText scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:sectionTitles2 sectionImageArray:nil sectionSelectedImageArray:nil frame:CGRectMake(0, CGRectGetMaxY(segmentedControl2.frame) + 10, self.view.frame.size.width, 40)];

    segmentedControl3.scSelectionIndicatorStyle = SCSelectionIndicatorStyleBox;
    segmentedControl3.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    segmentedControl3.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    segmentedControl3.selectionIndicatorColor = UIColor.redColor;
    segmentedControl3.selectionIndicatorHeight = 3;

    segmentedControl3.selectionIndicatorBoxColor = UIColor.greenColor;
    segmentedControl3.selectionIndicatorBoxOpacity = 0.4;

    segmentedControl3.verticalDividerEnabled = YES;
    segmentedControl3.verticalDividerColor = UIColor.lightGrayColor;
    segmentedControl3.verticalDividerWidth = 1.0;

    segmentedControl3.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    segmentedControl3.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    [self.view addSubview:segmentedControl3];



    // 例四
    NSArray *images = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"], [UIImage imageNamed:@"5"], [UIImage imageNamed:@"6"], [UIImage imageNamed:@"7"]];

    NSArray *selectedImages = @[[UIImage imageNamed:@"1-selected"], [UIImage imageNamed:@"2-selected"], [UIImage imageNamed:@"3-selected"], [UIImage imageNamed:@"4-selected"], [UIImage imageNamed:@"5-selected"], [UIImage imageNamed:@"6-selected"], [UIImage imageNamed:@"7-selected"]];

    FWSegmentedControl *segmentedControl4 = [FWSegmentedControl segmentedWithScType:SCTypeImages scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:nil sectionImageArray:images sectionSelectedImageArray:selectedImages frame:CGRectMake(0, CGRectGetMaxY(segmentedControl3.frame) + 10, self.view.frame.size.width, 40)];

    segmentedControl4.scSelectionIndicatorStyle = SCSelectionIndicatorStyleContentWidthStripe;
    segmentedControl4.scSelectionIndicatorLocation = SCSelectionIndicatorLocationUp;
    segmentedControl4.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    segmentedControl4.selectionIndicatorColor = UIColor.redColor;
    segmentedControl4.selectionIndicatorHeight = 5;

    segmentedControl4.verticalDividerEnabled = YES;
    segmentedControl4.verticalDividerColor = UIColor.lightGrayColor;
    segmentedControl4.verticalDividerWidth = 1.0;

    [self.view addSubview:segmentedControl4];


    // 例五
    NSDictionary *sectionSelectedImageDict = @{@(0) : [[FWSectionImageItem alloc] initWithItemImage:[UIImage imageNamed:@"hm_hot_city"] itemSelectedImage:[UIImage imageNamed:@"hm_hot_city_selected"]]};

    FWSegmentedControl *segmentedControl5 = [FWSegmentedControl segmentedWithScType:SCTypeTextImages scWidthStyle:SCWidthStyleDynamic sectionTitleArray:self.sectionTitles3 sectionSelectedImageDict:sectionSelectedImageDict frame:CGRectMake(0, CGRectGetMaxY(segmentedControl4.frame) + 10, self.view.frame.size.width, 40)];

    segmentedControl5.scSelectionIndicatorStyle = SCSelectionIndicatorStyleContentWidthStripe;
    segmentedControl5.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    segmentedControl5.scImagePosition = SCImagePositionLeftOfText;
    segmentedControl5.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    segmentedControl5.selectionIndicatorColor = UIColor.redColor;
    segmentedControl5.selectionIndicatorHeight = 3;

    segmentedControl5.textImageSpacing = 4;

    segmentedControl5.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    segmentedControl5.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    [self.view addSubview:segmentedControl5];


    // 例六
    FWSegmentedControl *segmentedControl6 = [FWSegmentedControl segmentedWithScType:SCTypeTextImages scWidthStyle:SCWidthStyleFixed sectionTitleArray:self.sectionTitles3 sectionImageArray:images2 sectionSelectedImageArray:selectedImages2 frame:CGRectMake(0, CGRectGetMaxY(segmentedControl5.frame) + 10, self.view.frame.size.width, 50)];

    segmentedControl6.scSelectionIndicatorStyle = SCSelectionIndicatorStyleArrowDown;
    segmentedControl6.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    segmentedControl6.scImagePosition = SCImagePositionAboveText;
    segmentedControl6.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    segmentedControl6.selectionIndicatorColor = UIColor.redColor;
    segmentedControl6.selectionIndicatorHeight = 5;
    segmentedControl6.arrowWidth = 15.0;

    segmentedControl6.verticalDividerEnabled = YES;
    segmentedControl6.verticalDividerColor = UIColor.lightGrayColor;
    segmentedControl6.verticalDividerWidth = 1.0;

    segmentedControl6.textImageSpacing = 4;

    segmentedControl6.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    segmentedControl6.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    [self.view addSubview:segmentedControl6];
    
    
    // 例七
    self.segmentedControl7 = [FWSegmentedControl segmentedWithScType:SCTypeTextImages scWidthStyle:SCWidthStyleDynamicFixedSuper sectionTitleArray:self.sectionTitles3 sectionImageArray:images2 sectionSelectedImageArray:selectedImages2 frame:CGRectMake(0, CGRectGetMaxY(segmentedControl6.frame) + 10, self.view.frame.size.width, 40)];

    self.segmentedControl7.scSelectionIndicatorStyle = SCSelectionIndicatorStyleFullWidthStripe;
    self.segmentedControl7.scSelectionIndicatorLocation = SCSelectionIndicatorLocationDown;
    self.segmentedControl7.scImagePosition = SCImagePositionRightOfText;
    self.segmentedControl7.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);

    self.segmentedControl7.selectionIndicatorColor = UIColor.redColor;
    self.segmentedControl7.selectionIndicatorHeight = 3;

    self.segmentedControl7.verticalDividerEnabled = YES;
    self.segmentedControl7.verticalDividerColor = UIColor.lightGrayColor;
    self.segmentedControl7.verticalDividerWidth = 1.0;

    self.segmentedControl7.textImageSpacing = 4;

    self.segmentedControl7.titleTextAttributes = @{NSForegroundColorAttributeName: UIColor.grayColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    self.segmentedControl7.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor, NSFontAttributeName: [UIFont systemFontOfSize:13.0]};

    __weak typeof(self) ws = self;
    self.segmentedControl7.indexChangeBlock = ^(NSInteger index) {

        ws.isClickedSegmented = YES;
        [ws.scrollView scrollRectToVisible:CGRectMake(ws.view.frame.size.width * index, 0, ws.view.frame.size.width, CGRectGetHeight(ws.scrollView.frame)) animated:YES];
    };

    [self.view addSubview:self.segmentedControl7];
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl7.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.segmentedControl7.frame))];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * [self.sectionTitles3 count], CGRectGetHeight(self.scrollView.frame));
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight(self.scrollView.frame)) animated:NO];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:[self setupUIView:0]];
    [self.scrollView addSubview:[self setupUIView:1]];
    [self.scrollView addSubview:[self setupUIView:2]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"多级联动>" style:UIBarButtonItemStylePlain target:self action:@selector(goNextVC)];
}

- (UILabel *)setupUIView:(int)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * index, 0, self.view.frame.size.width, CGRectGetHeight(self.scrollView.frame))];
    label.text = self.sectionTitles3[index];
    label.textColor = UIColor.whiteColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:(float)(1+arc4random()%99)/100 green:(float)(1+arc4random()%99)/100 blue:(float)(1+arc4random()%99)/100 alpha:1];
    return label;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.isClickedSegmented)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger tmpPage = scrollView.contentOffset.x / pageWidth;
        float tmpPage2 = scrollView.contentOffset.x / pageWidth;
        NSInteger page = tmpPage2-tmpPage>=0.5 ? tmpPage+1 : tmpPage;
        
        if (_startPage != page)
        {
            [self.segmentedControl7 setSelectedSegmentIndexWithIndex:page animated:YES];
            _startPage = page;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    self.isClickedSegmented = NO;
    
    [self.segmentedControl7 setSelectedSegmentIndexWithIndex:page animated:YES];
}

- (void)goNextVC
{
    [self.navigationController pushViewController:[[ViewController2 alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
