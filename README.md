# YouTubeUploader
Based on [yt-direct-lite-ios](https://github.com/youtube/yt-direct-lite-iOS).
The yt-direct-lite-ios project has not been updated for more than two years.Although the code work well for new xcode,but The code itself is out of date.
So I prefer to rewrite part of the code.

##Modify

- Remove  [Google APIs Client Library for Objective-C](http://code.google.com/p/google-api-objectivec-client/) svn dependency. Direct copy & paste some party of source code.
- Using storyboard instead of create UI element in code.
- Modify party of code in Modern Objective C.

##Config YouTube ClientID & Client Secret
First open the [Enable YouTube Data API](https://console.developers.google.com/flows/enableapi?apiid=youtube) link.
Then Open APIs & auth->Credentials link in [Google Console](https://console.developers.google.com).Click Add credentials Button,then choose OAuth 2.0 client ID. For application type choose **Other**(Not iOS type).Then you will get the Client ID and Client Secret.
Then replay my test Client ID & Secret in **Utils.h**.

## License

YouTubeUploader is released under the MIT license. See LICENSE for details.
