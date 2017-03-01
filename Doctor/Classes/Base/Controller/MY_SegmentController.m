//
//  MY_SegmentController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SegmentController.h"
#import "MY_BaseTableController.h"

@interface MY_SegmentController () <MY_SegmentContentViewDelegate> {
    CGFloat _height;
    MY_SegmentLoadStyle _loadStyle;
}

@end

@implementation MY_SegmentController

- (id)initWithViewControllers:(NSArray *)viewControllers segmentViewHeight:(CGFloat)height {
    if (self = [super init]){
        _viewControllers = viewControllers;
        _height = height;
        _loadStyle = MY_SegmentLoadStyle_CurrentPage;
    }
    return self;
}

- (id)initWithViewControllers:(NSArray *)viewControllers segmentViewHeight:(CGFloat)height loadStyle:(MY_SegmentLoadStyle)loadstyle {
    if (self = [super init]){
        _viewControllers = viewControllers;
        _height = height;
        _loadStyle = loadstyle;
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, _height)];
    self.segmentView.clipsToBounds = NO;
    
    self.view.clipsToBounds = YES;
    self.segmentContentView = [[MY_SegmentContentView alloc] initWithFrame:(CGRect){{0,_height}, {MY_ScreenWidth, MY_ScreenHeight - _height}}];
    [_segmentContentView setDelegate:self];
    self.segmentContentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_segmentContentView];
    [self.view addSubview:_segmentView];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    
    if (_loadStyle == MY_SegmentLoadStyle_CurrentPage) {
        
        MY_BaseTableController *vc = [_viewControllers firstObject];
        [views addObject:vc.view];
        
        for (NSInteger i = 1 ; i < _viewControllers.count ; i++){
            
            UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
            view.backgroundColor = [UIColor clearColor];
            [views addObject:view];
        }
        
        [_segmentContentView setViews:views];
        return;
    }
    
    
    for (NSInteger i = 0 ; i < _viewControllers.count ; i++){
        
        MY_BaseTableController *vc = [_viewControllers objectAtIndex:i];
        
        [views addObject:vc.view];
        
        if ([vc isMemberOfClass:[MY_BaseTableController class]]) {
            if (i == 0) {
                vc.tableView.scrollsToTop = YES;
            }
            else {
                vc.tableView.scrollsToTop = NO;
            }
        }
    }
    
    [_segmentContentView setViews:views];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIViewController *vc in _viewControllers){
        [vc viewWillAppear:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.segmentContentView.selectPage < _viewControllers.count && self.segmentContentView.selectPage > 0) {
        UIViewController *currentViewController = [_viewControllers objectAtIndex:self.segmentContentView.selectPage];
        [currentViewController viewDidAppear:animated];
    }
}

- (void)hideSegmentView {
    if (!_segmentView.hidden) {
        _segmentView.alpha = 1.0;
        [UIView animateWithDuration:.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _segmentView.alpha = 0;
        } completion:^(BOOL finished) {
            _segmentView.hidden = YES;
            _segmentView.alpha = 1;
        }];
    }
}

-(void)showSegmentView {
    if (_segmentView.hidden) {
        _segmentView.hidden = NO;
        _segmentView.alpha = 0.0;
        [UIView animateWithDuration:.0 animations:^{
            _segmentView.alpha = 1.0;
        }];
    }
}

- (void)setSelectedAt:(NSInteger)index {
    self.segmentContentView.selectPage = index;
}

-(void)setSegmentViewIndex:(NSInteger)index
{
    
}

-(void)setSegmentViewOffsetX:(NSUInteger)offsetX{
    
}

- (void)segmentContentView:(MY_SegmentContentView *)segmentContentView selectPage:(NSUInteger)page{
    if (_loadStyle == MY_SegmentLoadStyle_CurrentPage) {
        NSMutableArray *views = [NSMutableArray arrayWithCapacity:_viewControllers.count];
        views = _segmentContentView.views;
        MY_BaseTableController *vc = [_viewControllers objectAtIndex:page];
        if (![views containsObject:vc.view]) {
            UIView *view = [_segmentContentView.views objectAtIndex:page];
            [views insertObject:vc.view atIndex:page];
            [views removeObject:view];
            [_segmentContentView setViews:views];
        }
    }
    
    [self setSegmentViewIndex:page];
}

- (void)segmentContentView:(MY_SegmentContentView *)segmentContentView selectOffsetX:(NSUInteger)offsetX{
    [self setSegmentViewOffsetX:offsetX];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        if (gestureRecognizer.state == UIGestureRecognizerStatePossible && self.segmentContentView.scrollView.contentOffset.x <300.0) {
            self.segmentContentView.scrollView.panGestureRecognizer.enabled=NO;
            return YES;
        }
        self.segmentContentView.scrollView.panGestureRecognizer.enabled=YES;
    }
    
    return NO;
}


@end
