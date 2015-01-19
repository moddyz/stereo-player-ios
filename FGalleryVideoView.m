//
//  FGalleryVideoView.m
//  FirstAVPlayer
//
//  Created by Yuichi Fujiki on 10/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FGalleryVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@implementation FGalleryVideoView

@synthesize videoDelegate = _videoDelegate;
@synthesize playbackButton = _playbackButton;
@synthesize video = _video;
@synthesize scale = _scale;
@synthesize filter = _filter;
@synthesize view = _view;

- (id) initWithFrame:(CGRect)frame 
{
    if(self = [super initWithFrame:frame])
    {
        _isPlaying = NO;
        
        self.backgroundColor = [UIColor blackColor];
        
      
                        
        self.playbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.playbackButton.frame = CGRectMake(self.frame.size.width / 2 - 32, self.frame.size.height / 2 - 32, 64, 64);
        [self.playbackButton setBackgroundImage:[UIImage imageNamed:@"PlayButton.png"] forState:UIControlStateNormal];
        [self.playbackButton addTarget:self action:@selector(togglePlayback:) forControlEvents:UIControlEventTouchUpInside];
                
        [self addSubview:self.playbackButton];
        
        self.view = [[GPUImageView alloc] initWithFrame: CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [self insertSubview:self.view belowSubview:self.playbackButton];
        
        
    }
    return self;
}

- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.view.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height);
    self.playbackButton.frame = CGRectMake(frame.size.width / 2 - 32, frame.size.height / 2 - 32, 64, 64);    
}

+ (Class)layerClass
{
	return [UIView layerClass];
}

/* Specifies how the video is displayed within a player layer’s bounds. 
 (AVLayerVideoGravityResizeAspect is default) */
- (void)setVideoFillMode:(NSString *)fillMode
{
	
}

- (void)togglePlayback:(id)sender 
{
    if(!_isPlaying)
    {
        [self play];
    }
    else
    {
        [self pause];
    }
}

- (void) play
{
    [self.video startProcessing];
    
    [_playbackButton setBackgroundImage:[UIImage imageNamed:@"PauseButton.png"] forState:UIControlStateNormal];
    [self hideControls:NO];
    _isPlaying = YES;
    
    [self.videoDelegate didTapVideoView:self];    
}

- (void) pause
{
    [self.video endProcessing];
    [_playbackButton setBackgroundImage:[UIImage imageNamed:@"PlayButton.png"] forState:UIControlStateNormal];        
    _isPlaying = NO;    
}

- (void)toggleControls 
{
    if(_playbackButton.alpha == 0)
    {
        [self showControls:NO];
    }
    else
    {
        [self hideControls:NO];
    }
}

- (void)showControls:(BOOL)animated {
    NSTimeInterval duration = (animated) ? 0.5 : 0;
    
    [UIView animateWithDuration:duration animations:^() {
        _playbackButton.alpha = 1;
    }];    
}

- (void)hideControls:(BOOL)animated {
    NSTimeInterval duration = (animated) ? 0.5 : 0;
    
    [UIView animateWithDuration:duration animations:^() {
        _playbackButton.alpha = 0;
    }];
}

- (void)hideSelf:(id)sender {
    NSTimeInterval duration = (sender) ? 0.5 : 0;
    
    [UIView animateWithDuration:duration animations:^ {
        self.alpha = 0;
    }];
}

- (void)showSelf:(id)sender {
    NSTimeInterval duration = (sender) ? 0.5 : 0;
    
    [UIView animateWithDuration:duration animations:^ {
        self.alpha = 1;
    }];
        
    [self hideControls:NO];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.video endProcessing];
    [_playbackButton setBackgroundImage:[UIImage imageNamed:@"PlayButton.png"] forState:UIControlStateNormal];        
    _isPlaying = NO;
    
    [self showControls:YES];
}

#pragma mark - touch event
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.tapCount == 1)
    {
        [self toggleControls];
        
        // tell the controller
        if([self.videoDelegate respondsToSelector:@selector(didTapVideoView:)])
            [self.videoDelegate didTapVideoView:self];
    }
}
@end
