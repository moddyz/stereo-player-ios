//
//  GPUVideoView.h
//  By Richard Lei
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@protocol GPUVideoViewDelegate;

@interface GPUVideoView : UIView {
    BOOL _isPlaying;
}

@property (nonatomic,unsafe_unretained) NSObject <GPUVideoViewDelegate> *videoDelegate;
@property (nonatomic, retain) UIButton * playbackButton;
@property (nonatomic, retain) AVPlayer * player;
@property (nonatomic, retain) GPUImageMovie * video;
@property (nonatomic, retain) GPUImageSharpenFilter * filter;
@property (nonatomic, retain) GPUImageView * view;

- (void)setVideoFillMode:(NSString *)fillMode;

- (void)togglePlayback:(id)sender;
- (void)play;
- (void)pause;

- (void)toggleControls;
- (void)showControls:(BOOL)animated;
- (void)hideControls:(BOOL)animated;
- (void)hideSelf:(id)sender;
- (void)showSelf:(id)sender;

- (void)playerItemDidReachEnd:(NSNotification *)notification;

@end

@protocol GPUVideoViewDelegate

// indicates single touch and allows controller repsond and go toggle fullscreen
- (void)didTapVideoView:(GPUVideoView*)videoView;

@end
