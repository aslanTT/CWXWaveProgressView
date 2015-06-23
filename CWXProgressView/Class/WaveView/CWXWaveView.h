//
//  CWXWaveView.h
//  CWXProgressView
//
//  Created by Aslan on 23/6/15.
//  Copyright (c) 2015 ___com.aslan__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWXWaveView : UIView

@property (nonatomic, assign) CGFloat progress; //[0~100]
@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, assign) CGFloat maxWaveAmplitude;
@property (nonatomic, assign) CGFloat minWaveAmplitude;

- (void)wave;
- (void)stopWave;

@end
