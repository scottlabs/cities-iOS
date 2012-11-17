//
//  AppDelegate.h
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NavigationController.h"
#import <RestKit/RestKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NavigationController *navigationController;
}


@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (strong, nonatomic) NavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
