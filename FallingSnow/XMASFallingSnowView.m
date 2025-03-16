#import "XMASFallingSnowView.h"
#import <QuartzCore/QuartzCore.h>
#import <float.h>
#import <math.h>
#import <stdlib.h>
#import <stdint.h>

#define kDefaultFlakesCount 1
#define kDefaultFlakeWidth 52.0
#define kDefaultFlakeHeight 23.0
#define kDefaultFlakeFileName @"XMASSnowflake.png"
#define kDefaultMinimumSize 0.4
#define kDefaultAnimationDurationMin 6.0
#define kDefaultAnimationDurationMax 12.0

@implementation XMASFallingSnowView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds          = YES;
        self.backgroundColor        = [UIColor clearColor];
        self.userInteractionEnabled = NO;

        // Set default values
        self.flakesCount          = kDefaultFlakesCount;
        self.flakeWidth           = kDefaultFlakeWidth;
        self.flakeHeight          = kDefaultFlakeHeight;
        self.flakeFileName        = kDefaultFlakeFileName;
        self.flakeMinimumSize     = kDefaultMinimumSize;
        self.animationDurationMin = kDefaultAnimationDurationMin;
        self.animationDurationMax = kDefaultAnimationDurationMax;
    }
    return self;
}

- (void)beginSnowAnimation {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Clean up if we go to the background as CABasicAnimations tend to do odd things then
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSnowAnimationFromNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    // Prepare Vertical Motion Animation
    CABasicAnimation *fallAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    fallAnimation.repeatCount       = HUGE_VALF;
    fallAnimation.autoreverses      = YES;

    CABasicAnimation *sideAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    sideAnimation.repeatCount       = HUGE_VALF;
    sideAnimation.autoreverses      = YES;

    for (UIImageView *flake in self.flakesArray) {
        CGPoint flakeStartPoint     = flake.center;
	float flakeStartX           = flakeStartPoint.x; 
	float flakeStartY           = flakeStartPoint.y;
	float flakeEndX             = self.frame.size.width-(self.flakeWidth/2);
        float flakeEndY             = self.frame.size.height-(self.flakeHeight/2);
	flakeStartPoint.x           = flakeEndX;
	flakeStartPoint.y           = flakeEndY;
        flake.center                = flakeStartPoint;

        // Randomize the time each flake takes to animate to give texture
        fallAnimation.duration = 6.0;
        fallAnimation.fromValue = [NSNumber numberWithFloat:-flakeStartY];

	sideAnimation.duration = 7.0;
	sideAnimation.fromValue = [NSNumber numberWithFloat:-flakeStartX];

        [flake.layer addAnimation:fallAnimation forKey:@"transform.translation.y"];
	[flake.layer addAnimation:sideAnimation forKey:@"transform.translation.x"];
    }
}

- (void)endSnowAnimationFromNotification:(NSNotification *)notification {
    [self endSnowAnimation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginSnowAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
}


- (void)endSnowAnimation {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (UIImageView *flake in self.flakesArray) {
        [flake removeFromSuperview];
    }
    _flakesArray = nil;
}


-(NSMutableArray *)flakesArray {
    if (!_flakesArray) {
        srandomdev();
        self.flakesArray = [[NSMutableArray alloc] initWithCapacity:self.flakesCount];
        // UIImage *flakeImg = [UIImage imageNamed:self.flakeFileName];
        // I'm not really fond of the practice of putting files in a system app directory, even if it is technically harmless :/
        UIImage *flakeImg = [UIImage imageWithContentsOfFile:@"/Library/Application Support/Snoverlay/XMASSnowflake.png"];

        for (int i = 0; i < self.flakesCount; i++) {
            // Randomize Flake size
            float flakeScale = 1.0;

            // Make sure that we don't break the current size rules
            float flakeWidth    = self.flakeWidth * flakeScale;
            float flakeHeight   = self.flakeHeight * flakeScale;

            // Allow flakes to be partially offscreen
            float flakeXPosition = self.frame.size.width - (flakeWidth) - (flakeWidth/2);

            // enlarge content height by 1/2 view height, screen is always well populated
            float flakeYPosition = self.frame.size.height - (flakeHeight) - (flakeHeight/2);
            // flakes start y position is above upper view bound, add view height

            CGRect frame = CGRectMake(flakeXPosition, flakeYPosition, flakeWidth, flakeHeight);

            UIImageView *imageView = [[UIImageView alloc] initWithImage:flakeImg];
            imageView.frame = frame;
            imageView.userInteractionEnabled = NO;

            [self.flakesArray addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return _flakesArray;
}

@end
