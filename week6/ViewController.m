//
//  ViewController.m
//  week6
//
//  Created by Phuong Nguyen on 4/10/15.
//  Copyright (c) 2015 phuong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize doc;
@synthesize noteView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataReloaded:)
                                                 name:@"noteModified" object:nil];
}
     
- (void)dataReloaded:(NSNotification *)notification
     {
         self.doc = notification.object;
         self.noteView.text = self.doc.noteContent;
     }
     
- (void)textViewDidChange:(UITextView *)textView
     {
         self.doc.noteContent = textView.text;
         [self.doc updateChangeCount:UIDocumentChangeDone];
     }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.noteView.text = self.doc.noteContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
