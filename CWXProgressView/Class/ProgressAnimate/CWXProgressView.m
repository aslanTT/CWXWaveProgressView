//
//  CWXProgressView.m
//  CWXProgressView
//
//  Created by Aslan on 20/6/15.
//  Copyright (c) 2015 ___com.aslan__. All rights reserved.
//

#import "CWXProgressView.h"
#import "UIViewAdditions.h"
#import "CWXWaveView.h"

@interface CWXProgressView ()

@property (nonatomic, strong) CWXWaveView *waveView;
@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation CWXProgressView

- (void)dealloc
{
    [self stopUpdate];
    [self.waveView removeObserver:self forKeyPath:@"currentProgress"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"CWXProgressView" owner:nil options:nil][0];
        self.frame = CGRectMake(0, 0, 125, 125);
        [self loadView];
        self.percent = 0;
        self.percentLabel.text = [NSString stringWithFormat:@"%@%%", @(0)];
        self.isAnimation = YES;
        [self addCircleRotate];
        [self updatePercent];
        
        [self.waveView addObserver:self
                        forKeyPath:@"currentProgress"
                           options:NSKeyValueObservingOptionNew
                           context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.waveView) {
        if ([keyPath isEqualToString:@"currentProgress"]) {
            self.percentLabel.text = [NSString stringWithFormat:@"%@%%", @((NSInteger)self.waveView.currentProgress)];
        }
    }
}

- (void)loadView
{
    self.leftView.layer.cornerRadius = 115/2.0;
    self.leftView.clipsToBounds = YES;
    CWXWaveView *waveView = [[CWXWaveView alloc] initWithFrame:CGRectMake(0, 0, self.leftView.width, self.leftView.height)];
    waveView.backgroundColor = [UIColor clearColor];
    [self.leftView addSubview:waveView];
    self.waveView = waveView;
    [self.waveView wave];
}

- (void)addCircleRotate
{
    if (self.isAnimation) {
        [UIView animateWithDuration:1 animations:^{
            self.rotateImageView.transform = CGAffineTransformRotate(self.rotateImageView.transform, 1*M_PI);
        } completion:^(BOOL finished) {
            [self addCircleRotate];
        }];
    }
}

- (void)setPercent:(NSInteger)percent
{
    _percent = percent;
    [self updatePercent];
}

- (void)updatePercent
{
    CGFloat avgScore = self.percent;
    self.waveView.progress = avgScore;
}

- (void)stopUpdate
{
    self.isAnimation = NO;
    [self.rotateImageView.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    [self.waveView stopWave];
}

@end