//
//  ViewController.h
//  KMWhereAmi
//
//  Created by Student P_02 on 12/10/16.
//  Copyright © 2016 Karishma Mahajan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate >
{
    CLLocationManager *myLocationManager;
}

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UILabel *labelLatitude;


@property (strong, nonatomic) IBOutlet UILabel *labelLongitude;


- (IBAction)actionStartDetectingLocation:(id)sender;

- (IBAction)changeMapType:(id)sender;






@end

