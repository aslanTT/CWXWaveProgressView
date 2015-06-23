//
//  CWXProgressView.h
//  CWXProgressView
//
//  Created by Aslan on 20/6/15.
//  Copyright (c) 2015 ___com.aslan__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWXProgressView : UIView

@property (nonatomic, assign) NSInteger percent;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

- (void)stopUpdate;

@end
