//
//  GeoCoordinateConverter.m
//  GeoCoordinateConverter
//
//  Created by Volker Voecking on 29.06.14.
//  Copyright (c) 2014 VVSE. All rights reserved.
//
//  It is appreciated but not required that you give credit to Volker Voecking,
//  as the original author of this code. You can give credit in a blog post, a tweet or on
//  a info page of your app. Also, the original author appreciates letting him know if you use this code.
//
//  This code is licensed under the BSD license that is available at:
//  http://www.opensource.org/licenses/bsd-license.php
//

#import "GeoCoordinateConverter.h"

@implementation GeoCoordinateConverter

+ (GeoCoordinateConverter *) sharedConverter {
    
    static GeoCoordinateConverter *sharedConverter;
    
    @synchronized(self) {
        
        if (!sharedConverter) {
            
            sharedConverter = [[GeoCoordinateConverter alloc] init];
        }
        
        return sharedConverter;
    }
}

- (id) init {
    
    self = [super init];
    if ( self != nil ) {
        latlon2UTM = [[LatLon2UTM alloc] init];
        latlon2MGRS = [[LatLon2MGRS alloc] init];
    }
    
    return self;
}


- (NSString *) utmFromLatitude:(double) latitude Longitude:(double) longitude {
    
    return [latlon2UTM convertToUTMFromLatitude:latitude Longitutde:longitude];
}

- (NSString *) mgrsFromLatitude:(double) latitude Longitude:(double) longitude {
    
    return [latlon2MGRS convertToMGRSFromLatitude:latitude Longitude:longitude];
}


@end
