//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "User.h"
#import "ComposeViewController.h"
#import "TweetDetailsViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, TweetDetailsViewControllerDelegate>

@property (nonatomic, strong ) UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *tweetTimelineTableView;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTimelineTableView.dataSource = self;
    self.tweetTimelineTableView.delegate = self;
    
    [self fetchTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    
    [self.tweetTimelineTableView insertSubview:self.refreshControl atIndex:0];
    
}


- (void) fetchTweets {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            self.tweetsArray = tweets;
            
            [self.tweetTimelineTableView reloadData];
            [self.refreshControl endRefreshing];
            
            
            
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}


- (void) didTweet:(Tweet *)tweet{
    
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tweetTimelineTableView reloadData];
    
}

- (void) didInteract: (TweetCell *) cell {
        [cell refreshData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.tweet = self.tweetsArray[indexPath.row];
    
    return cell;
    
}

- (IBAction)tapOnLogout:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    if( [segue.identifier isEqualToString:@"segueToComposeTweetViewController" ] ){
        
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*) navigationController.topViewController;
        composeController.delegate = self;
        
        
    } else if ( [segue.identifier isEqualToString:@"segueToTweetDetailsViewController" ] ){

        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tweetTimelineTableView indexPathForCell:tappedCell];
        
        Tweet *tweet = self.tweetsArray[indexPath.row];
        
        TweetDetailsViewController * tweetDetailViewController = [segue destinationViewController];
        
        tweetDetailViewController.tweet = tweet;
        
    }
}
    @end
