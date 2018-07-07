# Twitter
FBU Assignment Week 2


# Project 2 - *Twitter*

My Twitter app follows the 

Submitted by: **Nico Salinas**

Time spent: **26** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] App Icon and Launch screen 
* [X] Signing into Twitter app using API keys and loading tweets
* [X] Creating data models for Tweet and User class to take dictionary values and set them to labels
* [X] User can view the past 20 tweets with username, handle, tweet text, buttons, and labels.
* [X] Pull to refresh and reload function
* [X] Favoriting and retweeting
* [X] Logging out function
* [X] Autolayout function


The following **optional** features are implemented:
* [ ] Date pods
* [X] User can tap on tweet to details view controller
* [X] User can unfavorite and unretweet 
* [ ] User can access profile tab
* [ ] Links in tweet are clickable
* [ ] Infinite loading
* [ ] Character countdown
* [ ] User can reply to tweet
* [ ] User can see embedded tweet
* [ ] User can see timeline mentions
* [ ] Profile page
 

The following **additional** features are implemented:

* [X] Added a viewWillLoad method to keep refreshing the tweets if they are favorited or retweeted in the detail view controller
* [X] Created a custom color when changing the color of favorite/retweet labels when they are unretweeted and unfavorited



## Video Walkthrough

Here's a walkthrough of implemented user stories:

Click here for the video [Walkthrough](https://imgur.com/a/LsH6wmB)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

One of the main problems I faced in this project was passing information from the network request to the table view. The reason for this is because I labeled the property to be weak, instead of strong, so the array would be null. Throughout this process, I was able to learn how to debug more and track different outlets and delegates to understand how the app interacts.

One thing that I felt very comfortable with this assignment was auto-layout. I have some experience with graphic design, and the same instincts kicked in when looking at auto-layout. I'm excited to continue working with auto-layout in future projects.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.
- None

## License

Copyright 2018 Nicholas Salinas

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
