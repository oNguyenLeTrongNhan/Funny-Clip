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
   
 
    
    [super setTitleNavigationBar];
    NSString* playlistId = @"PLhBgTdAWkxeCMHYCQ0uuLyhydRJGDRNo5";

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
 
  [self.playerView loadWithPlaylistId:playlistId playerVars:playerVars];

  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receivedPlaybackStartedNotification:)
                                               name:@"Playback started"
                                             object:nil];
    self.dragAndDropController = [[DNDDragAndDropController alloc] init];
    [self.dragAndDropController registerDragSource:self.dragSourceView withDelegate:self];
    [self.dragAndDropController registerDropTarget:self.dropTargetView withDelegate:self];
    
    [self.dragSourceView setBackgroundColor:[UIColor clearColor]];
    [self.dropTargetView setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)buttonPressed:(id)sender {
  if (sender == self.playButton) {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
    [self.playerView playVideo];
  } else if (sender == self.pauseButton) {
    [self.playerView pauseVideo];
  } else if (sender == self.stopButton) {
    [self.playerView stopVideo];
  } else if (sender == self.nextVideoButton) {
    [self appendStatusText:@"Loading next video in playlist\n"];
    [self.playerView nextVideo];
  } else if (sender == self.previousVideoButton) {
    [self appendStatusText:@"Loading previous video in playlist\n"];
    [self.playerView previousVideo];
  }
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
  if([notification.name isEqual:@"Playback started"] && notification.object != self) {
    [self.playerView pauseVideo];
  }
}

/**
 * Private helper method to add player status in statusTextView and scroll view automatically.
 *
 * @param status a string describing current player state
 */
- (void)appendStatusText:(NSString*)status {
  [self.statusTextView setText:[self.statusTextView.text stringByAppendingString:status]];
  NSRange range = NSMakeRange(self.statusTextView.text.length - 1, 1);

  // To avoid dizzying scrolling on appending latest status.
  self.statusTextView.scrollEnabled = NO;
  [self.statusTextView scrollRangeToVisible:range];
  self.statusTextView.scrollEnabled = YES;
}
#pragma mark - Drag Source Delegate

- (UIView *)draggingViewForDragOperation:(DNDDragOperation *)operation {
    UIView *dragView = [UIView new];
    [dragView setFrame:self.playerView.frame];
    [dragView setBackgroundColor:[UIColor clearColor]];
    [dragView addSubview:self.playerView];
    dragView.alpha = 0.0f;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.alpha = 1.0f;
    }];
    return dragView;
}

- (void)dragOperationWillCancel:(DNDDragOperation *)operation {
    [operation removeDraggingViewAnimatedWithDuration:0.2 animations:^(UIView *draggingView) {
        draggingView.alpha = 0.0f;
        draggingView.center = [operation convertPoint:self.dragSourceView.center fromView:self.view];
    }];
}


#pragma mark - Drop Target Delegate

- (void)dragOperation:(DNDDragOperation *)operation didDropInDropTarget:(UIView *)target {
    //target.backgroundColor = operation.draggingView.backgroundColor;
    target.layer.borderColor = [[UIColor clearColor] CGColor];
    [self.playerView setFrame:self.dropTargetView.frame];
    [target addSubview:self.playerView];
}

- (void)dragOperation:(DNDDragOperation *)operation didEnterDropTarget:(UIView *)target {
   // target.layer.borderColor = [operation.draggingView.backgroundColor CGColor];
    [self.dragSourceView setHidden:YES];
}

- (void)dragOperation:(DNDDragOperation *)operation didLeaveDropTarget:(UIView *)target {
  //  target.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
}

@end