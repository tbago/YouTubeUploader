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
//  Utils.h
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const DEFAULT_KEYWORD  = @"ytdl";
static NSString *const UPLOAD_PLAYLIST  = @"Tbago";

static NSString *const kClientID        = @"304715988357-8vuq0b89imqh0474ri4ceigpn7m145h6.apps.googleusercontent.com";
static NSString *const kClientSecret    = @"rCcqhEdkZsOkQ4bEEqfM6i47";

static NSString *const kKeychainItemName = @"YouTube Uploader";

@interface Utils : NSObject

+ (UIAlertView*)showWaitIndicator:(NSString *)title;

+ (void)showAlert:(NSString *)title message:(NSString *)message;

+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat;

@end
