//
//  AppDelegate.h
//  week6
//
//  Created by Phuong Nguyen on 4/10/15.
//  Copyright (c) 2015 phuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong) Note * doc;
@property (strong) NSMetadataQuery *query;

- (void)loadDocument;



@end

