//
//  AppDelegate.m
//  week6
//
//  Created by Phuong Nguyen on 4/10/15.
//  Copyright (c) 2015 phuong. All rights reserved.
//

#import "AppDelegate.h"
#import <CloudKit/CloudKit.h>

#define kFILENAME @"mydocument.dox"



@interface AppDelegate ()


@end



@implementation AppDelegate


@synthesize doc = _doc;
@synthesize query = _query;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURL *ubiq = [[NSFileManager defaultManager]
                   URLForUbiquityContainerIdentifier:nil];
    if (ubiq) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document...
        
        [self loadDocument];
        
    } else {
        NSLog(@"No iCloud access");
    }
    
    return YES;
}

- (void)loadDocument
{
    NSMetadataQuery *query = [[NSMetadataQuery alloc] init];
    _query = query;
    
    [query setSearchScopes:[NSArray arrayWithObject:NSMetadataQueryUbiquitousDocumentsScope]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", NSMetadataItemFSNameKey, kFILENAME];
    [query setPredicate:pred];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(queryDidFinishGathering:)
     name:NSMetadataQueryDidFinishGatheringNotification
     object:query];
    
    [query startQuery];
}

- (void)queryDidFinishGathering:(NSNotification *)notification
{
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    [query stopQuery];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSMetadataQueryDidFinishGatheringNotification object:query];
    _query = nil;
    
    [self loadData:query];
    
}

- (void)loadData:(NSMetadataQuery *)query
{
    if ([query resultCount] == 1)
    {
        NSMetadataItem *item = [query resultAtIndex:0];
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        Note *doc = [[Note alloc] initWithFileURL:url];
        self.doc = doc;
        
        [self.doc openWithCompletionHandler:^(BOOL success)
         {
             if (success)
             {
                 NSLog(@"iCloud doument opened");
             }
             else
             {
                 NSLog(@"failded opening document from iCloud");
             }
             
         }];
        
    }
    else
    {
        NSURL *ubiq = [[NSFileManager defaultManager]
                        URLForUbiquityContainerIdentifier:nil];
                       
        NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]
                                    URLByAppendingPathComponent:kFILENAME];
                       Note *doc = [[Note alloc] initWithFileURL:ubiquitousPackage];
                       self.doc = doc;
        
        [doc saveToURL:[doc fileURL]
      forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
         {
             if (success)
             {
                 [doc openWithCompletionHandler:^(BOOL success)
                  {

             NSLog(@"new document opened from iCloud");
         }];
             }
        
         }];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
