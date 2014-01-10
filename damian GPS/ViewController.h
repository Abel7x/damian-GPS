//
//  ViewController.h
//  damian GPS
//
//  Created by Abel on 10/01/14.
//  Copyright (c) 2014 Abel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,NSURLConnectionDelegate>{
    CLLocationManager *locationManager;
    NSString *lat;
    NSString *lon;
    NSMutableData *_responseData;
    NSURLConnection *conn;

}

- (IBAction)iniciarServicio:(id)sender;
- (IBAction)detenerServicio:(id)sender;


@end
