//
//  SKTableViewController.m
//  BlogReaderScratch
//
//  Created by stephen g on 2/18/14.
//  Copyright (c) 2014 stephen g. All rights reserved.
//

#import "SKTableViewController.h"
#import "SKBlogPost.h"

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
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
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
    
    NSLog(@"date string %@", [self.blogPosts[indexPath.row] date]);
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
