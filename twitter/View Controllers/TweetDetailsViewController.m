//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by Nico Salinas on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "TimelineViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTweet];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadTweet{
    
    self.profileImageView.image = nil;
    if (self.tweet.profileImageUrl != nil) {
        [self.profileImageView setImageWithURL:self.tweet.profileImageUrl];
    }
    
    self.profileImageView.layer.cornerRadius = 25;
    self.usernameLabel.text = self.tweet.usernameStr;
    self.handleLabel.text = self.tweet.handleStr;
    self.tweetTextLabel.text = self.tweet.text;
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
   self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    self.dateLabel.text = self.tweet.createdAtString;
    
    self.retweetButton.selected = self.tweet.retweeted;
    self.favoriteButton.selected = self.tweet.favorited;
    
    
}


- (void) refreshData {
    
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.retweetButton.selected = self.tweet.retweeted;
    self.favoriteButton.selected = self.tweet.favorited;
    
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
        self.favoriteButton.selected = NO;
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
        self.favoriteButton.selected = YES;
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

/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
