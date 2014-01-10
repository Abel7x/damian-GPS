//
//  ViewController.m
//  damian GPS
//
//  Created by Abel on 10/01/14.
//  Copyright (c) 2014 Abel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)iniciarServicio:(id)sender {
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    
    
    if (currentLocation != nil) {
        lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        NSLog(lon);
        NSLog(@"\n%@",lat);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8888/damian.php"]];
        [request setHTTPMethod:@"POST"];
        NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
                              lat,@"latitud",lon,@"longitud",
                              nil];
        NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        NSLog(@"jsonData as string:\n%@",jsonString);
        NSString *stringData = [NSString stringWithFormat:@"data=%@",jsonString];
        [request setHTTPBody:[stringData dataUsingEncoding:NSUTF8StringEncoding]];
        
        // Create url connection and fire request
        conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }
}


- (IBAction)detenerServicio:(id)sender {
    [locationManager stopUpdatingLocation];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    NSString *string = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}
@end
