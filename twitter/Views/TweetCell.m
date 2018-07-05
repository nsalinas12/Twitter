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
    
    self.usernameLabel.text = self.tweet.usernameStr;
    self.handleLabel.text = self.tweet.handleStr;
    
    self.tweetTextLabel.text = self.tweet.text;
    
    
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.profileImageView.image = nil;
    if (self.tweet.profileImageUrl != nil) {
        [self.profileImageView setImageWithURL:self.tweet.profileImageUrl];
    }
    
}

- (void) refreshData {
    
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
}

- (IBAction)didTapRetweet:(id)sender {
    
    NSLog(@"Tapped Retweet 🔵🔵🔵 Button");
    
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    
    
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
    
    [self refreshData];
    
}

- (IBAction)didTapFavorite:(id)sender {
    
     NSLog(@"Tapped Favorite ❤️❤️❤️ Button");
    
    
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    
    [self refreshData];

    
}


@end
