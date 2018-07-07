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


@interface TweetDetailsViewController : UIViewController


@property (weak, nonatomic) Tweet *tweet;

- (void) loadTweet;

@end
