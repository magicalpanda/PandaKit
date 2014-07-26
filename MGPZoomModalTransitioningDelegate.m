//
//  ZoomModalTransitioningDelegate.m
//  TransitionAnimatorPlayground
//
//  Created by Saul Mora on 3/3/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

#import "MGPZoomModalTransitioningDelegate.h"
#import "MGPZoomModalDismissingTransitionAnimator.h"
#import "MGPZoomModalPresentingTransitionAnimator.h"


CGPoint CGRectCenter(CGRect rect)
{
    CGPoint center = CGPointZero;

    center.x = rect.origin.x + rect.size.width/2;
    center.y = rect.origin.y + rect.size.height/2;

    return center;
}

@interface MGPZoomModalTransitioningDelegate ()

@property (nonatomic, weak) UIView *sourceView;

@end


@implementation MGPZoomModalTransitioningDelegate

- (id) initWithSourceView:(UIView *)view;
{
    self = [super init];
    if (self)
    {
        self.sourceView = view;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
{
    return [[MGPZoomModalPresentingTransitionAnimator alloc] initWithSourceView:self.sourceView];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
{
    return [[MGPZoomModalDismissingTransitionAnimator alloc] initWithSourceView:self.sourceView];
}

@end
