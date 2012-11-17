//
//  CityFeedController.m
//  Cities
//
//  Created by Kevin Scott on 11/13/12.
//  Copyright (c) 2012 Kevin Scott. All rights reserved.
//

#import "CityFeedController.h"
#import <RestKit/RKJSONParserJSONKit.h>
#import "Place.h"
#import "Photo.h"

#define FLICKRAPIKEY "48f27a6d623b07e583af141ee307bb93"

@interface CityFeedController ()

@end

@implementation CityFeedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadTimeline
{
    // Load the object model via RestKit
    
    
    //RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[RKURL URLWithString:@"http://www.twitter.com"]];

    //[manager loadObjectsAtResourcePath:@"/status/user_timeline/RestKit" delegate:self];

    
    //

    RKObjectManager* manager = [RKObjectManager managerWithBaseURL:[RKURL URLWithString:@"http://api.flickr.com"]];
    [[RKParserRegistry sharedRegistry] setParserClass:[RKJSONParserJSONKit class] forMIMEType:@"text/javascript"];

    //RKURL *URL = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/venues/search" queryParameters:queryParams];

//    [manager loadObjectsAtResourcePath:@"/services/rest/?method=flickr.places.find&api_key=48f27a6d623b07e583af141ee307bb93&query=new+york+city&format=rest" delegate:self];
    NSString *flickrAPIKey = [NSString stringWithUTF8String:FLICKRAPIKEY];


    //http://api.flickr.com
    ////////////// this is for getting photos
    NSString *place_id = @".skCPTpTVr.Q3WKW";
    NSString *URL = [NSString stringWithFormat:@"/services/rest/?method=flickr.photos.search&api_key=%@&place_id=%@&format=json&nojsoncallback=1", flickrAPIKey, place_id];
    // 16 is street level accuracy
    //World level is 1, Country is ~3, Region ~6, City ~11, Street ~16. Current range is 1-16. The default is 16.
    [manager loadObjectsAtResourcePath:URL delegate:self];
    RKObjectMapping *photoMapping = [RKObjectMapping mappingForClass:[Photo class]];
    [photoMapping mapKeyPathsToAttributes:@"id", @"id", nil];
    [photoMapping mapKeyPathsToAttributes:@"title", @"title", nil];
    [manager.mappingProvider setMapping:photoMapping forKeyPath:@"photos.photo"];
    
    
    
    
    
    
    ////////////// this is for getting a place
    /*
    NSString *URL = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.places.findByLatLon&api_key=%@&lat=%@&lon=%@&accuracy=%@&format=json&nojsoncallback=1", flickrAPIKey, @"40.714",@"-74.007",@"11"];
    // 16 is street level accuracy
    //World level is 1, Country is ~3, Region ~6, City ~11, Street ~16. Current range is 1-16. The default is 16.
    [manager loadObjectsAtResourcePath:URL delegate:self];
    RKObjectMapping *placeMapping = [RKObjectMapping mappingForClass:[Place class]];
    [placeMapping mapKeyPathsToAttributes:@"place_id", @"place_id", nil];
    [placeMapping mapKeyPathsToAttributes:@"woeid", @"woeid", nil];
    [placeMapping mapKeyPathsToAttributes:@"latitude", @"latitude", nil];
    [placeMapping mapKeyPathsToAttributes:@"longitude", @"longitude", nil];
    [placeMapping mapKeyPathsToAttributes:@"place_url", @"place_url", nil];
    [placeMapping mapKeyPathsToAttributes:@"place_type", @"place_type", nil];
    [placeMapping mapKeyPathsToAttributes:@"place_type_id", @"place_type_id", nil];
    [placeMapping mapKeyPathsToAttributes:@"timezone", @"timezone", nil];
    [placeMapping mapKeyPathsToAttributes:@"woe_name", @"woe_name", nil];
    [manager.mappingProvider setMapping:placeMapping forKeyPath:@"places.place"];
    */
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper-1024.png"]];
    self.navigationController.navigationBar.backItem.title = @"Back to Map";
}

- (void)loadView
{
    [super loadView];
    
    // Setup View and Table View
    self.title = @"RestKit Tweets";

  
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self loadTimeline];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark RKObjectLoaderDelegate methods

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response
{
    NSLog(@"Loaded payload: %@", [response bodyAsString]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    //////// getting a photo
//    NSLog(@"Loaded statuses: %@", objects);
    Photo *photo =[objects objectAtIndex:0];
    NSLog(@"Loaded statuses: %@", photo);
    NSLog(@"Loaded statuses: %@", photo.id);
    NSLog(@"Loaded statuses: %@", photo.title);
    return;
    
    //////// getting a place
    Place *p =[objects objectAtIndex:0];
    NSLog(@"Loaded statuses: %@", p);
    NSLog(@"Loaded statuses: %@", p.place_id);
    NSLog(@"Loaded statuses: %@", p.woe_name);
    return;
    
    
    _statuses = objects;
    [_tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
    [alert show];
    NSLog(@"Hit error: %@", error);
}






#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [[[_statuses objectAtIndex:indexPath.row] text] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
    return size.height + 10;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [_statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Tweet Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] ;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
    }
    cell.textLabel.text = [[_statuses objectAtIndex:indexPath.row] text];
    return cell;
}
@end
