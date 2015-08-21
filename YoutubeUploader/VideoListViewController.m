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
//  VideoListViewController.m
//  YoutubeUploader
//
//  Created by tbago on 8/20/15.
//

#import "VideoListViewController.h"
#import "Utils.h"
#import "UploadController.h"
#import "VideoPlayerViewController.h"
#import "VideoUploadViewController.h"

@interface VideoListViewController()<YouTubeGetUploadsDelegate,
                                UISearchBarDelegate,
                                UITableViewDataSource,
                                UITableViewDelegate,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate,
                                UITabBarDelegate>

@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"YouTube Uploader";
    self.navigationItem.hidesBackButton = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _getUploads = [[YouTubeGetUploads alloc] init];
    _getUploads.delegate = self;
    _videos = [[NSArray alloc] init];
    
    [self.getUploads getYouTubeUploadsWithService:self.youtubeService];
}

#pragma mark - action
- (IBAction)libraryButtonPressed:(UIBarButtonItem *) sender {
    [self showVideoLibrary];
}

-(IBAction)cameraButtonPressed:(UIBarButtonItem *) sender
{
    [self showCamera];
}


#pragma mark - YouTubeGetUploadsDelegate methods

- (void)getYouTubeUploads:(YouTubeGetUploads *)getUploads didFinishWithResults:(NSArray *)results {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.videos = results;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const kReuseIdentifier = @"ImageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    VideoData *vidData = [self.videos objectAtIndex:indexPath.row];
    cell.imageView.image = vidData.thumbnail;
    cell.textLabel.text = [vidData getTitle];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ -- %@ views",
                                 [Utils humanReadableFromYouTubeTime:vidData.getDuration],
                                 vidData.getViews];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.videos count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoData *selectedVideo = [_videos objectAtIndex:indexPath.row];
    
    VideoPlayerViewController *videoController = [[VideoPlayerViewController alloc] init];
    videoController.videoData = selectedVideo;
    videoController.youtubeService = self.youtubeService;
    
    [[self navigationController] pushViewController:videoController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showCamera {
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        // In case we're running the iPhone simulator, fall back on the photo library instead.
        cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [Utils showAlert:@"Error" message:@"Sorry, iPad Simulator not supported!"];
            return;
        }
    }
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (void)showVideoLibrary {
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    // In case we're running the iPhone simulator, fall back on the photo library instead.
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [Utils showAlert:@"Error" message:@"Sorry, iPad Simulator not supported!"];
        return;
    }
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if (CFStringCompare((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        
        VideoUploadViewController *uploadController = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoUploadViewController"];
        uploadController.videoUrl = videoUrl;
        uploadController.youtubeService = self.youtubeService;
        
        [self.navigationController pushViewController:uploadController animated:YES];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 1) {
        [self showVideoLibrary];
    } else {
        [self showCamera];
    }
    
}

@end
