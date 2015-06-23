//
//  ViewController.m
//  CWXProgressView
//
//  Created by Aslan on 20/6/15.
//  Copyright (c) 2015 ___com.aslan__. All rights reserved.
//

#import "ViewController.h"
#import "CWXProgressView.h"

@interface ViewController ()

@property (strong, nonatomic) CWXProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.progressView];
    self.progressView.center = self.view.center;
    self.progressView.percent = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.progressView.percent = 80;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(17 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.progressView stopUpdate];
    });
}

- (CWXProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[CWXProgressView alloc] init];
    }
    return _progressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
