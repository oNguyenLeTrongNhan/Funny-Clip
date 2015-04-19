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


@implementation PlaylistViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
 
    
    //[super setTitleNavigationBar];
    
    [self.navigationController setNavigationBarHidden:YES];
    NSString* videoID = @"PLy_TpcUT2LZvHD8JXHdJ4oe_UCWRjHB2I";
    [self.playButton setImage:[UIImage imageNamed:@"stop_on.png"] forState:UIControlStateSelected];
  // For a full list of player parameters, see the documentation for the HTML5 player
  // at: https://developers.google.com/youtube/player_parameters?playerVersion=HTML5
  NSDictionary *playerVars = @{
    @"controls" : @0,
    @"playsinline" : @1,
    @"autohide" : @1,
    @"showinfo" : @0,
    @"modestbranding" : @1
  };
  self.playerView.delegate = self;
 
  [self.playerView loadWithPlaylistId:videoID playerVars:playerVars];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receivedPlaybackStartedNotification:)
                                               name:@"Playback started"
                                             object:nil];
    [[[self.mTabbar items ] objectAtIndex:0] setTitle:@"das"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    mVideoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"mVideoCell" bundle:nil] forCellReuseIdentifier:@"videoCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
     
    }
    VideoInfoModel *mVideoInfo;
    //[mVideoInfo ];
  //  [cell initDataWithVideoInfo: ];
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
  }
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
  if([notification.name isEqual:@"Playback started"] && notification.object != self) {
    //[self.playerView pauseVideo];
  }
}


@end