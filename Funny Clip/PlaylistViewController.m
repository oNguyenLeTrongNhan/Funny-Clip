// Copyright 2014 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "PlaylistViewController.h"
#import "JSONHTTPClient.h"
#import "NSURLParameters.h"
#import "VideoModel.h"
#import <UIImageView+AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "VideoData.h"
#import "UploadController.h"
#import "VideoListViewController.h"
#import "Utils.h"

@implementation PlaylistViewController
@synthesize youtubeService;
- (void)awakeFromNib{
  
}
// Helper to check if user is authorized
- (BOOL)isAuthorized {
    return [((GTMOAuth2Authentication *)self.youtubeService.authorizer) canAuthorize];
}

// Creates the auth controller for authorizing access to YouTube.
- (GTMOAuth2ViewControllerTouch *)createAuthController
{
    GTMOAuth2ViewControllerTouch *authController;
    
    authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeYouTube
                                                                clientID:kClientID
                                                            clientSecret:kClientSecret
                                                        keychainItemName:kKeychainItemName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and updates the YouTube service
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error {
    if (error != nil) {
        [Utils showAlert:@"Authentication Error" message:error.localizedDescription];
        self.youtubeService.authorizer = nil;
    } else {
        self.youtubeService.authorizer = authResult;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Always display the camera UI.
    [self showList];
}

- (void)showList {
    VideoListViewController *listUI = [[VideoListViewController alloc] init];
    listUI.youtubeService = self.youtubeService;
    [[self navigationController] pushViewController:listUI animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startOAuthFlow:(id)sender {
    GTMOAuth2ViewControllerTouch *viewController;
    
    viewController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:kGTLAuthScopeYouTube
                      clientID:kClientID
                      clientSecret:kClientSecret
                      keychainItemName:kKeychainItemName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    
    [[self navigationController] pushViewController:viewController animated:YES];
}
- (void)viewDidLoad {
  [super viewDidLoad];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
  // [self.listViewColectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectCell"];
    
    //[super setTitleNavigationBar];
    self.listViewColectionView.bounces =NO ;
    [self.navigationController setNavigationBarHidden:YES];
    NSString* videoID = @"9IHb4PBrxYQ";
    [self.playButton setImage:[UIImage imageNamed:@"stop_on.png"] forState:UIControlStateSelected];
  // For a full list of player parameters, see the documentation for the HTML5 player
  // at: https://developers.google.com/youtube/player_parameters?playerVersion=HTML5
 playerVars = @{
    @"controls" : @0,
    @"playsinline" : @1,
    @"autohide" : @1,
    @"showinfo" : @0,
    @"modestbranding" : @1
  };
  self.playerView.delegate = self;
 
  [self.playerView loadWithVideoId:videoID playerVars:playerVars];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receivedPlaybackStartedNotification:)
                                               name:@"Playback started"
                                             object:nil];
    

   // NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&max-results=50&alt=json", @"love"];
    NSString* searchCall= [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?id=TKlh9HLLMMk&key=AIzaSyBhzx8DXhQp4KAHPTBwdv1vYkLUl-QmIlc&part=snippet,contentDetails,statistics,status"];
 
    NSURL *newUrl= [NSURL URLWithString:searchCall];
//    NSURLRequest *request = [NSURLRequest requestWithURL:newUrl];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFImageResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"das");
//        // self.backgroundImageView.image = responseObject;
//        //        [self saveImage:responseObject withFilename:@"background.png"];
//       // [cellScroll.thumnailImg setImage:responseObject];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
//    
//    [operation start];
    
//    
//    [JSONHTTPClient getJSONFromURLWithString: searchCall
//                                  completion:^(NSDictionary *json, JSONModelError *err) {
//                                      
//                                      //got JSON back
//                                      NSLog(@"Got JSON from web: %@", json);
//                                      
//                                      if (err) {
//                                          [[[UIAlertView alloc] initWithTitle:@"Error"
//                                                                      message:[err localizedDescription]
//                                                                     delegate:nil
//                                                            cancelButtonTitle:@"Close"
//                                                            otherButtonTitles: nil] show];
//                                          return;
//                                      }
//                                      
//                                      //initialize the models
//                                      mVideos = [VideoModel arrayOfModelsFromDictionaries:
//                                                json[@"feed"][@"entry"]
//                                                ];
//                                      
//                                      if (mVideos) NSLog(@"Loaded successfully models");
//                                      
//                                      //show the videos
//                                      [self showVideos];
//                                      
//                                  }];
    
    
    
    self.youtubeService = [[GTLServiceYouTube alloc] init];
    self.youtubeService.authorizer =
    [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                          clientID:kClientID
                                                      clientSecret:kClientSecret];
    if (![self isAuthorized]) {
        // Not yet authorized, request authorization and push the login UI onto the navigation stack.
        [[self navigationController] pushViewController:[self createAuthController] animated:YES];
    }
}

- (void) showVideos {
    
    [self.listViewColectionView reloadData];
    
}
#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
 [view registerNib:[UINib nibWithNibName:@"VideoItemCollectCell" bundle:nil] forCellWithReuseIdentifier:@"collectCell"];
    return [mVideos count];

}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.listViewColectionView.frame.size.width/3-10, self.listViewColectionView.frame.size.width/3-10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    VideoItemCollectCell *cellScroll = [cv dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    if (!cellScroll)
    {
        [cv registerNib:[UINib nibWithNibName:@"VideoItemCollectCell" bundle:nil] forCellWithReuseIdentifier:@"collectCell"];
        cellScroll= [cv dequeueReusableCellWithReuseIdentifier:@"collectCell" forIndexPath:indexPath];
    }

    VideoModel *mImageBK= [mVideos objectAtIndex:indexPath.row];
    MediaThumbnail *mThumnail=[mImageBK.thumbnail objectAtIndex:0];
   // NSURL  *VideoURL= ((VideoLink *)[mImageBK.link objectAtIndex:3]).href;
 
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:mThumnail.url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"das");
        // self.backgroundImageView.image = responseObject;
        //        [self saveImage:responseObject withFilename:@"background.png"];
        [cellScroll.thumnailImg setImage:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
    
    [operation start];
  //  [cellScroll.thumnailImg setImage:[UIImage imageNamed:@"television.png"]];
        return cellScroll;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoModel *mImageBK= [mVideos objectAtIndex:indexPath.row];
   
    NSURL  *VideoURL= ((VideoLink *)[mImageBK.link objectAtIndex:0]).href;
    NSString *videoID= VideoURL[@"v"];
    [self.playerView loadWithVideoId:videoID playerVars:playerVars];
    [self.playerView playVideo];

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    mVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"mVideoCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
     
    }

  //  [cell initDataWithVideoInfo: ];
    cell.titleLabel.text=@"daad";
    return cell;
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return self.mListVideo.frame.size.width;
}
- (IBAction)buttonPressed:(id)sender {
  if (sender == self.playButton) {
      if (self.playButton.isSelected) {
          [self.playerView pauseVideo];
          [self.playButton setSelected:NO];

      } else {
          [self.playButton setSelected:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
          [self.playerView playVideo];
      }
  } else if (sender == self.nextVideoButton) {
    //[self appendStatusText:@"Loading next video in playlist\n"];
    [self.playerView nextVideo];
  } else if (sender == self.previousVideoButton) {
    //[self appendStatusText:@"Loading previous video in playlist\n"];
    [self.playerView previousVideo];
  }else if (sender == self.ViewUpDownbtn) {
      //[self appendStatusText:@"Loading previous video in playlist\n"];
      if (!self.ViewUpDownbtn.isSelected) {
          [self.ViewUpDownbtn setSelected:YES];
          [self hideViewScroll];
          //self.moveBannerOffScreen;
          
      } else {
          [self.ViewUpDownbtn setSelected:NO];
          [self ShowViewScroll];

      }
      
       }
}

- (void) hideViewScroll {
    
    self.topSpaceListVideo.constant = self.view.frame.size.height;
    [self.listViewColectionView setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.listViewColectionView layoutIfNeeded];
    }];

}
- (void) ShowViewScroll {
    self.topSpaceListVideo.constant = 50;
    [self.listViewColectionView setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.25f animations:^{
        [self.listViewColectionView layoutIfNeeded];
    }];
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
  if([notification.name isEqual:@"Playback started"] && notification.object != self) {
    //[self.playerView pauseVideo];
  }
}


@end