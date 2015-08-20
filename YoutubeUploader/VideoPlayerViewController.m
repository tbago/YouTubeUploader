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
//  VideoPlayerViewController.m
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import "VideoPlayerViewController.h"
#import "UploadController.h"
#import "Utils.h"

@interface VideoPlayerViewController ()

@end
@implementation VideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    _directTag = [[YouTubeDirectTag alloc] init];
    _directTag.delegate = self;
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"iframe-player" ofType:@"html"];
    NSString *embedHTML =
    [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSString *embedHTMLWithId = [NSString stringWithFormat:embedHTML, _videoData.getYouTubeId];
    
    self.webView = [[UIWebView alloc]
                    initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.webView loadHTMLString:embedHTMLWithId baseURL:[[NSBundle mainBundle] resourceURL]];
    [self.webView setDelegate:self];
    self.webView.allowsInlineMediaPlayback = YES;
    self.webView.mediaPlaybackRequiresUserAction = NO;
    
    [self.view addSubview:_webView];
    
    UIBarButtonItem *submitItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                  target:self
                                                  action:@selector(submitYTDL:)];
    submitItem.title = @"Submit";
    self.toolbarItems = [NSArray arrayWithObjects:submitItem, nil];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    CGRect f = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.webView.frame = f;
}

- (IBAction)submitYTDL:(id)sender {
    [self.directTag directTagWithService:_youtubeService videoData:_videoData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uploadYouTubeVideo

- (void)directTag:(YouTubeDirectTag *)directTag didFinishWithResults:(GTLYouTubeVideo *)video {
    [Utils showAlert:@"Tags Updates" message:[video.snippet.tags componentsJoinedByString:@""]];
}

@end
