//
//  ZoomModalDismissingTransitionAnimator.m
//  TransitionAnimatorPlayground
//
//  Created by Saul Mora on 3/3/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

#import "MGPZoomModalDismissingTransitionAnimator.h"
#import "MGPZoomModalTransitioningDelegate.h"


@interface MGPZoomModalDismissingTransitionAnimator ()

@property (nonatomic, strong) UIView *sourceView;

@end


@implementation MGPZoomModalDismissingTransitionAnimator

- (id) initWithSourceView:(UIView *)view;
{
    self = [super init];
    if (self)
    {
        self.sourceView = view;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
{
    return .3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;
{
    CGFloat duration = [self transitionDuration:transitionContext];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    [[transitionContext containerView] addSubview:fromViewController.view];

    CGRect fromFrame = fromViewController.view.frame;
    CGRect toFrame = toViewController.view.frame;
    CGRect sourceViewFrame = [[transitionContext containerView] convertRect:self.sourceView.frame
                                                                   fromView:[fromViewController view]];

    CGFloat scaleX = toFrame.size.width / sourceViewFrame.size.width;
    CGFloat scaleY = toFrame.size.height / sourceViewFrame.size.height;

    CGPoint sourceCenter = CGRectCenter(sourceViewFrame);
    CGPoint fromCenter = CGRectCenter(fromFrame);

    CGFloat translateX = sourceCenter.x - fromCenter.x;
    CGFloat translateY = sourceCenter.y - fromCenter.y;

    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1/scaleX, 1/scaleY);
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(translateX, translateY);
    CGAffineTransform endingTransform = CGAffineTransformConcat(scaleTransform, translateTransform);

    toViewController.view.alpha = 0;

    [UIView animateWithDuration:duration animations:^{

        toViewController.view.alpha = 1;
        fromViewController.view.transform = endingTransform;

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/2 animations:^{
            fromViewController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }];
}

@end
