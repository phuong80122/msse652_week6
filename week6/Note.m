//
//  Note.m
//  week6
//
//  Created by Phuong Nguyen on 4/22/15.
//  Copyright (c) 2015 phuong. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize noteContent;

// Called whenever the application reads data from the file system

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError
{
    if ([contents length] > 0)
    {
        self.noteContent = [[NSString alloc]
                            initWithBytes:[contents bytes]
                            length:[contents length]
                            encoding:NSUTF8StringEncoding];
                          
    } else
    {
        //When the note is first created, assign some default content
        self.noteContent = @"Empty";
        
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"noteModified" object:self];
    
    return YES;
}


// Called whenever the application (auto)saves the content of a note
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError

{
    if ([self.noteContent length] == 0)
    {
        self.noteContent = @"Empty";
    }
    
    return [NSData dataWithBytes:[self.noteContent UTF8String]
                          length:[self.noteContent length]];
            }


@end
