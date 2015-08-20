//
//  Copyright (C) 2015 tbago.
//
//  Permission is hereby granted, free of charge, to any person obtaining a 
//  copy of this software and associated documentation files (the "Software"), 
//  to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the 
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in 
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
//  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//
//
//  Utils.m
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import "Utils.h"

@implementation Utils

// Helper for showing a wait indicator in a popup
+ (UIAlertView *)showWaitIndicator:(NSString *)title {
    UIAlertView *progressAlert;
    progressAlert = [[UIAlertView alloc] initWithTitle:title
                                               message:@"Please wait..."
                                              delegate:nil
                                     cancelButtonTitle:nil
                                     otherButtonTitles:nil];
    [progressAlert show];
    
    UIActivityIndicatorView *activityView;
    activityView = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityView.center =
    CGPointMake(progressAlert.bounds.size.width / 2, progressAlert.bounds.size.height - 45);
    
    [progressAlert addSubview:activityView];
    [activityView startAnimating];
    return progressAlert;
}

// Helper for showing an alert
+ (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:message
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat {
    NSRange range = NSMakeRange(0, youTubeTimeFormat.length);
    NSError *error = NULL;
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"PT(\\d*)M(\\d+)S"
                                              options:NSRegularExpressionCaseInsensitive
                                                error:&error];
    NSArray *matches = [regex matchesInString:youTubeTimeFormat options:0 range:range];
    NSString *humanReadable = @"(Unknown)";
    for (NSTextCheckingResult *match in matches) {
        NSRange minuteRange = [match rangeAtIndex:1];
        NSString *minuteString = [youTubeTimeFormat substringWithRange:minuteRange];
        NSRange secRange = [match rangeAtIndex:2];
        NSString *secString = [youTubeTimeFormat substringWithRange:secRange];
        humanReadable =
        [NSString stringWithFormat:@"%01d:%02d", [minuteString intValue], [secString intValue]];
    }
    
    NSLog(@"Translated %@ to %@", youTubeTimeFormat, humanReadable);
    return humanReadable;
    
}

@end
