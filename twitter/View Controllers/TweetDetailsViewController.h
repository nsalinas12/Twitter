//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by Nico Salinas on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetCell.h"
#import "TimelineViewController.h"

@class TweetCell;

@protocol TweetDetailsViewControllerDelegate

- (void) didInteract: (TweetCell*) cell;

@end

@interface TweetDetailsViewController : UIViewController

@property (nonatomic, weak) id<TweetDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) Tweet *tweet;

- (void) loadTweet;

@end
