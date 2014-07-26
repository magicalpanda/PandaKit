//
//  ZoomModalPresentingTransitioningAnimator.h
//  TransitionAnimatorPlayground
//
//  Created by Saul Mora on 3/3/14.
//  Copyright (c) 2014 Magical Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPZoomModalPresentingTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (id) initWithSourceView:(UIView *)view;

@end
