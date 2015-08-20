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
//  VideoData.m
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import "VideoData.h"

@implementation VideoData

-(NSString *)getYouTubeId {
    return self.video.identifier;
}

-(NSString *)getTitle {
    return self.video.snippet.title;
}

-(NSString *)getThumbUri {
    return self.video.snippet.thumbnails.defaultProperty.url;
}

-(NSString *)getWatchUri {
    return [@"http://www.youtube.com/watch?v=" stringByAppendingString:self.getYouTubeId];
}

-(NSString *)getDuration {
    return self.video.contentDetails.duration;
}

- (NSString *)getViews {
    return [self.video.statistics.viewCount stringValue];
}

-(GTLYouTubeVideoSnippet *)addTags:(NSArray *)newTags {
    GTLYouTubeVideoSnippet *snippet = self.video.snippet;
    NSArray *tags = snippet.tags;
    if (tags == nil){
        snippet.tags = newTags;
    }
    else {
        NSMutableArray *updateTags = [tags mutableCopy];
        [updateTags addObjectsFromArray:newTags];
        snippet.tags = updateTags;
    }
    return snippet;
}

@end
