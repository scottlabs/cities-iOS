//
//  Server.m
//  Cities
//
//  Created by Kevin Scott on 11/17/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "Server.h"
#import <RestKit/RKJSONParserJSONKit.h>
#import "FeedItem.h"
#import "CityFeedController.h"
@implementation Server

@synthesize manager;

- (void)start {
    //http://localhost/Cities/index.json

    //manager = [RKObjectManager managerWithBaseURL:[RKURL URLWithString:@"http://localhost:5000"]];
    manager = [RKObjectManager managerWithBaseURL:[RKURL URLWithString:@"http://citiesapp.herokuapp.com"]];
    
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/javascript"];
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/html"];
    

    NSString *per_page;
    if ([options objectForKey:@"per_page"]) {
        per_page = [options objectForKey:@"per_page"];
    } else {
        per_page = @"10";
    }
//    http://localhost:5000/feed?latitude=34.052200&longitude=-118.242800
    NSString *URL = [NSString stringWithFormat:@"/feed?latitude=%@&longitude=%@&per_page=%@", city.latitude,city.longitude, per_page];
    NSLog(@"server URL: %@",URL);

    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FeedItem class]];


    [mapping mapKeyPath:@"type" toAttribute:@"type"];
    //[mapping mapKeyPath:@"id" toAttribute:@"item_id"];
    
    [mapping mapKeyPathsToAttributes:@"date", @"date", nil];
    [mapping mapKeyPathsToAttributes:@"content", @"content", nil];

    
    [manager.mappingProvider setMapping:mapping forKeyPath:@"feed"];
    [manager loadObjectsAtResourcePath:URL delegate:self];

}



#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    //NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    //NSLog(@"object loader: %@",objectLoader);
    
    
    if ([[objects objectAtIndex:0] isKindOfClass:[FeedItem class]]) {
        NSLog(@"so now we have items");
        //FeedItem *item =[objects objectAtIndex:0];
        //NSLog(@"first feed item: %@",item);
        
        [callbackObject setFeed:objects];
    }
    //
    
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
    [alert show];
    NSLog(@"Hit error: %@", error);
}



@end
