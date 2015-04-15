//
//  ViewController.h
//  Funny Clip
//
//  Created by NhanNLT on 4/15/15.
//  Copyright (c) 2015 NhanNLT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseViewControllerDelegate <NSObject>
@end
@interface BaseViewController : UIViewController
{

}
@property (nonatomic,weak) id<BaseViewControllerDelegate> delegate;
@end

