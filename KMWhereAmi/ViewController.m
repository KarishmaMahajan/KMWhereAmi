//
//  ViewController.m
//  KMWhereAmi
//
//  Created by Student P_02 on 12/10/16.
//  Copyright © 2016 Karishma Mahajan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self startDetectingLocation];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    
    longPress.minimumPressDuration = 2;
    
    [self.myMapView addGestureRecognizer: longPress];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture {
    
    CLLocationCoordinate2D pressedCoordinate;
    
    if (gesture.state ==UIGestureRecognizerStateBegan) {
        CGPoint pressLocation = [gesture locationInView:gesture.view];
        
        pressedCoordinate = [self.myMapView convertPoint:pressLocation toCoordinateFromView:gesture.view];
        
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
        
        myAnnotation.coordinate = pressedCoordinate;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc]init];
        
        CLLocation *location = [[CLLocation alloc]initWithLatitude:pressedCoordinate.latitude longitude:pressedCoordinate.longitude];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",error.localizedDescription);
                myAnnotation.title = @"Unknown Place";
                [self.myMapView addAnnotation:myAnnotation];
            }
            else {
                
                if (placemarks.count > 0) {
                    
                    CLPlacemark *myPlacemark = placemarks.lastObject;
                    
                    NSString *title = [myPlacemark.subThoroughfare stringByAppendingString:myPlacemark.thoroughfare];
                    NSString *subTitle = myPlacemark.locality;
                    
                    myAnnotation.title = title;
                    myAnnotation.subtitle = subTitle;
                    [self.myMapView addAnnotation:myAnnotation];
                    
                }
                else {
                    myAnnotation.title = @"Unknown Place";
                    [self.myMapView addAnnotation:myAnnotation];
                }
                
            }
        }];
        
        
    }
    else if(gesture.state == UIGestureRecognizerStateEnded) {
    
    }
}



-(void)startLocating {
    
    myLocationManager = [[CLLocationManager alloc]init];
    
    myLocationManager.delegate = self;
    
    [myLocationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [myLocationManager requestWhenInUseAuthorization];
    
    [myLocationManager startUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *currentLocation = [locations lastObject];
    
    NSLog(@"Latitude :%f",currentLocation.coordinate.latitude);
    
    NSLog(@"Longitude :%f",currentLocation.coordinate.longitude);
    
    MKCoordinateSpan mySpan = MKCoordinateSpanMake(0.001, 0.001);
    
    MKCoordinateRegion myRegion = MKCoordinateRegionMake(currentLocation.coordinate, mySpan);
    
    [self.myMapView setRegion:myRegion animated:YES];
    
}
    


 -(IBAction)actionStartDetectingLocation:(id)sender {

 [self startLocating];
    
 }

- (IBAction)changeMapType:(id)sender {
    
    UISegmentedControl *segment = sender;
    
    if (segment.selectedSegmentIndex == 0) {
        [self.myMapView setMapType:MKMapTypeStandard];
    }
    else if (segment.selectedSegmentIndex == 1) {
        [self.myMapView setMapType:MKMapTypeSatellite];
    }
    else if (segment.selectedSegmentIndex == 2) {
        [self.myMapView setMapType:MKMapTypeHybrid];
    }
    
    
}
@end
