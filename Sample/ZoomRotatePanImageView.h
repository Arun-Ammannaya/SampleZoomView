//
//  DrawingView.h
//  Sample
//
//  Created by Aruna M on 15/01/16.
//  Copyright © 2016 aaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomRotatePanImageView : UIImageView <UIGestureRecognizerDelegate> {
    
@protected
    UIPinchGestureRecognizer *_pinchRecogniser;
    UIRotationGestureRecognizer *_rotateRecogniser;
    UIPanGestureRecognizer *_panRecogniser;
    UITapGestureRecognizer *_tapRecogniser;
}


- (void) reset;
- (void) resetWithAnimation:(BOOL)animation;

@end