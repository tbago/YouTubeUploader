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
//  VideoData.h
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GTLYouTube.h"

@interface VideoData : NSObject

@property(nonatomic, strong) GTLYouTubeVideo *video;
@property(nonatomic, strong) UIImage *thumbnail;
@property(nonatomic, strong) UIImage *fullImage;

- (NSString *)getYouTubeId;
- (NSString *)getTitle;
- (NSString *)getThumbUri;
- (NSString *)getWatchUri;
- (NSString *)getDuration;
- (NSString *)getViews;
- (GTLYouTubeVideoSnippet *)addTags:(NSArray *)tags;

@end
