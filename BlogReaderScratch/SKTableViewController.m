//
//  SKTableViewController.m
//  BlogReaderScratch
//
//  Created by stephen g on 2/18/14.
//  Copyright (c) 2014 stephen g. All rights reserved.
//

#import "SKTableViewController.h"
#import "SKBlogPost.h"
#import "WebViewController.h"

@interface SKTableViewController ()

@end

@implementation SKTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = nil;

    
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];

    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    self.blogPosts = [NSMutableArray array];
    NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    for (NSDictionary *bpDictionary in blogPostsArray) {
        SKBlogPost *blogPost = [SKBlogPost blogPostWithTitle:bpDictionary[@"title"]];
        blogPost.author = bpDictionary[@"author"];
        blogPost.thumbnail = bpDictionary[@"thumbnail"];
        blogPost.date = bpDictionary[@"date"];
        blogPost.url = [NSURL URLWithString:bpDictionary[@"url"]];
        [self.blogPosts addObject:blogPost];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.blogPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    if([[self.blogPosts[indexPath.row] thumbnail] isKindOfClass:[NSString class]]){
        NSData *imageData = [NSData dataWithContentsOfURL:[self.blogPosts[indexPath.row] thumbnailURL]];
        cell.imageView.image = [UIImage imageWithData:imageData];
    } else{
        cell.imageView.image = [UIImage imageNamed:@"treehouse"];
    }

    cell.textLabel.text = [self.blogPosts[indexPath.row] title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",[self.blogPosts[indexPath.row] author], [self.blogPosts[indexPath.row] formattedDate]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showBlogPost"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SKBlogPost *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
        [segue.destinationViewController setBlogPostURL:blogPost.url];
    }
}


@end


