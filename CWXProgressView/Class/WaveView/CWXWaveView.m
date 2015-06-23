//
//  CWXWaveView.m
//  CWXProgressView
//
//  Created by Aslan on 23/6/15.
//  Copyright (c) 2015 ___com.aslan__. All rights reserved.
//

#import "CWXWaveView.h"

@interface CWXWaveView ()

@property (nonatomic, assign) CGFloat wavePointY;
@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveAmplitude;
@property (nonatomic, assign) BOOL amplitudeUp;
@property (nonatomic, assign) CGFloat radius; // 水波半径
@property (nonatomic, assign) CGFloat offsetY; // 水波位移
@property (nonatomic, strong) NSTimer *waveTimer;

@end

@implementation CWXWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor clearColor];
    
    self.waveAmplitude = 1.0f;
    self.progress = 0.0f;
    self.offsetY = 0;
    self.maxWaveAmplitude = 8;
    self.minWaveAmplitude = 5;
    self.radius = self.waveWidth / 2;
    self.waveWidth = self.frame.size.width;
    self.waveHeight = self.frame.size.height / 2;
    self.fillColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
}

- (void)setWaveWidth:(CGFloat)waveWidth
{
    _waveWidth = waveWidth;
    self.radius = _waveWidth / 2;
}

- (void)wave
{
    self.waveTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(animateWave:) userInfo:nil repeats:YES];
    [self.waveTimer fire];
}

- (void)stopWave
{
    [self.waveTimer invalidate];
    self.waveTimer = nil;
}

- (void)animateWave:(NSTimer *)timer
{
    if (timer == self.waveTimer) {
        
        if (self.amplitudeUp) {
            self.waveAmplitude += 0.05;
        } else {
            self.waveAmplitude -= 0.05;
        }
        
        if (self.waveAmplitude <= self.minWaveAmplitude) {
            self.amplitudeUp = YES;
        }
        
        if (self.waveAmplitude >= self.maxWaveAmplitude) {
            self.amplitudeUp = NO;
        }
        
        self.offsetY += 0.4;
        self.currentProgress = (self.wavePointY + self.radius) / (2 * self.radius) * 100;

        if (self.currentProgress < self.progress) {
            self.wavePointY += self.radius * 0.01;
        }
        
        if (self.currentProgress > self.progress) {
            self.wavePointY = (self.progress / 100 * (2 * self.radius)) - self.radius;
        }
        [self setNeedsDisplay];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGContextSetFillColorWithColor(context, [self.fillColor CGColor]); // 指定颜色
    CGContextFillEllipseInRect(context, CGRectMake(0,
                                                   0,
                                                   self.waveWidth,
                                                   self.waveHeight * 2));
    //画水
    CGContextSetFillColorWithColor(context, [[UIColor orangeColor] CGColor]); // 指定颜色
    CGContextSetLineWidth(context, 1); // 指定宽度
    
    CGFloat y = self.waveHeight; // 水钟中心高度
    
    CGPathMoveToPoint(path, NULL, 0, self.waveHeight - 7.5);  // 移动虚拟笔到起点
    
    for (CGFloat x = 0; x <= self.waveWidth; x++) {
        y = self.waveAmplitude * sin( x / 180 * M_PI + 4 * self.offsetY / M_PI ) + self.waveHeight - 7.5;  // a是幅度，b是位移
        CGPathAddLineToPoint(path, nil, x, y - self.wavePointY); // 从上一终点绘制到目标点
    }
    
    CGPathAddLineToPoint(path, nil, self.waveWidth, self.waveHeight - self.radius);
    CGPathAddLineToPoint(path, nil, 0, self.waveHeight - self.radius);
    CGPathAddLineToPoint(path, nil, 0, self.waveHeight - 7.5);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

- (void)dealloc
{
    [self stopWave];
}

@end