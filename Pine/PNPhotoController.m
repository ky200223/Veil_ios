//
//  PNPhotoController.m
//  Pine
//
//  Created by soojin on 6/29/14.
//  Copyright (c) 2014 Recover39. All rights reserved.
//

#import "PNPhotoController.h"
#import "SAMCache.h"

@implementation PNPhotoController

+ (void)imageForThread:(TMPThread *)thread completion:(void (^)(UIImage *))completion
{
    NSString *imageName = thread.imageURL;
    NSString *urlString = [NSString stringWithFormat:@"http://%@/%@", kImageServerURL, imageName];
    
    UIImage *imageFromCache = [[SAMCache sharedCache] imageForKey:imageName];
    if (imageFromCache) {
        completion(imageFromCache);
        return;
    }
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imageURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:urlRequest completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && [httpResponse statusCode] == 200) {
            NSData *data = [NSData dataWithContentsOfURL:location];
            UIImage *image = [UIImage imageWithData:data];
            [[SAMCache sharedCache] setImage:image forKey:imageName];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        } else {
            NSLog(@"bad request error code : %d", [httpResponse statusCode]);
            completion(nil);
        }
    }];
    [task resume];
}

@end