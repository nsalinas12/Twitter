//
//  TweetCell.m
//  twitter
//
//  Created by Nico Salinas on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import <UIKit/UIKit.h>


@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.retweetButton.selected = self.tweet.retweeted;
    self.likeButton.selected = self.tweet.favorited;
    
    self.usernameLabel.text = self.tweet.usernameStr;
    self.handleLabel.text = self.tweet.handleStr;
    
    self.tweetTextLabel.text = self.tweet.text;
    
    self.datelineLabel.text = self.tweet.createdAtString;
    
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.profileImageView.image = nil;
    if (self.tweet.profileImageUrl != nil) {
        [self.profileImageView setImageWithURL:self.tweet.profileImageUrl];
    }
    self.profileImageView.layer.cornerRadius = 25;
    [self refreshData];
    
}

- (void) refreshData {
    
    
    UIColor *mainColor = [UIColor colorWithRed:173/255.0
                                         green:184/255.0
                                          blue:194/255.0
                                         alpha:1];
    
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.retweetButton.selected = self.tweet.retweeted;
    self.likeButton.selected = self.tweet.favorited;
    
    if( self.retweetButton.selected == YES ){
        
        self.retweetCountLabel.textColor = UIColor.greenColor;
        
    } else {
        
        self.retweetCountLabel.textColor = mainColor;
    }
    
    if( self.likeButton.selected == YES ){
        
        self.favoriteCountLabel.textColor = UIColor.redColor;
        
    } else {
        
        self.favoriteCountLabel.textColor = mainColor;
    }
    
}

- (IBAction)didTapRetweet:(id)sender {
    
    UIColor *mainColor = [UIColor colorWithRed:173/255.0
                                         green:184/255.0
                                          blue:194/255.0
                                         alpha:1];
    
    NSLog(@"Tapped Retweet 🔵🔵🔵 Button");
    
    if( self.tweet.retweeted == YES ){
        
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        self.retweetButton.selected = NO;
        self.retweetCountLabel.textColor = mainColor;
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    } else if ( self.tweet.retweeted == NO ){
        
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        self.retweetButton.selected = YES;
        self.retweetCountLabel.textColor = UIColor.greenColor;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
        
    }
    
    [self refreshData];
    
}

- (IBAction)didTapFavorite:(id)sender {
    
    UIColor *mainColor = [UIColor colorWithRed:173/255.0
                                         green:184/255.0
                                          blue:194/255.0
                                         alpha:1];
    
    NSLog(@"Tapped Favorite ❤️❤️❤️ Button");
    
    if( self.tweet.favorited == YES ){
        
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        self.likeButton.selected = NO;
        self.favoriteCountLabel.textColor = mainColor;
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
        
        
    } else if( self.tweet.favorited == NO ){
        
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.likeButton.selected = YES;
        self.favoriteCountLabel.textColor = UIColor.redColor;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    
    [self refreshData];
}


@end
