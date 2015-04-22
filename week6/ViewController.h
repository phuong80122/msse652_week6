//
//  ViewController.h
//  week6
//
//  Created by Phuong Nguyen on 4/10/15.
//  Copyright (c) 2015 phuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"


@interface ViewController : UIViewController <UITextViewDelegate>

@property (strong) Note *doc;


@property (weak) IBOutlet UITextView *noteView;

@end

