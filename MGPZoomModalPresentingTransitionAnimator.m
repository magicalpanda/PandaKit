//
//  ZoomModalPresentingTransitioningAnimator.m
//  TransitionAnimatorPlayground
//
//  Created by Saul Mora on 3/3/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

#import "MGPZoomModalPresentingTransitionAnimator.h"
#import "MGPZoomModalTransitioningDelegate.h"


@interface MGPZoomModalPresentingTransitionAnimator ()

@property (nonatomic, strong) UIView *sourceView;

@end


@implementation MGPZoomModalPresentingTransitionAnimator

- (id) initWithSourceView:(UIView *)view;
{
    self = [super init];
    if (self)
    {
        self.sourceView = view;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
{
    return .3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
{
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    CGRect sourceViewFrame = [[transitionContext containerView] convertRect:self.sourceView.frame
                                                                   fromView:[fromViewController view]];

    CGRect fromFrame = toViewController.view.frame;
    CGRect toFrame = toViewController.view.frame;

    CGFloat scaleX = toFrame.size.width / sourceViewFrame.size.width;
    CGFloat scaleY = toFrame.size.height / sourceViewFrame.size.height;

    CGPoint sourceCenter = CGRectCenter(sourceViewFrame);
    CGPoint fromCenter = CGRectCenter(fromFrame);

    CGFloat translateX = sourceCenter.x - fromCenter.x;
    CGFloat translateY = sourceCenter.y - fromCenter.y;

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1/scaleX, 1/scaleY);
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(translateX, translateY);
    CGAffineTransform startingTransform = CGAffineTransformConcat(scaleTransform, translateTransform);

    UIView *snapshotView = [toViewController view];
    snapshotView.alpha = 0;
    snapshotView.transform = startingTransform;
    [[transitionContext containerView] addSubview:snapshotView];

    [UIView animateWithDuration:duration/2 animations:^{
        snapshotView.alpha = 1;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:duration animations:^{

            snapshotView.center = [[transitionContext containerView] center];
            snapshotView.transform = CGAffineTransformIdentity;

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }];
}

@end
